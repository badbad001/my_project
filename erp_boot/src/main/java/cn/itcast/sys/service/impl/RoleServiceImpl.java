package cn.itcast.sys.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.sys.mapper.RoleMapper;
import cn.itcast.sys.pojo.Role;
import cn.itcast.sys.service.RoleService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author leijun
 * @since 2019-10-09
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

	/**
	 * 重写remove方法
	 */
	@Override
	public boolean removeById(Serializable id) {
		RoleMapper roleMapper = this.getBaseMapper();
		//删除sys_role_permission中间表的数据
		roleMapper.deleteRolePermissionByRid(id);
		//删除sys_role_user中间表的数据
		roleMapper.deleteRoleUserByRid(id);
		return super.removeById(id);
	}

	/**
	 * 根据角色id去中间表查 角色所拥有的权限id集合
	 */
	@Override
	public List<Integer> queryRolePermissionId(Integer id) {
	
		return this.getBaseMapper().queryRolePermissionId(id);
	}

	/**
	 * 分配角色权限
	 */
	@Override
	public void dispatchRolePermission(Integer rid, Integer[] ids) {
	    //先删除角色中间表的数据，再添加,防止重复主键问题
		RoleMapper roleMapper = this.getBaseMapper();
		roleMapper.deleteRolePermissionByRid(rid);
		
		//再添加角色权限
		for (Integer pid : ids) {
			roleMapper.addRolePermission(rid,pid);
		}
		
		
	}

	/**
	 * 查询用户角色id集合
	 */
	@Override
	public List<Integer> queryUserRoleIdsByUid(Integer id) {
	     
		return this.getBaseMapper().queryUserRoleIdsByUid(id);
	}

	/**
	 * 给用户添加角色
	 */
	@Override
	public void addUserRole(Integer uid, Integer[] roleIds) {
		//先删除用户角色  防止主键重复问题
		RoleMapper roleMapper = this.getBaseMapper();		
		roleMapper.deleteUserRoleByUid(uid);
		
		//遍历插入
		for (Integer rid : roleIds) {
			roleMapper.addUserRole(rid,uid);
		}
		
	}
}
