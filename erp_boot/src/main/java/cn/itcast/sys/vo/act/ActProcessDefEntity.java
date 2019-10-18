package cn.itcast.sys.vo.act;

import lombok.Data;

@Data
public class ActProcessDefEntity {
	
	  private String id;  //流程定义id
	  private String name;  //流程名字
	  private String key;  //key
	  private int version;  //版本
	  private String deploymentId;  //部署id
	  private String resourceName;	 //bpmn文件
	  private String diagramResourceName;  //png图片文件	

}
