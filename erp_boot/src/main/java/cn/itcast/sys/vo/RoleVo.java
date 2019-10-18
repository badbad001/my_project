package cn.itcast.sys.vo;

import cn.itcast.sys.pojo.Role;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class RoleVo  extends Role{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//分页
	private Integer page;
	private Integer limit;
	
	//用于批量的，分配菜单和批量删除都行
    private Integer[] ids;
		
	
}
