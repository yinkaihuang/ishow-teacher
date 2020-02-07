package cn.ishow.educate.course.model.po;
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
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.util.Date;

/**
 * @author yinchong
 * @create 2019/11/26 16:08
 * @description
 */
@Data
@TableName("t_course")
@Alias("coursePO")
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CoursePO extends BasePO implements Serializable {
    @TableId(type = IdType.AUTO)
    private Long id;
    //课程名称
    private String name;
    //讲师名称
    private String author;
    //发布者
    private String pusher;
    //图片id
    private Long imageId;
    //视频播放地址
    private Long videoId;
    //课程类型
    private Integer type;
    //课程等级
    private Integer level;
    //标签
    private String tag;
    //描述
    private String description;
    //价格
    private Integer price;

    @JsonFormat(pattern = "yyyy年MM月dd日 HH时mm分ss秒")
    private Date updateDate;
}
