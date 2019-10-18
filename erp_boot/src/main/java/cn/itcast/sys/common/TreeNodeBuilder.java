package cn.itcast.sys.common;

import java.util.ArrayList;
import java.util.List;

public class TreeNodeBuilder {
	
	/**
	 * 构建层级关系的树
	 * @return
	 */
	public static List<TreeNode> build(List<TreeNode> baseNodes,Integer baseId) {
		List<TreeNode> rtNodes = new ArrayList<>();
		
		//编辑基础节点，看哪个父节点是跟节点
		for (TreeNode n1 : baseNodes) {
			if (n1.getPid() == baseId) {
				rtNodes.add(n1);
			}
			//再遍历跟节点，看哪个的父id跟这个id是一样的
			for (TreeNode n2 : baseNodes) {
				if (n1.getId() == n2.getPid()) {
					n1.getChildren().add(n2);
				}
			}
		}
		
		return rtNodes;
	}

}
