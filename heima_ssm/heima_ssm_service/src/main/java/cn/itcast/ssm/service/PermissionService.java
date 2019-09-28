package cn.itcast.ssm.service;

import cn.itcast.ssm.mapper.PermissionMapper;
import cn.itcast.ssm.pojo.Permission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author: badbad
 * @Date: 2019/9/18 22:10
 * @Version 1.0
 */
@Service
@Transactional
public class PermissionService {
    
    @Autowired
    private PermissionMapper permissionMapper;

    /**
     * 查询全部
     * @return
     */
    public List<Permission> findAll(){
       return  permissionMapper.findAll();
    }

    /**
     * 添加权限
     * @param permission
     */
    public void save(Permission permission){
        permissionMapper.save(permission);
    }
}
