package cn.itcast.sys.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;
import cn.itcast.sys.service.WorkFlowService;
import cn.itcast.sys.vo.WorkFlowVo;

@RestController
@RequestMapping("workflow")
public class WorkFlowController {
	
    @Autowired
	private WorkFlowService workFlowService;
    
    /**
     * 查询所有部署
     * @param workFlowVo
     * @return
     */
    @RequestMapping("queryAllDeployment")
    public DataGrid queryAllDeployment(WorkFlowVo workFlowVo) {
		  
    	return workFlowService.queryAllDeployment(workFlowVo);
    	
	}
    
    /**
     * 查询所有流程定义
     * @return
     */
    @RequestMapping("queryAllProcessDef")
    public DataGrid queryAllProcessDef(WorkFlowVo workFlowVo) {
		return workFlowService. queryAllProcessDef(workFlowVo);
	}
    
    /**
     * 添加流程部署
     * @return
     */
    @RequestMapping("addWorkFlow")
    public ResultObj addWorkFlow(MultipartFile mf,WorkFlowVo workFlowVo) {
		
    	try {
			workFlowService.addWorkFlow(mf.getInputStream(),workFlowVo);			
			return ResultObj.DEPLOY_SUCCESS;
		} catch (IOException e) {			
			e.printStackTrace();
			return ResultObj.DEPLOY_ERROR;
		}
    	
	}
    
    /** 
     * 删除流程部署   暴力删除 ,有流程实例，也删除   级联删除
     * @return
     */
    @RequestMapping("deleteWorkFlow")
    public ResultObj deleteWorkFlow(WorkFlowVo workFlowVo) {
    	
    	try {
			workFlowService.deleteWorkFlow(workFlowVo.getId());
			
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();			
			return ResultObj.DELETE_ERROR;
		}
		
	}
    
    /**
     * 批量删除
     * @return
     */
    @RequestMapping("deleteBatchWorkFlow")
    public ResultObj deleteBatchWorkFlow(WorkFlowVo workFlowVo) {
		try {
			workFlowService.deleteBatchWorkFlow(workFlowVo.getIds());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {
		
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
    
    /**
     * 查看流程图
     * @param workFlowVo
     */
    @RequestMapping("viewProcessImage")
    public void viewProcessImage(WorkFlowVo workFlowVo,HttpServletResponse response) {
		
    	try {
			InputStream is = workFlowService.viewProcessImage(workFlowVo.getId());	
						
			//转为把流转为内存图片
			BufferedImage image = ImageIO.read(is);	
						
			//把内存图片写出去
			ImageIO.write(image, "JPEG", response.getOutputStream());
			
			//ServletOutputStream os = response.getOutputStream();
			
			//IOUtils.copy(is, os);
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}
	}
    
    /**
     * 启动流程
     * @return
     */
    @RequestMapping("startProcess")
    public ResultObj startProcess(WorkFlowVo workFlowVo) {
		
    	try {
			workFlowService.startProcess(workFlowVo.getLeaveBillId());			
			return ResultObj.OPETRATE_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();
			return ResultObj.OPETRATE_ERROR;
		}
	}
    
    /**
          * 查询当前用户的代办任务
     * @return
     */
    @RequestMapping("queryCurrentUserTask")
    public DataGrid queryCurrentUserTask(WorkFlowVo workFlowVo) {
    	
		return workFlowService.queryCurrentUserTask(workFlowVo);
	}
    
    /**
          * 根据任务id查询请假单
     * @param workFlowVo
     * @return
     */
    @RequestMapping("queryLeavebillByTaskId")
    public DataGrid queryLeavebillByTaskId(WorkFlowVo workFlowVo) {
		
    	return workFlowService.queryLeavebillByTaskId(workFlowVo.getTaskId());
	}
    
    /**
          * 查询出来的线根据任务id
     * @return
     */
    @RequestMapping("queryOutComeByTaskId")
    public DataGrid queryOutComeByTaskId(WorkFlowVo workFlowVo) {
		return workFlowService.queryOutComeByTaskId(workFlowVo.getTaskId());
	}
    
    /**
          * 查询批注信息根据任务id
     * @return
     */
    @RequestMapping("queryCommentByTaskId")
    public DataGrid queryCommentByTaskId(WorkFlowVo workFlowVo) {
		return workFlowService.queryCommentByTaskId(workFlowVo.getTaskId());
	}
    
    /**
         * 完成任务
     * @return
     */
    @RequestMapping("completeTask")
    public ResultObj completeTask(WorkFlowVo workFlowVo) {
		try {
			workFlowService.completeTask(workFlowVo);			
			return ResultObj.OPETRATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.OPETRATE_ERROR;
		}
	}
    
    /**
     * 根据taskid查询流程部署id;   用于用部署id查询图片
     * @return
     */
    @RequestMapping("queryDeployIdByTaskId")
    public DataGrid queryDeployIdByTaskId(WorkFlowVo workFlowVo) {
		return workFlowService.queryDeployIdByTaskId(workFlowVo.getTaskId());
	}
    
    /**
     * 根据任務id查询任務图的坐标
     * @return
     */
    @RequestMapping("queryCoordinateByTaskId")
    public DataGrid queryCoordinateByTaskId(WorkFlowVo workFlowVo) {
		return workFlowService.queryCoordinateByTaskId(workFlowVo.getTaskId());
	}
    
    /**
         * 查询审批批注根据请假单id
     * @return
     */
    @RequestMapping("queryCommentByLeaveBillId")
    public DataGrid queryCommentByLeaveBillId(WorkFlowVo workFlowVo) {
		return workFlowService.queryCommentByLeaveBillId(workFlowVo.getLeaveBillId());
	}
    
   
}
