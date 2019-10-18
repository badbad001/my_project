package cn.itcast.sys.controller;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.itcast.sys.common.Constant;
import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;
import cn.itcast.sys.pojo.Leavebill;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.service.LeavebillService;
import cn.itcast.sys.service.UserService;
import cn.itcast.sys.util.WebUtils;
import cn.itcast.sys.vo.LeaveBillVo;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 超极本
 * @since 2019-10-15
 */
@RestController
@RequestMapping("leavebill")
public class LeavebillController {
	
	@Autowired
	private LeavebillService leavebillService;
	
	@Autowired
	private UserService userService;
	
	/**
	 * 查询所有请假单
	 * @param leavebillVo
	 * @return
	 */
	@RequestMapping("queryAllLeavebill")
	public DataGrid queryAllLeavebill(LeaveBillVo leavebillVo) {
		
		IPage<Leavebill> page = new Page<>(leavebillVo.getPage(), leavebillVo.getLimit());
		QueryWrapper<Leavebill> queryWrapper = new QueryWrapper<>();
				
		//构造条件
		queryWrapper.like(StringUtils.isNotBlank(leavebillVo.getTitle()), "title", leavebillVo.getTitle());
		queryWrapper.like(StringUtils.isNotBlank(leavebillVo.getContent()),"content" ,leavebillVo.getContent());
		
		queryWrapper.gt(leavebillVo.getStartTime()!=null, "leavetime", leavebillVo.getStartTime());
		queryWrapper.le(leavebillVo.getEndTime()!=null, "leavetime", leavebillVo.getEndTime());
		
		User loginUser = (User) WebUtils.getHttpSession().getAttribute("user");
		
		//如果是普通用户只查询自己的请假条
		if (loginUser.getType() == Constant.USER_TYPE_NORMAL) {
			queryWrapper.eq("userid", loginUser.getId());
		}
				
		leavebillService.page(page, queryWrapper);
		//查用户名字
		
		//查询用户名字
		List<Leavebill> list = page.getRecords();
		for (Leavebill leavebill : list) {
			System.out.println("用户id"+leavebill.getUserid());
			User user = userService.getById(leavebill.getUserid());			
			leavebill.setUsername(user.getName());
		}
				
		return new DataGrid(page.getTotal(), list);
	}

	/**
	 * 添加请假单
	 * @return
	 */
	@RequestMapping("addLeavebill")
	public ResultObj addLeavebill(LeaveBillVo leavebillVo) {
		try {
			//添加请假单设置用户id
			User loginUser = (User) WebUtils.getHttpSession().getAttribute("user");
			leavebillVo.setUserid(loginUser.getId());
			
			leavebillService.save(leavebillVo);			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
	}
	
	/**
	 * 删除请假单
	 * @param leavebillVo
	 * @return
	 */
	@RequestMapping("deleteLeavebill")
	public ResultObj deleteLeavebill(LeaveBillVo leavebillVo) {
		try {
			leavebillService.removeById(leavebillVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();			
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 批量删除
	 * @param leavebillVo
	 * @return
	 */
	@RequestMapping("deleteBatchLeavebill")
	public ResultObj deleteBatchLeavebill(LeaveBillVo leavebillVo) {
		try {			
			//构建id集合
			Integer[] ids = leavebillVo.getIds();					
			Collection<Serializable> idList = new ArrayList<>();
			for (Integer id : ids) {
				idList.add(id);
			}			
			leavebillService.removeByIds(idList);		
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
	}
	
	/**
	 * 更新请假单
	 * @param leavebillVo
	 * @return
	 */
	@RequestMapping("updateLeavebill")
	public ResultObj updateLeavebill(LeaveBillVo leavebillVo) {
		try {
			leavebillService.updateById(leavebillVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}
	
	
	/**
	 * 查询所有请假单
	 * @return
	 */
	@RequestMapping("queryAllLeavebillForList")
	public DataGrid queryAllGoodsForList() {
		
		QueryWrapper<Leavebill> queryWrapper = new QueryWrapper<>();
		queryWrapper.eq("available", Constant.AVAILABLE);
		
		List<Leavebill> list = leavebillService.list(queryWrapper);
		
		
		return new DataGrid(list);
				
		
	}
	
	/**
	 * 根据请假单id
	 * @return
	 */
	@RequestMapping("queryLeaveBillByLeaveBillId")
	public DataGrid queryLeaveBillByLeaveBillId(LeaveBillVo leaveBillVo) {
		
		Leavebill leavebill = leavebillService.getById(leaveBillVo.getId());
		
		return new DataGrid(leavebill);
	}

}

