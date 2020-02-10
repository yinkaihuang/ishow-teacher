package cn.ishow.educate.base.service.impl;
/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import cn.ishow.common.enu.BusinessError;
import cn.ishow.common.exception.BizRuntimeException;
import cn.ishow.educate.base.mapper.FileMapper;
import cn.ishow.educate.base.model.po.FilePO;
import cn.ishow.educate.base.model.vo.FilePositionVO;
import cn.ishow.educate.base.model.vo.FileVO;
import cn.ishow.educate.base.service.IFileService;
import cn.ishow.educate.lib.util.WebUtils;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.Strings;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.Date;
import java.util.Random;

/**
 * @author yinchong
 * @create 2019/11/26 16:20
 * @description
 */
@Service
@Slf4j
public class FileServiceImpl extends ServiceImpl<FileMapper, FilePO> implements IFileService {

    public static final String RANGE = "Range";
    public static final String ACCEPT_RANGES = "Accept-Ranges";
    public static final String BYTES = "bytes";

    @Override
    public FilePositionVO obtainPosition(FileVO fileVO) {
        String md5 = fileVO.getMd5();
        FilePO filePO = baseMapper.findByMd5(md5);
        FilePositionVO filePosition = new FilePositionVO();
        if (filePO == null) {
            filePO = saveFileToDB(fileVO, md5);
        }
        filePosition.setId(filePO.getId());
        filePosition.setStartPosition(filePO.getPosition());
        return filePosition;
    }

    @Override
    public String upload(Long id, Long position) {
        FilePO filePO = baseMapper.selectById(id);
        if (filePO == null) {
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "id有误");
        }
        if (filePO.getPosition() >= filePO.getLength()) {
            return "上传成功";
        }
        if (position > filePO.getPosition()) {
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "偏移量上传有误");
        }
        byte[] buf = new byte[1024 * 5];
        int length = -1;
        long currentLength = position;
        int number = 0;
        try (
                BufferedInputStream bis = new BufferedInputStream(WebUtils.request().getInputStream());
                RandomAccessFile rf = new RandomAccessFile(filePO.getPath(), "rw");
        ) {
            rf.seek(position);
            while ((length = bis.read(buf)) > 0) {
                currentLength += length;
                number++;
                rf.write(buf, 0, length);
                if (number % 1024 == 0) {
                    baseMapper.updatePosition(filePO.getId(), currentLength);
                }
            }
            baseMapper.updatePosition(filePO.getId(), currentLength);
            if (currentLength < filePO.getLength()) {
                log.warn("文件未完成上传");
                throw new BizRuntimeException(BusinessError.SERVER_FAIL, "文件未完成上传");
            }
        } catch (Exception e) {
            log.error("upload file fail,cause:{}", e);
            throw new BizRuntimeException(BusinessError.SERVER_FAIL, "文件上传失败");
        }
        return "上传成功";
    }

    @Override
    public void show(Long id) {
        FilePO filePO = baseMapper.selectById(id);
        if (filePO.getPosition() < filePO.getLength()) {
            return;
        }
        try {
            IOUtils.copy(new BufferedInputStream(new FileInputStream(filePO.getPath())), WebUtils.getOutputStream());
        } catch (Exception e) {
            log.error("show happen error:", e);
            throw new RuntimeException(e);
        }
    }

    @Override
    public void showVideo(Long id) {
        FilePO filePO = baseMapper.selectById(id);
        if (filePO.getPosition() < filePO.getLength()) {
            return;
        }
        //获取交互的数据
        String range = WebUtils.getHeader(RANGE);
        log.info("show range:{}", range);
        if (!Strings.isBlank(range)) {
            int length = 2 * 1024 * 1024;
            String[] ranges = range.split("=")[1].split("-");
            long startIndex = Long.parseLong(ranges[0]);
            long endIndex = startIndex + length - 1;
            WebUtils.setHeader(ACCEPT_RANGES, BYTES);
            if (ranges.length == 2 && !Strings.isBlank(ranges[1])) {
                endIndex = Long.parseLong(ranges[1]);
            }

            if (endIndex <= startIndex) {
                endIndex = startIndex + length - 1;
            }
            if (endIndex > filePO.getLength() - 1) {
                endIndex = filePO.getLength() - 1;
            }

            //设置响应的长度
            WebUtils.setHeader("Content-Range", "bytes " + startIndex + "-" + endIndex + "/" + filePO.getLength());
            WebUtils.setHttpCode(206);

            RandomAccessFile accessFile = null;
            try {
                accessFile = new RandomAccessFile(filePO.getPath(), "r");
                accessFile.seek(startIndex);
                byte[] buffer = new byte[(int) (endIndex - startIndex + 1)];
                int len = 0;
                if ((len = accessFile.read(buffer)) > 0) {
                    WebUtils.getOutputStream().write(buffer, 0, len);
                }
            } catch (Exception e) {
                log.error("show error:", e);
                throw new RuntimeException(e);
            } finally {
                if (accessFile != null) {
                    try {
                        accessFile.close();
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }
            }
        } else {
            try {
                IOUtils.copy(new BufferedInputStream(new FileInputStream(filePO.getPath())), WebUtils.getOutputStream());
            } catch (Exception e) {
                log.error("show happen error:", e);
                throw new RuntimeException(e);
            }
        }

    }

    private FilePO saveFileToDB(FileVO fileVO, String md5) {
        FilePO filePO;
        filePO = new FilePO();
        filePO.setMd5(md5);
        filePO.setLength(fileVO.getLength());
        filePO.setName(fileVO.getName());
        filePO.setPosition(0L);
        filePO.setEnable(true);
        filePO.setCreateDate(new Date());
        filePO.setUpdateDate(new Date());
        String path = randomPath();
        String filePath = path + System.currentTimeMillis() + filePO.getName();
        createFile(filePath, fileVO.getLength());
        filePO.setPath(filePath);
        baseMapper.insert(filePO);
        return filePO;
    }

    private void createFile(String filePath, Long length) {
        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                log.error("create file fail,cause:", e);
                throw new RuntimeException("create file fail,cause:", e);
            }
        }
        try (RandomAccessFile rf = new RandomAccessFile(file, "rw");) {
            rf.setLength(length);
        } catch (Exception e) {
            log.error("create random file fail,cause:{}", e);
            throw new RuntimeException("create random file fail");
        }
    }

    private String randomPath() {
        String root = "/data/";
        StringBuilder sb = new StringBuilder(root);
        Random random = new Random();
        for (int i = 0; i < 4; i++) {
            int index = random.nextInt(50);
            sb.append(index).append("/");
        }
        String path = sb.toString();
        createDirs(path);
        return path;
    }

    private void createDirs(String dirs) {
        File file = new File(dirs);
        if (file.exists()) {
            return;
        }
        file.mkdirs();
    }
}
