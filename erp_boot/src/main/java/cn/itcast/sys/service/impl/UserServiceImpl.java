package cn.itcast.sys.service.impl;

import java.io.Serializable;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.sys.mapper.UserMapper;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.service.UserService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 超极本
 * @since 2019-10-07
 */
@Service
@Transactional
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

	@Override
	public User getById(Serializable id) {
		
		return super.getById(id);
	}
	
	/**
	 * 删除用户
	 */
	@Override
	public boolean removeById(Serializable id) {
		//删除sys_role_user 中间表的数据
		this.getBaseMapper().deleteUserRoleByUid(id);
		return super.removeById(id);
	}
	
	@Override
	public boolean save(User entity) {
		
		return super.save(entity);
	}
	
	@Override
	public boolean updateById(User entity) {
		
		return super.updateById(entity);
	}
}
