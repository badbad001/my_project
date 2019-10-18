package cn.itcast.sys.vo;

import java.util.Date;

import cn.itcast.sys.pojo.Loginfo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class LoginInfoVo extends Loginfo {


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer page; //currPage
	private Integer limit;//pageSize
	
	//开始时间，结束时间
	private Date startTime;
	private Date endTime;
	
	//批量删除
	private Integer[] ids;
}
