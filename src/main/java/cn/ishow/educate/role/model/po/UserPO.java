package cn.ishow.educate.role.model.po;
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

import cn.ishow.common.model.po.BasePO;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @author yinchong
 * @create 2019/11/24 16:35
 * @description
 */
@Data
@Alias("user")
@TableName("t_user")
public class UserPO extends BasePO implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;
    //登录账号
    private String loginAccount;
    //密码
    private String password;
    //手机号
    private String phoneNumber;
    //姓名
    private String name;
    //性别
    private String gender;
    //生日
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date birthDay;
    @TableField(exist = false)
    private String birthDayStr;
    //微信管理OpenId
    private String openId;
    //身份证号码
    private String idCard;
    //家庭地址
    private String address;
    //1是学生 2是老师 3是管理员
    private Integer role;
}
