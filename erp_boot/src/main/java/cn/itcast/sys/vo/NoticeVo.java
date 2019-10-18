package cn.itcast.sys.vo;

import java.util.Date;

import cn.itcast.sys.pojo.Notice;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class NoticeVo extends Notice{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//分页的参数
	private Integer page;
	private Integer limit;
	
	//开始结束时间
	private Date startTime;
	private Date endTime;
	
	//批量删除要用的
	private Integer[] ids;

}
