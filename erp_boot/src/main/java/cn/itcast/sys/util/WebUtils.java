package cn.itcast.sys.util;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.itcast.sys.pojo.User;

/**
 * web的工具类
 * @author LJH
 *
 */
public class WebUtils {
	
    //获取servlet的全部对象容器
	public static ServletRequestAttributes getServletRequestAttributes() {
		return (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
	}
	
	/**
	 * 得到当前线程的请求对象
	 * @return
	 */
	public static HttpServletRequest getHttpServletRequest() {
        //从容器获取当前线程的request
		return getServletRequestAttributes().getRequest();
	}
	
	/**
	 * 得到当前线程的响应对象
	 */
	public static HttpServletResponse getHttpServletResponse() {
        //从容器获取当前线程的响应
		return getServletRequestAttributes().getResponse();
	}
	
	/**
	 * 得到session对象
	 */
	public static HttpSession getHttpSession() {
        //从request获取session
		return getHttpServletRequest().getSession();
	}
	
	/**
	 * 得到servletContext对象
	 */
	public static ServletContext getServletContext() {
        //从request获取全部的servletContext对象
		return getHttpServletRequest().getServletContext();
	}
	
	/**
	 * 得到当前登录对象
	 */
	public static User getCurrentUser() {
       
		return (User) getHttpSession().getAttribute("user");
	}
	
	/**
	 * 得到当前登录对象的名字
	 */
	public static String getCurrentUserName() {
	
		return getCurrentUser().getName();
	}
	
}
