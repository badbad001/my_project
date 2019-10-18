package cn.itcast.sys.vo;

import cn.itcast.sys.pojo.Permission;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class PermissionVo extends Permission{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//分页参数
	private Integer page;
	private Integer limit;
	
	

}
