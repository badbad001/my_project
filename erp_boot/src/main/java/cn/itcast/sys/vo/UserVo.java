package cn.itcast.sys.vo;

import cn.itcast.sys.pojo.User;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class UserVo  extends User{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//分页用到的
	private Integer page;
	private Integer limit;
	
	//分配角色用到的
	private Integer[] ids;
	
	//旧密码
	private String oldPwd;
	
	//验证码
	private String code;

}
