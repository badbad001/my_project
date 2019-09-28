package cn.itcast.ssm.mapper;

import cn.itcast.ssm.pojo.Permission;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 21:46
 * @Version 1.0
 */
public interface PermissionMapper {

    /**
     * 根据角色查询权限
     * @param roleId
     * @return
     */
    @Select("select * from permission where id in (select permissionId from role_permission where roleId = #{id})")
    public List<Permission> findByRoleId(int roleId);

    /**
     * 查询全部
     * @return
     */
    @Select("select * from permission")
    public List<Permission> findAll();

    /**
     * 添加权限
     * @param permission
     */
    @Insert("insert into permission values(null,#{permissionName},#{url})")
    public void save(Permission permission);
}
