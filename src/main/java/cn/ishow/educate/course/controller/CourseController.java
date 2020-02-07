package cn.ishow.educate.course.controller;
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
import cn.ishow.educate.course.model.po.CoursePO;
import cn.ishow.educate.course.model.vo.CourseCondition;
import cn.ishow.educate.course.model.vo.CourseVO;
import cn.ishow.educate.course.service.ICourseService;
import cn.ishow.educate.lib.controller.BaseController;
import cn.ishow.educate.lib.enu.RoleEnum;
import cn.ishow.educate.lib.util.WebUtils;
import cn.ishow.educate.role.model.po.UserPO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.constraints.NotEmpty;
import java.util.List;
import java.util.Map;

/**
 * @author yinchong
 * @create 2019/11/27 8:48
 * @description
 */
@Controller
@RequestMapping("course")
public class CourseController extends BaseController {
    public static final String PULISHER_NAME = "pusher_name";
    public static final String ADMIN = "admin";
    @Autowired
    private ICourseService courseService;

    @RequestMapping("addCourse")
    @ResponseBody
    public Object addCourse(@Validated CourseVO courseVO) {
        Integer type = userType();
        if(type==null){
            return ResultVO.needLogin();
        }else if(type!=RoleEnum.TEACHER.getCode()&&type!=RoleEnum.MANAGER.getCode()){
            return ResultVO.fail("无权限");
        }
        String message = courseService.addCourse(courseVO);
        return ResultVO.successWithData(message);
    }

    @RequestMapping("listActiveCourse")
    @ResponseBody
    public List<CoursePO> listActiveCourse(CourseCondition condition) {
        return courseService.listActiveCourse(condition);
    }

    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> listCourse(BaseVO baseVO, String pusher) {
        if(userType()==null){
            throw new BizRuntimeException(500,"未登入");
        }
        ResultVO resultVO = courseService.listCourse(baseVO, pusher);
        return resultVO.toTableMap();
    }

    @RequestMapping("/listPage")
    public String listPage(ModelMap map) {
        UserPO user = WebUtils.getUser();
        if (user == null) {
            return "user/login";
        }
        if (user.getRole() == RoleEnum.MANAGER.getCode()) {
            map.put(PULISHER_NAME, ADMIN);
        } else {
            map.put(PULISHER_NAME, user.getName());
        }
        return "course/list";
    }

    @RequestMapping("deleteCourse")
    @ResponseBody
    public Object deleteCourse(@NotEmpty(message = "id不能为空") Long id) {
        String result = courseService.deleteCourse(id);
        return ResultVO.successWithData(result);
    }

    @RequestMapping("updateCourse")
    @ResponseBody
    public Object updateCourse(CourseVO vo) {
        if (vo.getId() == null) {
            throw new BizRuntimeException(BusinessError.PARAM_VERIFY_FAIL, "id不能为空");
        }
        String result = courseService.updateCourse(vo);
        return ResultVO.successWithData(result);
    }

    @RequestMapping("/addPage")
    public String addPage() {
        return "course/add";
    }
}
