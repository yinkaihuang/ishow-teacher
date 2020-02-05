package cn.ishow.educate.common.model.vo;
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

import cn.ishow.educate.lib.enu.StatusEnum;
import com.baomidou.mybatisplus.plugins.Page;
import lombok.Builder;
import lombok.Data;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * @author yinchong
 * @create 2020/2/5 12:23
 * @description
 */
@Data
@Builder
public class ResultVO implements Serializable {
    private Integer code;
    private String msg;
    private Object data;

    public static ResultVO success(String msg) {
        return ResultVO.builder().code(StatusEnum.SUCCESS.getCode()).msg(msg).build();
    }

    public static ResultVO fail(String msg) {
        return ResultVO.builder().code(StatusEnum.FAIL.getCode()).msg(msg).build();
    }


    public Map<String, Object> toTableMap() {
        Page page = (Page) this.getData();
        Map<String, Object> map = new HashMap<>();
        map.put("total", page.getTotal());
        map.put("page", page.getPages());
        map.put("rows", page.getRecords());
        return map;
    }
}
