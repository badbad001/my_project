package cn.itcast.sys.controller;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;
import cn.itcast.sys.pojo.Loginfo;
import cn.itcast.sys.service.LoginfoService;
import cn.itcast.sys.vo.LoginInfoVo;

/**
 * <p>
 *  日志管理
 * </p>
 *
 * @author leijun
 * @since 2019-10-07
 */
@RestController
@RequestMapping("loginfo")
public class LoginfoController {
	
	
	@Autowired
	private LoginfoService loginfoService;
	
	/**
	 * 查询日志，带条件加分页
	 * @param loginInfoVo
	 * @return
	 */
	@RequestMapping("queryAllLoginInfo")
	public DataGrid queryAllLoginInfo(LoginInfoVo loginInfoVo) {
		
		IPage<Loginfo> page = new Page<>(loginInfoVo.getPage(),loginInfoVo.getLimit());
		QueryWrapper<Loginfo> queryWrapper = new QueryWrapper<>();
		
		//ip和登录名的
		queryWrapper.like(StringUtils.isNotBlank(loginInfoVo.getLoginname()), "loginname",loginInfoVo.getLoginname());
		queryWrapper.like(StringUtils.isNotBlank(loginInfoVo.getLoginip()), "loginip", loginInfoVo.getLoginip());
	    
		//时间的
		queryWrapper.gt(loginInfoVo.getStartTime()!=null, "logintime", loginInfoVo.getStartTime());
		queryWrapper.lt(loginInfoVo.getEndTime()!=null, "logintime", loginInfoVo.getEndTime());
		
		//排序
		queryWrapper.orderByDesc("logintime");
		
		loginfoService.page(page, queryWrapper);
		
		return new DataGrid(page.getTotal(),page.getRecords());
		
	}
	
	/**
	 * 删除日志
	 * @return
	 */
	@RequestMapping("deleteLoginfo")
	public ResultObj deleteLoginfo(LoginInfoVo loginInfoVo) {
		
	    try {
			loginfoService.removeById(loginInfoVo.getId());
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {
			
			e.printStackTrace();
			return ResultObj.DELETE_ERROR;
		}
		
	}

	/**
	 * 批量删除
	 * @param loginInfoVo
	 * @return
	 */
	@RequestMapping("deleteBatchLoginfo")
	public ResultObj deleteBatchLoginfo(LoginInfoVo loginInfoVo) {
		
		Integer[] ids = loginInfoVo.getIds();	
		Collection<Serializable> idList = new ArrayList<>();
		for (Integer id : ids) {
			idList.add(id);	
		}
		
		try {
			loginfoService.removeByIds(idList);			
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {		
			e.printStackTrace();	
			return ResultObj.DELETE_ERROR;
		}
	}

}

