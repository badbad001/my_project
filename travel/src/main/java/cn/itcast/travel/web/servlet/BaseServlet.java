package cn.itcast.travel.web.servlet;

import com.sun.net.httpserver.HttpsServer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

/**
 * @Author: badbad
 * @Date: 2019/9/6 20:23
 * @Version 1.0
 */
public class BaseServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.获取请求uri
        String uri = request.getRequestURI();
        System.out.println(uri);
        //2.截取路径   /travel/user/login ,获取截取最后一个 /的索引
        //截取/后面的方法名字
        String methodStr = uri.substring(uri.lastIndexOf("/") + 1);
        System.out.println(methodStr);
        //3.获取当前的servlet的class对象进行反射，执行方法
        try {
            Method method = this.getClass().getMethod(methodStr,HttpServletRequest.class,HttpServletResponse.class);
            method.invoke(this,request,response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
