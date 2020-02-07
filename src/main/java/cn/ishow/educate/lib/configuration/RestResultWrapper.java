package cn.ishow.educate.lib.configuration;

import cn.ishow.educate.common.model.vo.ResultVO;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import java.lang.reflect.Method;
import java.util.Map;

//@RestControllerAdvice
public class RestResultWrapper implements ResponseBodyAdvice<Object> {


    /**
     * 可指定针对某些返回值的类型才进行rest风格的封装
     *
     * @param returnType    返回值类型
     * @param converterType
     * @return
     */
    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        Method method = returnType.getMethod();
        Class<?> clazz = method.getDeclaringClass();
        if (clazz.getAnnotation(RestController.class) != null) {
            return true;
        }
        if (method.getAnnotation(ResponseBody.class) != null) {
            return true;
        }
        return false;
    }

    /**
     * 封装正常返回的数据
     *
     * @param body
     * @param returnType
     * @param selectedContentType
     * @param selectedConverterType
     * @param request
     * @param response
     * @return
     */
    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        if (MediaType.IMAGE_JPEG.getType().equalsIgnoreCase(selectedContentType.getType())) {
            return body;
        }
        if (body instanceof Map) {
            return body;
        } else if (body instanceof ResultVO) {
            return body;
        }
        return ResultVO.successWithData(body);
    }
}
