package cn.ishow.teacher.controller;
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

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @author yinchong
 * @create 2019/12/5 9:51
 * @description
 */
@Slf4j
@Controller
@RequestMapping("email")
public class EmailController {

    @Value("${from.eamil:863224759@qq.com}")
    private String fromEamil;
    @Value("${from.code:ttiglnwtfhttbeba}")
    private String licenseCode;

    @RequestMapping("sendEmail")
    public void sendEmail(HttpServletRequest request){
        try {
            Map<String, String[]> parameterMap = request.getParameterMap();

            for (Object o : parameterMap.keySet()) {
                System.out.println(o + ":" + parameterMap.get(o)[0].toString());
            }
            try {
                HtmlEmail email = new HtmlEmail();
                email.setHostName("smtp.qq.com");
                email.setCharset("utf-8");
                email.addTo(parameterMap.get("to")[0]);
                email.setFrom(fromEamil);
                email.setAuthentication(fromEamil, licenseCode);
                email.setSubject(parameterMap.get("value")[0].substring(0, 16));
                email.setMsg(parameterMap.get("value")[0]);
                email.send();
            } catch (EmailException e) {
                e.printStackTrace();
            }
            log.info("============================发送告警=========================================");
        }catch (Exception e){
            log.error("发送告警失败，cause：",e);
        }
    }
}
