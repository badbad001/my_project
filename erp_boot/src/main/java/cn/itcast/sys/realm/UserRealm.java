package cn.itcast.sys.realm;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import cn.itcast.sys.common.ActiveUser;
import cn.itcast.sys.common.Constant;
import cn.itcast.sys.pojo.Permission;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.service.PermissionService;
import cn.itcast.sys.service.RoleService;
import cn.itcast.sys.service.UserService;
/**
 * 自定义realm
 * @author 超极本
 *
 */
public class UserRealm extends AuthorizingRealm{
	
	@Autowired
	@Lazy  //延迟加载，用的时候才加载，这样切面后的service实现类才会用到
	private UserService userService;
	
	@Autowired
	@Lazy  //角色   我们在realm注入的东西都要lazy,这样可以
	       //延迟加载，用的时候才加载，这样切面后的service实现类才会用到
	private RoleService roleService;
	
	@Autowired
	@Lazy  //权限
	private PermissionService permissionService;
	
	/**
	 * 自定义relam的名字
	 */
	@Override
	public String getName() {
	
		return this.getClass().getSimpleName();
	}
	
	/**
	 * 认证
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		//1.获取用户名
		String loginname = (String) token.getPrincipal();
		//2.去数据库查
		QueryWrapper<User> wrapper = new QueryWrapper<>();
		wrapper.eq("loginname", loginname);
		User user = userService.getOne(wrapper);
		
		//3.判断用户是否为空
		if (user!=null) {		
		    //4.处理盐，盐转为字节
			ByteSource credentialsSalt = ByteSource.Util.bytes(user.getSalt());
			
			//5.查用户所拥有权限
			List<String> percodes = queryUserPermission(user);
			
			//6.放用户进去和权限编码进入
			ActiveUser activeUser = new ActiveUser();			
			activeUser.setUser(user);
			activeUser.setPercodes(percodes);
						
			return new SimpleAuthenticationInfo(activeUser, user.getPwd(), credentialsSalt,this.getName());	
		}else {
			return null;
		}
		
	}

	/**
	 * 授权
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		
		//1.拿到active用户
		ActiveUser activeUser = (ActiveUser) principals.getPrimaryPrincipal();
		//2.如果用户类型是超级管理员，有全部权限
		if (activeUser.getUser().getType()==Constant.USER_TYPE_SUPER) {
			info.addStringPermission("*:*");  //*:*代表有全部权限
		}else { //如果是普通用户，就拿权限编码遍历，放进简单授权信息里面
			List<String> percodes = activeUser.getPercodes();			
			for (String percode : percodes) {
				info.addStringPermission(percode);
			}
		}
		
		return info;
	}
	
	
	/**
	 * 查询用户所拥有的角色
	 * @return
	 */
	public List<String> queryUserPermission(User user) {
		QueryWrapper<Permission> queryWrapper = new QueryWrapper<>();
		
		//1.查询可用的权限
		queryWrapper.eq("available", Constant.AVAILABLE);
		queryWrapper.eq("type", Constant.TYPE_PERMISSION);
				
		//2.1定义一个权限编码集合
		List<String> percodes = new ArrayList<>();
		
		//2.2定于一个权限集合
		List<Permission> permissions = null;
		
		//3.根据id查权限
		
		//3.1先根据用户id查询sys_role_user的角色id集合
		List<Integer> rids = roleService.queryUserRoleIdsByUid(user.getId());
		
		//3.2接着根据角色id查sys_role_permission的集合
		//3.2.1这个set集合用于去重权限的id集合
		Set<Integer> pidSet= new HashSet<>();
		for (Integer rid : rids) {
			List<Integer> pids = roleService.queryRolePermissionId(rid);
			//把权限放进set集合去重
			pidSet.addAll(pids);
		}
					
		//3.3接着用去重后的pidSet来查询权限
		//3.3.1如果去重后的权限集合不为空，才in去查数据
		if (pidSet!=null && pidSet.size()>0) {
			queryWrapper.in("id", pidSet);				
			permissions = permissionService.list(queryWrapper);
		}else {   //不然直接new 一个空集合
			permissions = new ArrayList<>();
			
		}
		
		//4.接着组装权限编码返回去
		for (Permission permission : permissions) {
			percodes.add(permission.getPercode());
		}
			
		
		return percodes;
			
	}

	

}
