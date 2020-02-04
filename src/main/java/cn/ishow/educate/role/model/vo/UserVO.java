package cn.ishow.educate.role.model.vo;
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

import lombok.Data;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * @author yinchong
 * @create 2019/11/24 16:56
 * @description
 */
@Data
@Validated
public class UserVO implements Serializable {
    @NotBlank(message = "账号不能为空")
    private String loginAccount;
    @NotBlank(message = "名称不能为空")
    private String name;
    private Data birthDay;
    @NotBlank(message = "密码不能为空")
    private String password;
    @NotBlank(message = "第二次密码不能为空")
    private String password2;
    private String gender;
    @NotBlank(message = "手机号不能为空")
    private String phoneNumber;
    @NotNull(message = "角色不能为空")
    private Integer role;
}
