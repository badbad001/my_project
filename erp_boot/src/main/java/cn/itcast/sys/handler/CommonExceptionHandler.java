package cn.itcast.sys.handler;

import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice //用controller这个返回字符串，跳转到页面
//@RestControllerAdvice  //rest这个返回json
public class CommonExceptionHandler {

    /**
     * 捕获到异常
     * @return  
     */
    @ExceptionHandler(UnauthorizedException.class)
    public String hanlerException(){
    	
    	return "403";  //跳到模板的页面
        //return ResultObj.UNAUTHORIZED;
    }
}