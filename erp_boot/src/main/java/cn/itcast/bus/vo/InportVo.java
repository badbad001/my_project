package cn.itcast.bus.vo;

import java.util.Date;

import cn.itcast.bus.pojo.Inport;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class InportVo extends Inport{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//分页参数
	private Integer page;
	private Integer limit;
	
	//批量删除
	private Integer[] ids;
	
	//开始时间，和结束时间
	private Date startTime;	
	private Date endTime;

}
