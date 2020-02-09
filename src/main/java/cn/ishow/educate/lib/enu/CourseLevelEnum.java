package cn.ishow.educate.lib.enu;
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

/**
 * @author yinchong
 * @create 2020/2/4 11:51
 * @description
 */
public enum  CourseLevelEnum {
    BASE(1,"基础"),ADVANCE(2,"进阶"),OVERSTATE(3,"拔高");
    private int code;
    private String msg;

    CourseLevelEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

    public static String levelMsg(int code){
        for(CourseLevelEnum levelEnum:values()){
            if(levelEnum.code==code){
                return levelEnum.msg;
            }
        }
        return "";
    }


}
