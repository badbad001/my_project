package cn.itcast.sys.cache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.itcast.bus.mapper.CustomerMapper;
import cn.itcast.bus.mapper.GoodsMapper;
import cn.itcast.bus.mapper.ProviderMapper;
import cn.itcast.bus.pojo.Customer;
import cn.itcast.bus.pojo.Goods;
import cn.itcast.bus.pojo.Provider;
import cn.itcast.sys.mapper.DeptMapper;
import cn.itcast.sys.mapper.UserMapper;
import cn.itcast.sys.pojo.Dept;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.util.SpringUtil;

/**
 * 缓存池 ,统一管理缓存
 * @author 超极本
 *
 */
public class CachePools {

	/**
	 * 所有的缓存数据放到这个CACHE_CONTAINER类似于redis
	 */
	public static volatile Map<String, Object> CACHE_CONTAINER = new HashMap<>();
	
	
	/**
	 * 根据key移除缓存
	 * @param key
	 */
	public static void removeCacheByKey(String key) {
		if (CACHE_CONTAINER.containsKey(key)) {
			CACHE_CONTAINER.remove(key);
		}	
	}
	

	/**
	 * 清空全部缓存
	 */
	public static void remaveAll() {
		CACHE_CONTAINER.clear();
	}
	
	/**
	 * 同步缓存
	 */
	public static void syscData() {
		//同步部门数据
		DeptMapper deptMapper = SpringUtil.getBean(DeptMapper.class);
		List<Dept> deptList = deptMapper.selectList(null);
		for (Dept dept : deptList) {
			CACHE_CONTAINER.put("dept:"+dept.getId(), dept);
		}
		//同步用户数据
		UserMapper userMapper = SpringUtil.getBean(UserMapper.class);
		List<User> userList = userMapper.selectList(null);
		for (User user : userList) {
			CACHE_CONTAINER.put("user:"+user.getId(), user);
		}
		//同步客户数据
		CustomerMapper customerMapper = SpringUtil.getBean(CustomerMapper.class);
		List<Customer> customerList = customerMapper.selectList(null);
		for (Customer customer : customerList) {
			CACHE_CONTAINER.put("customer:"+customer.getId(), customer);
		}
		//同步供应商数据
		ProviderMapper providerMapper = SpringUtil.getBean(ProviderMapper.class);
		List<Provider> providerList = providerMapper.selectList(null);
		for (Provider provider : providerList) {
			CACHE_CONTAINER.put("provider:"+provider.getId(), provider);
		}
		//同步商品数据
		GoodsMapper goodsMapper=SpringUtil.getBean(GoodsMapper.class);
		List<Goods> goodsList = goodsMapper.selectList(null);
		for (Goods goods : goodsList) {
			CACHE_CONTAINER.put("goods:"+goods.getId(), goods);
		}
	}
}
