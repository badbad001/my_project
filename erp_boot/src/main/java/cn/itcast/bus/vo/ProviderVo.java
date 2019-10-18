package cn.itcast.bus.vo;

import cn.itcast.bus.pojo.Provider;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ProviderVo extends Provider{

	/**
	 * 
	 */
	 private static final long serialVersionUID = 1L; 
	//分页参数
	private Integer page;
	private Integer limit;
	
	//批量删除
	private Integer[] ids;
}
