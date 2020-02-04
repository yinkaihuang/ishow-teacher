package cn.ishow.teacher.util;
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

import cn.ishow.teacher.model.po.UserPO;
import lombok.Data;
import org.apache.logging.log4j.util.Strings;

import java.util.concurrent.ConcurrentHashMap;

/**
 * @author yinchong
 * @create 2019/11/24 20:55
 * @description
 */
public class TokenUserHolder {
    private static ConcurrentHashMap<String, TimeOutUser> tokenUserCache = new ConcurrentHashMap<>(100);

    private static ConcurrentHashMap<String, String> accountTokenCache = new ConcurrentHashMap<>();

    public static void addUser(String token, UserPO user) {
        TimeOutUser timeOutUser = new TimeOutUser();
        timeOutUser.setStartTime(System.currentTimeMillis());
        timeOutUser.setUser(user);
        tokenUserCache.put(token, timeOutUser);
        accountTokenCache.put(user.getLoginAccount(), token);
    }

    public static UserPO getUser(String token) {
        TimeOutUser timeOutUser = tokenUserCache.get(token);
        if (timeOutUser == null) {
            return null;
        }
        return timeOutUser.getUser();
    }

    public static boolean exist(String account) {
        String token = accountTokenCache.get(account);
        if (Strings.isBlank(token)) {
            return false;
        }
        return true;
    }

    public static void removeByToken(String token) {
        TimeOutUser timeOutUser = tokenUserCache.get(token);
        if (timeOutUser == null) {
            return;
        }
        String account = timeOutUser.getUser().getLoginAccount();
        accountTokenCache.remove(account);
    }

    public static void removeByAccount(String account) {
        String token = accountTokenCache.get(account);
        if (Strings.isBlank(token)) {
            return;
        }
        accountTokenCache.remove(account);
        tokenUserCache.remove(token);
    }

    @Data
    private static class TimeOutUser {
        private long startTime;
        private UserPO user;
    }
}
