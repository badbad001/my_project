package cn.itcast.sys.vo;

import cn.itcast.sys.pojo.Dept;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class DeptVo extends Dept {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//分页
	private Integer page;
	private Integer limit;
	
	//批量删除
	private Integer[] ids;
	
	

}
