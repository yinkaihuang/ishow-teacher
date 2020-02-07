package cn.ishow.educate.role.service.impl;
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
import cn.ishow.educate.common.model.vo.BaseVO;
import cn.ishow.educate.common.model.vo.ResultVO;
import cn.ishow.educate.lib.enu.RoleEnum;
import cn.ishow.educate.lib.enu.StatusEnum;
import cn.ishow.educate.lib.util.MyPageUtil;
import cn.ishow.educate.lib.holder.UserCache;
import cn.ishow.educate.lib.util.WebUtils;
import cn.ishow.educate.role.mapper.UserMapper;
import cn.ishow.educate.role.model.po.UserPO;
import cn.ishow.educate.role.model.vo.UserVO;
import cn.ishow.educate.role.service.IUserService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author yinchong
 * @create 2019/11/24 16:54
 * @description
 */
@Service
@Slf4j
public class UserServiceImpl extends ServiceImpl<UserMapper, UserPO> implements IUserService {
    @Override
    public String checkAccount(String account) {
        int count = baseMapper.checkAccount(account);
        if (count > 0) {
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "账号已经存在");
        }
        return "success";
    }

    @Override
    public String register(UserVO userVO) {
        int count = baseMapper.checkAccount(userVO.getLoginAccount());
        if (count > 0) {
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "账号已经存在");
        }
        UserPO userPO = new UserPO();
        BeanUtils.copyProperties(userVO, userPO);
        if (userPO.getRole() != RoleEnum.TEACHER.getCode()) {
            userPO.setEnable(true);
        } else {
            userPO.setEnable(false);
        }
        userPO.setCreateDate(new Date());
        userPO.setUpdateDate(new Date());
        count = baseMapper.insert(userPO);
        if (count <= 0) {
            throw new BizRuntimeException(BusinessError.SERVER_FAIL, "添加用户失败");
        }
        if (userPO.getEnable()) {
            return "注册成功";
        }
        return "注册成功,正在审核中";
    }

    @Override
    public String login(String account, String password, Integer role, boolean force) {
        UserPO userPO = baseMapper.findByAccountAndPassword(account, password, role);
        if (userPO == null) {
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "账号或者密码错误");
        }
        if (!userPO.getEnable()) {
            log.warn("账号：{} 用户名：{} 未审核,登录被拦截", userPO.getLoginAccount(), userPO.getName());
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "您的账号还未审核,请联系管理员");
        }
        if (!force) {
            if (UserCache.getInstance().exist(account)) {
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "该账号已经在其他地方正在登录，是否强制登录");
            }
        }
        UserCache.getInstance().removeByAccount(userPO.getLoginAccount());
        String token = UUID.randomUUID().toString().replace("-", "");
        UserCache.getInstance().addUser(token, userPO);
        return token;
    }

    @Override
    public Object logout() {
        String token = WebUtils.getUserToken();
        UserCache.getInstance().removeByToken(token);
        return ResultVO.successWithData("登出成功");
    }

    @Override
    public ResultVO listRecord(int roleType, BaseVO baseVO) {
        Page page = MyPageUtil.getPage(baseVO);
        List<UserPO> userList = baseMapper.findPage(page, roleType, baseVO.getSearch());
        page.setRecords(userList);

        return ResultVO.builder().code(StatusEnum.SUCCESS.getCode()).data(page).build();
    }
}
