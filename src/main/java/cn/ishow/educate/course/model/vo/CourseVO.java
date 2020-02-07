package cn.ishow.educate.course.model.vo;
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
 * @create 2019/11/27 8:38
 * @description
 */
@Data
@Validated
public class CourseVO implements Serializable {
    private Long id;
    @NotBlank(message = "课程名称不能为空")
    private String name;
    private Long imageId;
    @NotNull(message = "选上传视频")
    private Long videoId;
    private String description;
    @NotNull(message = "课程类型不能为空")
    private Integer type;
    @NotNull(message = "课程级别不能为空")
    private Integer level;
    @NotBlank(message = "课程标签不能为空")
    private String tag;
    @NotBlank(message = "讲师不能为空")
    private String author;
    private Integer price;
}
