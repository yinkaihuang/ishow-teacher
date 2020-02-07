package cn.ishow.educate.role.mapper;
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

import cn.ishow.educate.role.model.po.UserPO;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author yinchong
 * @create 2019/11/24 16:46
 * @description
 */
public interface UserMapper extends BaseMapper<UserPO> {
    int checkAccount(@Param("account") String account);

    UserPO findByAccountAndPassword(@Param("account") String account,@Param("password") String password,@Param("role")Integer role);


    List<UserPO> findPage(Page page, int roleType, String search);
}
