package cn.itcast.sys.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.sys.mapper.TechnologyMapper;
import cn.itcast.sys.pojo.Technology;
import cn.itcast.sys.service.TechnologyService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 超极本
 * @since 2019-10-12
 */
@Service
public class TechnologyServiceImpl extends ServiceImpl<TechnologyMapper, Technology> implements TechnologyService {

	
	
	//查询用户技术的id集合
	@Override
	public List<Integer> queryUserTechnologyByUid(Integer id) {		
		return this.getBaseMapper().queryUserTechnologyByUid(id);
	}

	
	//分配用户技术点
	@Override
	public void dispatchUserTechnology(Integer id, List<Integer> tids) {
		//先删除中间表的数据，避免主键重复问题
		TechnologyMapper technologyMapper = this.getBaseMapper();
		
		//删除删除中间表的数据，避免主键重复问题
		technologyMapper.deleteUserTechnologyByUid(id);
		
		//分配用户技术
		for (Integer tid : tids) {
			technologyMapper.addUserTechnology(id,tid);
		}
	}
	
	
	
	
	
	

	
}
