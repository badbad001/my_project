package cn.itcast.sys.cache;

import java.util.Map;
import java.util.Set;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.BeanUtils;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;

import cn.itcast.sys.pojo.Dept;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.vo.DeptVo;
import lombok.extern.slf4j.Slf4j;

/**
 * 部门缓存切面
 * 
 * @author 超极本
 *
 */
@Aspect
@Component
@EnableAspectJAutoProxy
@Slf4j
public class SysCacheAspect {

	// 定义缓存容器container
	private Map<String, Object> CACHE_CONTAINER = CachePools.CACHE_CONTAINER;

	/**
	 * 部门curd缓存 ------------------------------------------------------start
	 */

	// 定义四个切面
	private static final String POINTCUT_DEPT_GET = "execution(* cn.itcast.sys.service.impl.DeptServiceImpl.getById(..))";
	private static final String POINTCUT_DEPT_DELETE = "execution(* cn.itcast.sys.service.impl.DeptServiceImpl.removeById(..))";
	private static final String POINTCUT_DEPT_UPDATE = "execution(* cn.itcast.sys.service.impl.DeptServiceImpl.updateById(..))";
	private static final String POINTCUT_DEPT_ADD = "execution(* cn.itcast.sys.service.impl.DeptServiceImpl.save(..))";

	// 前缀
	private static final String DEPT_PREFIX = "dept:";

	/**
	 * 添加部门，更新缓存
	 * 
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	@Around(POINTCUT_DEPT_ADD)
	public Object cacheAddDept(ProceedingJoinPoint joinPoint) throws Throwable {

		// 执行添加方法，如果成功,就放进缓存
		Boolean flag = (Boolean) joinPoint.proceed();
		if (flag) {
			// 虽然我们传过来的是deptVo 但是deptVo也是dept，所以直接用dept也行，而且
			// 方法上面也是dept
			Dept dept = (Dept) joinPoint.getArgs()[0];
			// mybatis-plus 添加成功时自动返回id封装上
			CACHE_CONTAINER.put(DEPT_PREFIX + dept.getId(), dept);

			log.info("添加了部门,更新缓存" + dept.getId());
		}

		return flag;
	}

	/**
	 * 获取id放进缓存
	 * 
	 * @return
	 * @throws Throwable
	 */
	@Around(POINTCUT_DEPT_GET)
	public Object cacheGetDept(ProceedingJoinPoint joinPoint) throws Throwable {

		// 1.获取id
		Integer id = (Integer) joinPoint.getArgs()[0];
		// 2.先从缓存获取数据
		Dept dept = (Dept) CACHE_CONTAINER.get(DEPT_PREFIX + id);
		// 3.判断是否为空
		// 3.1为空去数据库拿
		if (dept == null) {
			dept = (Dept) joinPoint.proceed();

			// 3.2拿完放进缓存
			CACHE_CONTAINER.put(DEPT_PREFIX + id, dept);

			log.info("部门从数据库拿" + id);
		} else {
		    log.info("部门从缓存拿"+id);
		}
		return dept;
	}

	/**
	 * 删除，接着更新缓存
	 * 
	 * @return
	 * @throws Throwable
	 */
	@Around(POINTCUT_DEPT_DELETE)
	public Object cacheDeleteDept(ProceedingJoinPoint joinPoint) throws Throwable {

		// 删除返回true或者false
		Boolean flag = (Boolean) joinPoint.proceed();

		// 如果删除成功，就从缓存移除
		if (flag) {
			Integer id = (Integer) joinPoint.getArgs()[0];
			CACHE_CONTAINER.remove(DEPT_PREFIX + id);

			log.info("部门删除，更新缓存，从缓存移除" + id);
		}

		return flag;
	}

	/**
	 * 更新部門，也更新下緩存
	 * 
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	@Around(POINTCUT_DEPT_UPDATE)
	public Object cacheUpdateDept(ProceedingJoinPoint joinPoint) throws Throwable {

		// 1.執行跟新方法
		Boolean flag = (Boolean) joinPoint.proceed();

		// 2.更新成功就重新更新緩存
		if (flag) {
			DeptVo deptVo = (DeptVo) joinPoint.getArgs()[0];
			Dept dept = (Dept) CACHE_CONTAINER.get(DEPT_PREFIX + deptVo.getId());

			// 3.緩存的dept为空就new一个
			if (dept == null) {
				dept = new Dept();
			}
			// 4.把更新的数据，赋值属性到缓存
			BeanUtils.copyProperties(deptVo, dept);

			// 5.重新放进缓存
			CACHE_CONTAINER.put(DEPT_PREFIX + dept.getId(), dept);

			

			log.info("更新部门,重新更新缓存");

		}

		Set<String> keySet = CACHE_CONTAINER.keySet();

		for (String key : keySet) {
			System.out.println(CACHE_CONTAINER.get(key));
		}

		return flag;

	}

	/**
	    部门curd缓存 -----------------------------------------------------------end
	 */
	

	/**
	    用户curd缓存 ----------------------------------------------------------start
	 */

   // 定义四个切面
	private static final String POINTCUT_USER_GET = "execution(* cn.itcast.sys.service.impl.UserServiceImpl.getById(..))";
	private static final String POINTCUT_USER_DELETE = "execution(* cn.itcast.sys.service.impl.UserServiceImpl.removeById(..))";
	private static final String POINTCUT_USER_UPDATE = "execution(* cn.itcast.sys.service.impl.UserServiceImpl.updateById(..))";
	private static final String POINTCUT_USER_ADD = "execution(* cn.itcast.sys.service.impl.UserServiceImpl.save(..))";

	// 前缀
	private static final String USER_PREFIX = "user:";
	
    /**
          * 添加用户，放缓存进去
     * @return
     * @throws Throwable 
     */
	@Around(POINTCUT_USER_ADD)
	public Object cacheAddUser(ProceedingJoinPoint joinPoint) throws Throwable {
		Boolean flag  =(Boolean) joinPoint.proceed();
		
		if (flag) {
			User user = (User) joinPoint.getArgs()[0];
			
			CACHE_CONTAINER.put(USER_PREFIX+user.getId(), user);
			
			log.info("添加用户成功,更新缓存"+user.getId());
			System.out.println("添加用户成功,更新缓存"+user.getId());
		}
		
		return flag;
	}
	
	/**
	 * 删除用户更新缓存
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	@Around(POINTCUT_USER_DELETE)
	public Object cacheDeleteUser(ProceedingJoinPoint joinPoint) throws Throwable {
		Boolean flag = (Boolean) joinPoint.proceed();
		
		if (flag) {
			Integer id = (Integer) joinPoint.getArgs()[0];
			CACHE_CONTAINER.remove(USER_PREFIX+id);
			log.info("删除用户更新缓存"+id);
		}
		
		return flag;
	}
	
	/**
	 * 更新用户，更新缓存
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	@Around(POINTCUT_USER_UPDATE)
	public Object cacheUpdateUser(ProceedingJoinPoint joinPoint) throws Throwable {
		Boolean flag =(Boolean) joinPoint.proceed();
		
		if (flag) {
			User user = (User) joinPoint.getArgs()[0];
			
			CACHE_CONTAINER.put(USER_PREFIX+user.getId(),user);
			
			log.info("更新用户成功，更新缓存"+user.getId());
		}
		
		return flag;
	}
	
	/**
	 * 获取用户，更新缓存
	 * @param joinPoint
	 * @return
	 * @throws Throwable 
	 */
	@Around(POINTCUT_USER_GET)
	public Object cacheGetUser(ProceedingJoinPoint joinPoint) throws Throwable {
		
		//1.获取参数
		Integer id = (Integer) joinPoint.getArgs()[0];		
		//2。从缓存拿
		User user = (User) CACHE_CONTAINER.get(USER_PREFIX+id);
		//3.缓存为空 ，就从数据库拿
		if (user == null) {
			//3.1执行原来方法
			user = (User) joinPoint.proceed();
				
			CACHE_CONTAINER.put(USER_PREFIX+id, user);
			System.out.println("从数据库拿用户"+id);
		}else {
			log.info("用户从缓存拿"+id);
		}
			
		return user;
	}

	/**
	  用户curd缓存 ------------------------------------------------------------end
	 */

}
