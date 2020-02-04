package cn.ishow.teacher.lib.util;
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

import cn.ishow.teacher.lib.enu.Educate;
import cn.ishow.teacher.role.model.po.UserPO;
import org.apache.logging.log4j.util.Strings;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * @author yinchong
 * @create 2019/11/24 21:06
 * @description
 */
public class WebUtils {

    private static ServletRequestAttributes attributes() {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        return attributes;
    }

    public static UserPO getUser(){
       String token = getToken();
       if(Strings.isBlank(token)){
           return null;
       }
       return TokenUserHolder.getUser(token);
    }


    public static HttpServletRequest request() {
        ServletRequestAttributes attributes = attributes();
        if (attributes == null) {
            return null;
        }
        return attributes.getRequest();
    }

    public static String getToken() {
        HttpServletRequest request = request();
        if (request == null) {
            return null;
        }
        return request.getHeader(Educate.USER_TOKEN);
    }
}
