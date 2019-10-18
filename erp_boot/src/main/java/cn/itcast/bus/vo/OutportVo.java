package cn.itcast.bus.vo;

import java.util.Date;

import cn.itcast.bus.pojo.Outport;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class OutportVo extends Outport{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//分页参数
	private Integer page;
	private Integer limit;
	
	//进货单id
	private Integer inportid;

	//开始时间，和结束时间
	private Date startTime;	
	private Date endTime;
	
	
}
