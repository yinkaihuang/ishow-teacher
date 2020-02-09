package cn.ishow.educate.course.mapper;

import cn.ishow.educate.course.model.po.CoursePO;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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
public interface CourseMapper extends BaseMapper<CoursePO> {
    int checkCourseByNameAndUserName(@Param("name") String name,@Param("author") String author);

    List<CoursePO> listActiveCourse(@Param("name") String name,@Param("author") String author,@Param("type") Integer type,@Param("level") Integer level);

    List<CoursePO> listPage(Page page, String search,String pusher);
}