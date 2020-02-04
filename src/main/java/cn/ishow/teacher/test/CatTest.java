package cn.ishow.teacher.test;
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

import com.dianping.cat.Cat;
import com.dianping.cat.message.Transaction;

import java.util.Random;

/**
 * @author yinchong
 * @create 2019/11/25 11:48
 * @description
 */
public class CatTest {

    public static void main(String[] args)throws Exception {
        for (int i = 0; i < 1000; i++) {
            Transaction t = Cat.newTransaction("TEST", "test.method");
            Cat.logEvent("注册", "vip");
            Cat.logEvent("注销", "普通用户");
            Cat.logMetricForCount("权益下方");
            Cat.logMetricForCount("视频浏览", 2);
            Cat.logMetricForCount("商品购买");
            int nextInt = new Random().nextInt(3);
            if (nextInt % 2 == 0) {
                t.setStatus(Transaction.SUCCESS);
            } else {
                t.setStatus(String.valueOf(nextInt));
            }
            t.complete();
            Thread.sleep(300);
        }
    }
}
