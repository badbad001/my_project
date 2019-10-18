package cn.itcast.bus.vo;

import java.util.Date;

import cn.itcast.bus.pojo.Salesback;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class SaleBackVo extends Salesback {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//分页参数
	private Integer page;
	private Integer limit;
	
	//销售单id
	private Integer salesid;

	//开始时间，和结束时间
	private Date startTime;	
	private Date endTime; 

}
