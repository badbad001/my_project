package cn.itcast.sys.common;


import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TreeNode {
	
	//两个重要属性 id 和pid
	private Integer id;
	
	//转为parentId,dtree的展示需要
	@JsonProperty("parentId")
	private Integer pid;
	
	//自己的图标，href 和title
	private String icon;
	private String href;
	private String title;
	
	//节点是否展开
	private Boolean spread;
	
	//这个是用来复选框的，"0"即不选中,"1"选中
	private String checkArr = "0";
	
	//字节点集合
	private List<TreeNode> children = new ArrayList<>();

	//这个去掉子节点集合的树节点，用于构建基本树节点
	public TreeNode(Integer id, Integer pid, String icon, String href, String title, Boolean spread) {
		super();
		this.id = id;
		this.pid = pid;
		this.icon = icon;
		this.href = href;
		this.title = title;
		this.spread = spread;
	}

	//这个是用来展示列表左边的Dtree的构造
	public TreeNode(Integer id, Integer pid, String title, Boolean spread) {
		super();
		this.id = id;
		this.pid = pid;
		this.title = title;
		this.spread = spread;
	}

	
	/**
	 * 这个用于构建复选树
	 * @param id
	 * @param pid
	 * @param title
	 * @param spread
	 * @param checkAttr
	 */
	public TreeNode(Integer id, Integer pid, String title, Boolean spread, String checkArr) {
		super();
		this.id = id;
		this.pid = pid;
		this.title = title;
		this.spread = spread;
		this.checkArr = checkArr;
	}
	
	
	
	
	
	
	

}
