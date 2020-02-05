package cn.ishow.educate.role.service;

import cn.ishow.educate.common.model.vo.BaseVO;
import cn.ishow.educate.common.model.vo.ResultVO;
import cn.ishow.educate.role.model.po.UserPO;
import cn.ishow.educate.role.model.vo.UserVO;
import com.baomidou.mybatisplus.service.IService;

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
public interface IUserService extends IService<UserPO> {
    String checkAccount(String account);

    String register(UserVO userVO);

    String login(String account, String password,boolean force);

    String logout();

    ResultVO listRecord(int roleType, BaseVO baseVO);
}