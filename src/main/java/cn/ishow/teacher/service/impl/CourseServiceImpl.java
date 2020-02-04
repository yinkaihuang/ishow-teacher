package cn.ishow.teacher.service.impl;
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
import cn.ishow.teacher.mapper.CourseMapper;
import cn.ishow.teacher.model.po.CoursePO;
import cn.ishow.teacher.model.po.UserPO;
import cn.ishow.teacher.model.vo.CourseCondition;
import cn.ishow.teacher.model.vo.CourseVO;
import cn.ishow.teacher.service.ICourseService;
import cn.ishow.teacher.util.WebUtils;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author yinchong
 * @create 2019/11/27 8:50
 * @description
 */
@Service
public class CourseServiceImpl extends ServiceImpl<CourseMapper, CoursePO> implements ICourseService {
    @Override
    public String addCourse(CourseVO courseVO) {
        UserPO user = WebUtils.getUser();
        int row = baseMapper.checkCourseByNameAndUserName(courseVO.getName(), user.getName());
        if(row>0){
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL,"课程名称已经存在");
        }
        CoursePO coursePO = new CoursePO();
        BeanUtils.copyProperties(courseVO,coursePO);
        coursePO.setAuthor(user.getName());
        coursePO.setEnable(true);
        coursePO.setCreateDate(new Date());
        coursePO.setUpdateDate(new Date());
        baseMapper.insert(coursePO);
        return "上传课程成功";
    }

    @Override
    public List<CoursePO> listActiveCourse(CourseCondition condition) {
       return  baseMapper.listActiveCourse(condition.getName(),condition.getAuthor(),condition.getType(),condition.getLevel());
    }

    @Override
    public String deleteCourse(Long id) {
       int row = baseMapper.deleteById(id);
       if(row>0){
           return "删除成功";
       }
       throw new BizRuntimeException(BusinessError.SERVER_FAIL,"删除失败");
    }

    @Override
    public String updateCourse(CourseVO vo) {
        CoursePO coursePO = baseMapper.selectById(vo.getId());
        if(coursePO==null){
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL,"未找到用户信息");
        }
        BeanUtils.copyProperties(vo,coursePO);
        int row = baseMapper.updateById(coursePO);
        if(row<=0){
            throw new BizRuntimeException(BusinessError.SERVER_FAIL,"更新失败");
        }
        return "更新成功";
    }
}
