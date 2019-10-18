package cn.itcast.sys.service.impl;

import java.io.Serializable;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import cn.itcast.sys.mapper.PermissionMapper;
import cn.itcast.sys.pojo.Permission;
import cn.itcast.sys.service.PermissionService;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author leijun
 * @since 2019-10-07
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PermissionService {

	/**
	 * 重写这个删除方法
	 */
	@Override
	public boolean removeById(Serializable id) {
		PermissionMapper permissionMapper = this.getBaseMapper();
		//删除权限，也删除角色权限中间表的东西
		permissionMapper.deleteRolePermissionByPid(id);
		return super.removeById(id);
	}
}
