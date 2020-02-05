package cn.ishow.educate.lib.util;

import cn.ishow.educate.common.model.vo.BaseVO;
import com.baomidou.mybatisplus.plugins.Page;

import java.util.HashMap;
import java.util.Map;

public class MyPageUtil {

    public static final String TOTAL = "total";
    public static final String ROWS = "rows";

    public static Page getPage(BaseVO baseVo) {
        Page page = new Page(baseVo.getPageNum(), baseVo.getPageSize());
        return page;
    }


    public static Map<String, Object> getMap(Page page) {
        Map<String, Object> map = new HashMap<>();
        map.put(TOTAL, page.getTotal());
        map.put(ROWS, page.getRecords());
        return map;
    }
}