package cn.ishow.educate.lib.util;
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

import cn.ishow.educate.lib.enu.Educate;
import cn.ishow.educate.lib.holder.UserCache;
import cn.ishow.educate.role.model.po.UserPO;
import org.apache.logging.log4j.util.Strings;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.OutputStream;

/**
 * @author yinchong
 * @create 2019/11/24 21:06
 * @description
 */
public class WebUtils {

    public static final String USER_TOKEN = "user_token";

    private static ServletRequestAttributes attributes() {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        return attributes;
    }

    public static OutputStream getOutputStream()throws Exception{
       return attributes().getResponse().getOutputStream();
    }

    public static UserPO getUser() {
        String token = getTokenFromRequest();
        if (Strings.isBlank(token)) {
            token = getTokenFromSession();
        }
        if (Strings.isBlank(token)) {
            return null;
        }
        return UserCache.getInstance().getUser(token);
    }


    public static HttpServletRequest request() {
        ServletRequestAttributes attributes = attributes();
        if (attributes == null) {
            return null;
        }
        return attributes.getRequest();
    }

    public static HttpSession getSession() {
        return attributes().getRequest().getSession();
    }

    public static void saveTokenToSession(String token) {
        getSession().setAttribute(USER_TOKEN, token);
    }

    public static void removeTokenFromSession(){
        getSession().removeAttribute(USER_TOKEN);
    }


    public static String getTokenFromSession() {
        return (String) getSession().getAttribute(USER_TOKEN);
    }

    public static String getTokenFromRequest() {
        HttpServletRequest request = request();
        if (request == null) {
            return null;
        }
        return request.getHeader(Educate.USER_TOKEN);
    }
}
