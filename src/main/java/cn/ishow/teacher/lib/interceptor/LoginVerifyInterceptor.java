package cn.ishow.teacher.lib.interceptor;
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
import cn.ishow.teacher.lib.util.TokenUserHolder;
import cn.ishow.teacher.lib.util.WebUtils;
import cn.ishow.teacher.role.model.po.UserPO;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author yinchong
 * @create 2019/11/24 21:23
 * @description
 */
@Order(0)
@Component
@Slf4j
public class LoginVerifyInterceptor implements HandlerInterceptor {

    @Value("${not.need.login:/educate/user/login,/educate/user/register,/educate/email/sendEmail}")
    private String noNeedLogin;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
       try {
            String uri = request.getRequestURI();
            if (noNeedLogin.contains(uri)) {
                return true;
            }
            String token = WebUtils.getToken();
            if (Strings.isBlank(token)) {
                throw new BizRuntimeException(BusinessError.NO_LOGIN_FAIL, "请重新登录");
            }
            UserPO userPO = TokenUserHolder.getUser(token);
            if (userPO == null) {
                throw new BizRuntimeException(BusinessError.NO_LOGIN_FAIL, "请重新登录");
            }
            return true;
        } catch (RuntimeException e) {
            log.error("error message:{}", e);
            throw e;
        }
    }
}
