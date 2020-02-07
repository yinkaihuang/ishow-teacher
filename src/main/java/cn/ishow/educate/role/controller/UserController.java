package cn.ishow.educate.role.controller;
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
import cn.ishow.educate.role.model.po.UserPO;
import cn.ishow.educate.role.model.vo.UserVO;
import cn.ishow.educate.role.service.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Map;

/**
 * @author yinchong
 * @create 2019/11/24 16:56
 * @description
 */
@Controller
@RequestMapping("user")
@Slf4j
public class UserController {
    public static final String USER_EDIT = "userEdit";
    public static final String ROLE_TYPE = "roleType";
    public static final String ROLE_NAME = "roleName";
    @Autowired
    private IUserService userService;

    @RequestMapping("register")
    @ResponseBody
    public String register(@Validated UserVO userVO) {
        try {
            if (!userVO.getPassword().equals(userVO.getPassword2())) {
                log.warn("两次密码不一致,password:{}, password2:{}", userVO.getPassword(), userVO.getPassword2());
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "两次密码不一致");
            }
            if (userVO.getRole() != RoleEnum.STUDENT.getCode() || userVO.getRole() == RoleEnum.TEACHER.getCode()) {
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "请输出正确角色");
            }
            if(userVO.getName().equals("admin")){
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL,"admin名称不能使用");
            }
            String result = userService.register(userVO);
            return result;
        } catch (RuntimeException e) {
            throw e;
        }
    }

    @RequestMapping("checkAccount")
    @ResponseBody
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


    @RequestMapping("logout")
    @ResponseBody
    public Object logout() {
        return userService.logout();
    }

    /**
     * 登入系统后台只允许教师和管理员使用
     * @param account
     * @param password
     * @param role
     * @param force
     * @return
     */
    @RequestMapping("login")
    @ResponseBody
    public ResultVO login(String account, String password,Integer role, boolean force) {
        try {
            if (Strings.isBlank(account)) {
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "账号不为空");
            }
            if (Strings.isBlank(password)) {
                throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "密码不能为空");
            }
            String result = userService.login(account, password,role, force);
            return ResultVO.successWithData(result);
        } catch (RuntimeException e) {
            log.error("login fail, account:{} password:{} force:{} cause:{}", account, password, force, e);
            throw e;
        }
    }


    @RequestMapping("/student")
    public String studentPage(ModelMap map) {
        map.put(ROLE_TYPE, RoleEnum.STUDENT.getCode());
        map.put(ROLE_NAME, "学生管理");
        return "user/list";
    }

    @RequestMapping("/teacher")
    public String teacherPage(ModelMap map) {
        map.put(ROLE_TYPE, RoleEnum.TEACHER.getCode());
        map.put(ROLE_NAME, "教师管理");
        return "user/list";
    }

    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list(Integer roleType, BaseVO baseVO) {
        return userService.listRecord(roleType, baseVO).toTableMap();
    }

    @RequestMapping("/delete")
    @ResponseBody
    public ResultVO delete(Long id) {
        boolean flag = userService.deleteById(id);
        if (flag) {
            return ResultVO.success("删除成功");
        } else {
            return ResultVO.fail("删除失败");
        }
    }

    @RequestMapping("/editPage")
    public String teacherEdit(Long id, ModelMap map) {
        UserPO userPO = userService.selectById(id);
        if (userPO != null && userPO.getBirthDay() != null) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            String dateStr = format.format(userPO.getBirthDay());
            userPO.setBirthDayStr(dateStr);
        }
        map.put(USER_EDIT, userPO);
        return "user/edit";
    }

    @RequestMapping("edit")
    public String edit(UserPO userVO, ModelMap map) {
        UserPO userPO = userService.selectById(userVO.getId());
        BeanUtils.copyProperties(userVO, userPO);
        userService.updateById(userPO);
        map.put(ROLE_TYPE, userPO.getRole());
        if (userPO.getRole() == RoleEnum.STUDENT.getCode()) {
            map.put(ROLE_NAME, "学生管理");
        } else {
            map.put(ROLE_NAME, "教师管理");
        }
        return "user/list";
    }
}
