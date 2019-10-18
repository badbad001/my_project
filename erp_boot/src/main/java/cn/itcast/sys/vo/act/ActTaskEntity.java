package cn.itcast.sys.vo.act;

import java.util.Date;

import lombok.Data;

@Data
public class ActTaskEntity {
	
	  private String id ;  //任务id
	  private String assignee;  //办理人
	  private String name;	 //任务名字
	  private Date createTime; //任务创建时间

}
