package cn.ishow.teacher.base.controller;
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
import cn.ishow.teacher.model.vo.FilePositionVO;
import cn.ishow.teacher.model.vo.FileVO;
import cn.ishow.teacher.service.IFileService;
import com.dianping.cat.Cat;
import com.dianping.cat.message.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author yinchong
 * @create 2019/11/26 16:18
 * @description
 */
@RestController
@RequestMapping("file")
public class FileController {
    @Autowired
    private IFileService fileService;

    @RequestMapping("obtainPosition")
    private FilePositionVO obtainPosition(@Validated FileVO fileVO) {
        Transaction transaction = Cat.newTransaction("fileController", "obtainPosition");
        try {
            FilePositionVO filePositionVO = fileService.obtainPosition(fileVO);
            transaction.setSuccessStatus();
            return filePositionVO;
        } catch (RuntimeException e) {
            transaction.setStatus(e);
            Cat.logError(e);
            transaction.addData("fileVO", fileVO);
            throw e;
        } finally {
            transaction.complete();
        }
    }

    @RequestMapping("uploadFile")
    private String uploadFile(@RequestHeader Long id, @RequestHeader Long position) {
        Transaction transaction = Cat.newTransaction("fileController", "uploadFile");
        try {
            if (id == null || position == null) {
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "参数校验失败");
            }
            String result = fileService.upload(id, position);
            transaction.setSuccessStatus();
            Cat.logMetricForCount("断点上传文件成功");
            return result;
        } catch (RuntimeException e) {
            Cat.logError(e);
            transaction.setStatus(e);
            transaction.addData("id", id);
            transaction.addData("position", position);
            Cat.logMetricForCount("断点上传文件失败");
            throw e;
        } finally {
            transaction.complete();
        }
    }
}
