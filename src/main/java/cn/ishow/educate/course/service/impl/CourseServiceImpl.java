package cn.ishow.educate.course.service.impl;
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
import cn.ishow.educate.course.mapper.CourseMapper;
import cn.ishow.educate.course.model.po.CoursePO;
import cn.ishow.educate.lib.enu.CourseLevelEnum;
import cn.ishow.educate.lib.enu.CourseTypeEnum;
import cn.ishow.educate.lib.enu.StatusEnum;
import cn.ishow.educate.lib.util.MyPageUtil;
import cn.ishow.educate.role.model.po.UserPO;
import cn.ishow.educate.course.model.vo.CourseCondition;
import cn.ishow.educate.course.model.vo.CourseVO;
import cn.ishow.educate.course.service.ICourseService;
import cn.ishow.educate.lib.util.WebUtils;
import com.baomidou.mybatisplus.plugins.Page;
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
        if (user == null) {
            throw new BizRuntimeException(StatusEnum.NEEDLOGIN.getCode(), "需要重新登入");
        }
        int row = baseMapper.checkCourseByNameAndUserName(courseVO.getName(), user.getName());
        if (row > 0) {
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "课程名称已经存在");
        }
        CoursePO coursePO = new CoursePO();
        BeanUtils.copyProperties(courseVO, coursePO);
        coursePO.setPusher(user.getName());
        coursePO.setEnable(true);
        coursePO.setCreateDate(new Date());
        coursePO.setUpdateDate(new Date());
        baseMapper.insert(coursePO);
        return "上传课程成功";
    }

    @Override
    public List<CoursePO> listActiveCourse(CourseCondition condition) {
        List<CoursePO> records = baseMapper.listActiveCourse(condition.getName(), condition.getAuthor(), condition.getType(), condition.getLevel());
        applyLevelAndTypeStr(records);
        return records;
    }

    private void applyLevelAndTypeStr(List<CoursePO> records) {
        if (records == null) {
            return;
        }
        for (CoursePO coursePO : records) {
            String levelMsg = CourseLevelEnum.levelMsg(coursePO.getLevel());
            coursePO.setLevelStr(levelMsg);
            String typeMsg = CourseTypeEnum.typeMsg(coursePO.getType());
            coursePO.setTypeStr(typeMsg);
        }
    }

    @Override
    public String deleteCourse(Long id) {
        int row = baseMapper.deleteById(id);
        if (row > 0) {
            return "删除成功";
        }
        throw new BizRuntimeException(BusinessError.SERVER_FAIL, "删除失败");
    }

    @Override
    public String updateCourse(CourseVO vo) {
        CoursePO coursePO = baseMapper.selectById(vo.getId());
        if (coursePO == null) {
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "未找到用户信息");
        }
        BeanUtils.copyProperties(vo, coursePO);
        int row = baseMapper.updateById(coursePO);
        if (row <= 0) {
            throw new BizRuntimeException(BusinessError.SERVER_FAIL, "更新失败");
        }
        return "更新成功";
    }

    @Override
    public ResultVO listCourse(BaseVO baseVO, String pusher) {
        Page page = MyPageUtil.getPage(baseVO);
        List<CoursePO> record = baseMapper.listPage(page, baseVO.getSearch(), pusher);
        page.setRecords(record);
        return ResultVO.successWithData(page);
    }
}
