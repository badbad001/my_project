package cn.itcast.bus.cache;

import java.util.List;
import java.util.Map;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;

import cn.itcast.bus.pojo.Customer;
import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Provider;
import cn.itcast.sys.cache.CachePools;
import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@EnableAspectJAutoProxy
@Slf4j
public class BusCacheAspect {

	// 定义缓存容器container
		private Map<String, Object> CACHE_CONTAINER = CachePools.CACHE_CONTAINER;

		/**
		 * 客户curd缓存 ------------------------------------------------------start
		 */

		// 定义四个切面
		private static final String POINTCUT_CUSTOMER_GET = "execution(* cn.itcast.bus.service.impl.CustomerServiceImpl.getById(..))";
		private static final String POINTCUT_CUSTOMER_DELETE = "execution(* cn.itcast.bus.service.impl.CustomerServiceImpl.removeById(..))";
		private static final String POINTCUT_CUSTOMER_UPDATE = "execution(* cn.itcast.bus.service.impl.CustomerServiceImpl.updateById(..))";
		private static final String POINTCUT_CUSTOMER_ADD = "execution(* cn.itcast.bus.service.impl.CustomerServiceImpl.save(..))";
		private static final String POINTCUT_CUSTOMER_DELETEBATCH = "execution(* cn.itcast.bus.service.impl.CustomerServiceImpl.removeByIds(..))";

		// 前缀
		private static final String CUSTOMER_PREFIX = "customer:";
		
		/**
		 * 添加客户缓存
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_CUSTOMER_ADD)
		public Object cacheAddCustomer(ProceedingJoinPoint joinPoint) throws Throwable {
			//1.执行目标方法
			Boolean flag = (Boolean) joinPoint.proceed();	
			//2.添加成功，就放进缓存
			if (flag) {
				Customer customer = (Customer) joinPoint.getArgs()[0];				
				CACHE_CONTAINER.put(CUSTOMER_PREFIX+customer.getId(),customer);
				
				log.info("添加客户,更新缓存"+customer.getId());
			}			
			return flag;
		}
		
		/**
		 * 删除客户
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_CUSTOMER_DELETE)
		public Object cacheDeleteCustomer(ProceedingJoinPoint joinPoint) throws Throwable {
			
			//1.执行目标方法
			Boolean flag = (Boolean) joinPoint.proceed();			
			if (flag) {//2.成功就从缓存移除
				Integer id = (Integer) joinPoint.getArgs()[0];				
				CACHE_CONTAINER.remove(CUSTOMER_PREFIX+id);
				
				log.info("删除客户，更新缓存"+id);
			}
			
			return flag;
		}
		
		/**
		 * 批量删除
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_CUSTOMER_DELETEBATCH)
		public Object cacheDeleteBatchCustomer(ProceedingJoinPoint joinPoint) throws Throwable {
			
			Boolean flag = (Boolean) joinPoint.proceed();
			
			if (flag) {
				List<Integer> ids = (List<Integer>) joinPoint.getArgs()[0];
				for (Integer id : ids) {
					CACHE_CONTAINER.remove(CUSTOMER_PREFIX+id);
					log.info("删除客户,更新缓存"+id);
				}			
			}
			
			return flag;
		}
		
		/**
		 * 更新客户
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_CUSTOMER_UPDATE)
		public Object cacheUpdateCustomer(ProceedingJoinPoint joinPoint) throws Throwable {
			Boolean flag = (Boolean) joinPoint.proceed();
			
			if (flag) {
				Customer customer = (Customer) joinPoint.getArgs()[0];				
			    CACHE_CONTAINER.put(CUSTOMER_PREFIX+customer.getId(), customer);
			    
			    log.info("更新客户更新缓存"+customer.getId());
			}
			
			return flag;
		}
		
		/**
		 * 获取用户
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_CUSTOMER_GET)
		public Object cacheGetCustomer(ProceedingJoinPoint joinPoint) throws Throwable {
			Integer id = (Integer) joinPoint.getArgs()[0];	
			
			//1.先从缓存拿
		    Customer customer = (Customer) CACHE_CONTAINER.get(CUSTOMER_PREFIX+id);
		    
		    //2.缓存为空，数据库拿
		    if (customer == null) {
				customer = (Customer) joinPoint.proceed();
				log.info("客户从数据库拿");
			}else {
				log.info("客户从缓存拿");
			}		    
		    return customer;
		}
		
		
		/**
		 * 供应商curd缓存 ------------------------------------------------------start
		 */

		// 定义四个切面
		private static final String POINTCUT_PROVIDER_GET = "execution(* cn.itcast.bus.service.impl.ProviderServiceImpl.getById(..))";
		private static final String POINTCUT_PROVIDER_DELETE = "execution(* cn.itcast.bus.service.impl.ProviderServiceImpl.removeById(..))";
		private static final String POINTCUT_PROVIDER_UPDATE = "execution(* cn.itcast.bus.service.impl.ProviderServiceImpl.updateById(..))";
		private static final String POINTCUT_PROVIDER_ADD = "execution(* cn.itcast.bus.service.impl.ProviderServiceImpl.save(..))";
		private static final String POINTCUT_PROVIDER_DELETEBATCH = "execution(* cn.itcast.bus.service.impl.ProviderServiceImpl.removeByIds(..))";

		// 前缀
		private static final String PROVIDER_PREFIX = "provider:";
		
		/**
		 * 添加供应商缓存
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_PROVIDER_ADD)
		public Object cacheAddProvider(ProceedingJoinPoint joinPoint) throws Throwable {
			//1.执行目标方法
			Boolean flag = (Boolean) joinPoint.proceed();	
			//2.添加成功，就放进缓存
			if (flag) {
				Provider provider = (Provider) joinPoint.getArgs()[0];				
				CACHE_CONTAINER.put(PROVIDER_PREFIX+provider.getId(),provider);
				
				log.info("添加供应商,更新缓存"+provider.getId());
			}			
			return flag;
		}
		
		/**
		 * 删除供应商
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_PROVIDER_DELETE)
		public Object cacheDeleteProvider(ProceedingJoinPoint joinPoint) throws Throwable {
			
			//1.执行目标方法
			Boolean flag = (Boolean) joinPoint.proceed();			
			if (flag) {//2.成功就从缓存移除
				Integer id = (Integer) joinPoint.getArgs()[0];				
				CACHE_CONTAINER.remove(PROVIDER_PREFIX+id);
				
				log.info("删除供应商，更新缓存"+id);
			}
			
			return flag;
		}
		
		/**
		 * 批量删除
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_PROVIDER_DELETEBATCH)
		public Object cacheDeleteBatchProvider(ProceedingJoinPoint joinPoint) throws Throwable {
			
			Boolean flag = (Boolean) joinPoint.proceed();
			
			if (flag) {
				List<Integer> ids = (List<Integer>) joinPoint.getArgs()[0];
				for (Integer id : ids) {
					CACHE_CONTAINER.remove(PROVIDER_PREFIX+id);
					log.info("删除供应商,更新缓存"+id);
				}			
			}
			
			return flag;
		}
		
		/**
		 * 更新供应商
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_PROVIDER_UPDATE)
		public Object cacheUpdateProvider(ProceedingJoinPoint joinPoint) throws Throwable {
			Boolean flag = (Boolean) joinPoint.proceed();
			
			if (flag) {
				Provider provider = (Provider) joinPoint.getArgs()[0];				
			    CACHE_CONTAINER.put(PROVIDER_PREFIX+provider.getId(), provider);
			    
			    log.info("更新供应商更新缓存"+provider.getId());
			}
			
			return flag;
		}
		
		/**
		 * 获取用户
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_PROVIDER_GET)
		public Object cacheGetProvider(ProceedingJoinPoint joinPoint) throws Throwable {
			Integer id = (Integer) joinPoint.getArgs()[0];	
			
			//1.先从缓存拿
		    Provider provider = (Provider) CACHE_CONTAINER.get(PROVIDER_PREFIX+id);
		    
		    //2.缓存为空，数据库拿
		    if (provider == null) {
				provider = (Provider) joinPoint.proceed();
				log.info("供应商从数据库拿");
			}else {
				log.info("供应商从缓存拿");
			}		    
		    return provider;
		}
		
		
		/**
		 * 商品curd缓存 ------------------------------------------------------start
		 */

		// 定义四个切面
		private static final String POINTCUT_GOODS_GET = "execution(* cn.itcast.bus.service.impl.GoodsServiceImpl.getById(..))";
		private static final String POINTCUT_GOODS_DELETE = "execution(* cn.itcast.bus.service.impl.GoodsServiceImpl.removeById(..))";
		private static final String POINTCUT_GOODS_UPDATE = "execution(* cn.itcast.bus.service.impl.GoodsServiceImpl.updateById(..))";
		private static final String POINTCUT_GOODS_ADD = "execution(* cn.itcast.bus.service.impl.GoodsServiceImpl.save(..))";
		private static final String POINTCUT_GOODS_DELETEBATCH = "execution(* cn.itcast.bus.service.impl.GoodsServiceImpl.removeByIds(..))";

		// 前缀
		private static final String GOODS_PREFIX = "goods:";
		
		/**
		 * 添加商品缓存
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_GOODS_ADD)
		public Object cacheAddGoods(ProceedingJoinPoint joinPoint) throws Throwable {
			//1.执行目标方法
			Boolean flag = (Boolean) joinPoint.proceed();	
			//2.添加成功，就放进缓存
			if (flag) {
				Goods goods = (Goods) joinPoint.getArgs()[0];				
				CACHE_CONTAINER.put(GOODS_PREFIX+goods.getId(),goods);
				
				log.info("添加商品,更新缓存"+goods.getId());
			}			
			return flag;
		}
		
		/**
		 * 删除商品
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_GOODS_DELETE)
		public Object cacheDeleteGoods(ProceedingJoinPoint joinPoint) throws Throwable {
			
			//1.执行目标方法
			Boolean flag = (Boolean) joinPoint.proceed();			
			if (flag) {//2.成功就从缓存移除
				Integer id = (Integer) joinPoint.getArgs()[0];				
				CACHE_CONTAINER.remove(GOODS_PREFIX+id);
				
				log.info("删除商品，更新缓存"+id);
			}
			
			return flag;
		}
		
		/**
		 * 批量删除
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_GOODS_DELETEBATCH)
		public Object cacheDeleteBatchGoods(ProceedingJoinPoint joinPoint) throws Throwable {
			
			Boolean flag = (Boolean) joinPoint.proceed();
			
			if (flag) {
				List<Integer> ids = (List<Integer>) joinPoint.getArgs()[0];
				for (Integer id : ids) {
					CACHE_CONTAINER.remove(GOODS_PREFIX+id);
					log.info("删除商品,更新缓存"+id);
				}			
			}
			
			return flag;
		}
		
		/**
		 * 更新商品
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_GOODS_UPDATE)
		public Object cacheUpdateGoods(ProceedingJoinPoint joinPoint) throws Throwable {
			Boolean flag = (Boolean) joinPoint.proceed();
			
			if (flag) {
				Goods goods = (Goods) joinPoint.getArgs()[0];				
			    CACHE_CONTAINER.put(GOODS_PREFIX+goods.getId(), goods);
			    
			    log.info("更新商品更新缓存"+goods.getId());
			}
			
			return flag;
		}
		
		/**
		 * 获取用户
		 * @param joinPoint
		 * @return
		 * @throws Throwable 
		 */
		@Around(POINTCUT_GOODS_GET)
		public Object cacheGetGoods(ProceedingJoinPoint joinPoint) throws Throwable {
			Integer id = (Integer) joinPoint.getArgs()[0];	
			
			//1.先从缓存拿
		    Goods goods = (Goods) CACHE_CONTAINER.get(GOODS_PREFIX+id);
		    
		    //2.缓存为空，数据库拿
		    if (goods == null) {
				goods = (Goods) joinPoint.proceed();
				log.info("商品从数据库拿");
			}else {
				log.info("商品从缓存拿");
			}		    
		    return goods;
		}

}
