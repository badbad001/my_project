package cn.itcast.sys.vo.act;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

/**
 * 因为activiti的deployEntity不能被实例化，所以只能我们自己搞个类来
 * 封装传到页面
 * @author 超极本
 *
 */
@Data
public class ActDeployEntity {
	
	  private String id;
	  private String name;	
	  
	  //部署名称
	  @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	  private Date deploymentTime;

}
