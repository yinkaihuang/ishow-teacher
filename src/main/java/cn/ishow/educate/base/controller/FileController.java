package cn.ishow.educate.base.controller;
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
import cn.ishow.educate.base.model.vo.FilePositionVO;
import cn.ishow.educate.base.model.vo.FileVO;
import cn.ishow.educate.base.service.IFileService;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
public class FileController {
    @Autowired
    private IFileService fileService;

    @RequestMapping("obtainPosition")
    private FilePositionVO obtainPosition(@Validated FileVO fileVO) {
        try {
            FilePositionVO filePositionVO = fileService.obtainPosition(fileVO);
            return filePositionVO;
        } catch (RuntimeException e) {
            log.error("obtainPosition fail, fileVO:{} cause:{}", fileVO, e);
            throw e;
        }
    }

    @RequestMapping("uploadFile")
    private String uploadFile(@RequestHeader Long id, @RequestHeader Long position) {
        try {
            if (id == null || position == null) {
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "参数校验失败");
            }
            String result = fileService.upload(id, position);
            return result;
        } catch (RuntimeException e) {
            log.error("uploadFile fail, id:{} position:{} cause:{}", id, position, e);
            throw e;
        }
    }
}
