package cn.itcast.sys.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cn.itcast.sys.cache.CachePools;
import cn.itcast.sys.common.CacheBean;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;

@RestController
@RequestMapping("cache")
public class CacheController {
	
	public static volatile Map<String, Object> CACHE_CONTAINER = CachePools.CACHE_CONTAINER;
	
	/**
	 * 根据键移除缓存
	 * @param key
	 * @return
	 */
	@RequestMapping("removeCacheByKey")
	public ResultObj removeCacheByKey(String key) {
		CachePools.removeCacheByKey(key);
		
		return ResultObj.OPETRATE_SUCCESS;
	}
	
	/**
	 * 移除所有缓存
	 * @return
	 */
	@RequestMapping("removeAll")
	public ResultObj removeAll() {
		CachePools.remaveAll();
		return ResultObj.OPETRATE_SUCCESS;
	}
	
	/**
	 * 同步缓存
	 * @return
	 */
	@RequestMapping("syscData")
	public ResultObj syncData() {
		CachePools.syscData();
		return ResultObj.OPETRATE_SUCCESS;
	}
	
	/**
	 * 查询所有缓存
	 * @return
	 */
	@RequestMapping("queryAllCache")
	public DataGrid queryAllCache() {
		
		Set<String> keySet = CACHE_CONTAINER.keySet();
		List<CacheBean> list = new ArrayList<>();	
		
		for (String key : keySet) {
			list.add(new CacheBean(key, CACHE_CONTAINER.get(key)));
		}
		
		return new DataGrid(list);
	}

}
