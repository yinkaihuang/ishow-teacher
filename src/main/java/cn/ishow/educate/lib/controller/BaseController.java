package cn.ishow.educate.lib.controller;
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

import cn.ishow.educate.lib.util.WebUtils;
import cn.ishow.educate.role.model.po.UserPO;

/**
 * @author yinchong
 * @create 2020/2/7 16:36
 * @description
 */
public class BaseController {

    /**
     * 获取用户角色，如果用户未登入则返回null
     *
     * @return
     */
    protected Integer userType() {
        UserPO user = WebUtils.getUser();
        if (user == null) {
            return null;
        }
        return user.getRole();
    }


}
