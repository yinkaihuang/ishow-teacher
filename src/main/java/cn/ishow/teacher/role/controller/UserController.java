package cn.ishow.teacher.role.controller;
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
import cn.ishow.teacher.lib.constant.TeacherConstant;
import cn.ishow.teacher.role.model.vo.UserVO;
import cn.ishow.teacher.role.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author yinchong
 * @create 2019/11/24 16:56
 * @description
 */
@RestController
@RequestMapping("user")
@Slf4j
public class UserController {
    @Value("${spring.application.name}")
    private String application;
    @Autowired
    private IUserService userService;

    @RequestMapping("register")
    public String register(@Validated UserVO userVO) {
        try {
            if (!userVO.getPassword().equals(userVO.getPassword2())) {
                log.warn("两次密码不一致,password:{}, password2:{}", userVO.getPassword(), userVO.getPassword2());
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "两次密码不一致");
            }
            if (userVO.getRole() != TeacherConstant.STUDENT_ROLE || userVO.getRole() == TeacherConstant.TEACHER_ROLE) {
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "请输出正确角色");
            }
            String result = userService.register(userVO);
            return result;
        } catch (RuntimeException e) {
            throw e;
        }
    }

    @RequestMapping("checkAccount")
    public String checkAccount(String account) {
        try {
            if (Strings.isBlank(account)) {
                log.warn("账号不能为空");
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "请输入账号");
            }
            return userService.checkAccount(account);
        } catch (RuntimeException e) {
            throw e;
        }
    }

    @RequestMapping("supply")
    public String supplyUser(UserVO userVO) {
        return "";
    }

    @RequestMapping("logout")
    public String logout() {
        return userService.logout();
    }

    @RequestMapping("login")
    public String login(String account, String password, boolean force) {
        try {
            if (Strings.isBlank(account)) {
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "账号不为空");
            }
            if (Strings.isBlank(password)) {
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "密码不能为空");
            }
            String result = userService.login(account, password, force);
            return result;
        } catch (RuntimeException e) {
            log.error("login fail, account:{} password:{} force:{} cause:{}", account, password, force, e);
            throw e;
        }
    }
}
