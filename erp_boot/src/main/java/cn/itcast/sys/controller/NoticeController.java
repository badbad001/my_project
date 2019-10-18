package cn.itcast.sys.controller;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import cn.itcast.sys.common.DataGrid;
import cn.itcast.sys.common.ResultObj;
import cn.itcast.sys.pojo.Notice;
import cn.itcast.sys.pojo.User;
import cn.itcast.sys.service.NoticeService;
import cn.itcast.sys.util.WebUtils;
import cn.itcast.sys.vo.NoticeVo;

/**
 * <p>
 *  公告管理
 * </p>
 *
 * @author leijun
 * @since 2019-10-07
 */
@RestController
@RequestMapping("notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 查询带条件带分页
	 * @param noticeVo
	 * @return
	 */
	@RequestMapping("queryAllNotice")
	public DataGrid queryAllNotice(NoticeVo noticeVo) {
		
		IPage<Notice> page  = new Page<>(noticeVo.getPage(), noticeVo.getLimit());
		 QueryWrapper<Notice> queryWrapper = new QueryWrapper<>();
		 //构造条件
		 queryWrapper.like(StringUtils.isNotBlank(noticeVo.getOpername()), "opername",noticeVo.getOpername());
		 queryWrapper.like(StringUtils.isNotBlank(noticeVo.getTitle()), "title",noticeVo.getTitle());
		 queryWrapper.like(StringUtils.isNotBlank(noticeVo.getContent()), "content", noticeVo.getContent());
		 queryWrapper.gt(noticeVo.getStartTime()!=null, "createtime", noticeVo.getStartTime());
		 queryWrapper.lt(noticeVo.getEndTime()!=null,"createtime",noticeVo.getEndTime());
		 
		 //排序
		 queryWrapper.orderByDesc("createtime");
		 
		 noticeService.page(page, queryWrapper);
		
		return new DataGrid(page.getTotal(),page.getRecords());
		
	}
	
	/**
	 * 删除
	 * @param noticeVo
	 * @return
	 */
	@RequestMapping("deleteNotice")
	public ResultObj deleteNotice(NoticeVo noticeVo) {
		try {
			noticeService.removeById(noticeVo.getId());
			
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
	@RequestMapping("deleteBatchNotice")
	public ResultObj deleteBatchNotice(NoticeVo noticeVo) {
		
		//组装id集合
		Integer[] ids = noticeVo.getIds();	
		Collection<Serializable> idList = new ArrayList<>();
		for (Integer id : ids) {
			idList.add(id);
		}
		
		try {
			noticeService.removeByIds(idList);			
			return ResultObj.DELETE_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();			
			return ResultObj.DELETE_ERROR;
		}
		
	}
	
	/**
	 * 添加公告
	 * @param noticeVo
	 * @return
	 */
	@RequiresPermissions("notice:create")   //这个是测试细粒度的shiro
	@RequestMapping("addNotice")
	public ResultObj addNotice(NoticeVo noticeVo) {
		try {
			//设置创建时间
			noticeVo.setCreatetime(new Date());
			User user = (User) WebUtils.getHttpSession().getAttribute("user");
			noticeVo.setOpername(user.getName());
			
			noticeService.save(noticeVo);			
			return ResultObj.ADD_SUCCESS;
		} catch (Exception e) {			
			e.printStackTrace();
			return ResultObj.ADD_ERROR;
		}
	}
	
	/**
	 * 更新公告
	 * @param noticeVo
	 * @return
	 */
	@RequestMapping("updateNotice")
	public ResultObj updateNotice(NoticeVo noticeVo) {
		try {
			noticeService.updateById(noticeVo);
			return ResultObj.UPDATE_SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ResultObj.UPDATE_ERROR;
		}
	}

}

