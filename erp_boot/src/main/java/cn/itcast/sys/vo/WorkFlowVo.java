package cn.itcast.sys.vo;

import lombok.Data;

@Data
public class WorkFlowVo {
	
	//分页参数
	private Integer page;
	private Integer limit;
	
	//部署名称
	private String deploymentName;
	
	//批量操作
	private String[] ids;
	
	//流程部署id
	private String id;
	
	//请假单id
	private Integer leaveBillId;
	
	//任务id
	private String taskId;
	
	//批注
	private String comment;
	
	//outcome 结果
	private String outcome;

}
