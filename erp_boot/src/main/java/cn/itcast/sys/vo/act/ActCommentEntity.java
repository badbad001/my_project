package cn.itcast.sys.vo.act;

import java.util.Date;

import lombok.Data;

@Data
public class ActCommentEntity {
	
	
	  private String userId;  //批注人
	  private Date time;	  //批注时间
	  private String message;  //批注内容
	  
	  protected String fullMessage; //批注内容 跟上面那个是一样的
	

}
