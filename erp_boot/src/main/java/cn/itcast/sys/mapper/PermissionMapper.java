package cn.itcast.sys.mapper;

import java.io.Serializable;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import cn.itcast.sys.pojo.Permission;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author leijun
 * @since 2019-10-07
 */
public interface PermissionMapper extends BaseMapper<Permission> {

	void deleteRolePermissionByPid(Serializable id);

}
