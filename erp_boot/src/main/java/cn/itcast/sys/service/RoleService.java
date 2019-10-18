package cn.itcast.sys.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;

import cn.itcast.sys.pojo.Role;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author leijun
 * @since 2019-10-09
 */
public interface RoleService extends IService<Role> {

	List<Integer> queryRolePermissionId(Integer id);

	void dispatchRolePermission(Integer id, Integer[] ids);

	List<Integer> queryUserRoleIdsByUid(Integer id);

	void addUserRole(Integer id, Integer[] ids);

}
