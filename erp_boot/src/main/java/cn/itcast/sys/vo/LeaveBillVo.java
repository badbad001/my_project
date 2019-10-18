package cn.itcast.sys.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import cn.itcast.sys.pojo.Leavebill;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class LeaveBillVo extends Leavebill {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//分页
	private Integer page;
	private Integer limit;
	
	//批量删除
	private Integer[] ids;
	
	//开始结束时间
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endTime;

}
