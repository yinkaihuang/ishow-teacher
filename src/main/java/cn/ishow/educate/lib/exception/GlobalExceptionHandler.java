package cn.ishow.educate.lib.exception;

import cn.ishow.common.exception.BizRuntimeException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * 全局异常处理器
 **/
@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {
 
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Map<String,Object> handlerException(Exception exception){
        Map<String,Object> map = new HashMap<String ,Object>();
        if(exception instanceof BizRuntimeException){
            BizRuntimeException biz = (BizRuntimeException) exception;
            map.put("code",biz.getCode());
            map.put("msg",biz.getMessage());
            return map;
        }
        log.error("出现异常：",exception);
        map.put("code","500");
        map.put("msg","网络繁忙");
        return map;
    }
 
}