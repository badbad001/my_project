package cn.itcast.sys.vo;

import cn.itcast.sys.pojo.Technology;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class TechnologyVo  extends Technology{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	//分页参数
	private Integer page;
	private Integer limit;
	
	//批量删除
	private Integer[] ids;
}
