package cn.itcast.sys.mapper;

import java.io.Serializable;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import cn.itcast.sys.pojo.User;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author leijun
 * @since 2019-10-07
 */
public interface UserMapper extends BaseMapper<User> {

	//删除sys_role_user 中间表的数据
	void deleteUserRoleByUid(Serializable id);

}
