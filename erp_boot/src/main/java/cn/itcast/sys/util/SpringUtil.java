package cn.itcast.sys.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
 * 这个是解耦方式获取ioc容器的方法
 * @author 超极本
 *
 */
@Component //ApplicationContextAware这个是ioc容器启动完成接着
           //去扫描classpath下的所有实现ApplicationContextAware的类
            //然后执行里面实现 接口的方法
public class SpringUtil implements ApplicationContextAware{
	
	private static ApplicationContext applicationContext;

    /**
          * 实现接口的方法，获取ioc容器
     */
	@Override
	public void setApplicationContext(ApplicationContext act) throws BeansException {
		applicationContext=act;
	}
	
	/**
	 * 解耦方式获取ioc容器对象
	 */
	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}
	
	/**
	 * 获取ioc容器的对象
	 * @param <T>
	 * @param cls
	 * @return
	 */
	public static <T> T getBean(Class<T> cls) {
		return applicationContext.getBean(cls);
	}

}
