package cn.itcast.sys.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;

import cn.itcast.sys.pojo.Technology;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 超极本
 * @since 2019-10-12
 */
public interface TechnologyService extends IService<Technology> {

	
	List<Integer> queryUserTechnologyByUid(Integer id);

	void dispatchUserTechnology(Integer id, List<Integer> tids);

}
