package cn.itcast.sys.service.impl;

import java.io.Serializable;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.sys.mapper.DeptMapper;
import cn.itcast.sys.pojo.Dept;
import cn.itcast.sys.service.DeptService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author leijun
 * @since 2019-10-08
 */
@Service
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements DeptService {
	
	@Override
	public Dept getById(Serializable id) {
		
		return super.getById(id);
	}
	
	@Override
	public boolean removeById(Serializable id) {
		
		return super.removeById(id);
	}
	
	
	@Override
		public boolean updateById(Dept entity) {
			// TODO Auto-generated method stub
			return super.updateById(entity);
		}
}
