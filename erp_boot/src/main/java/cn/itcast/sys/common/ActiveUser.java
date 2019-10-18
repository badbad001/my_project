package cn.itcast.sys.common;

import java.util.List;

import cn.itcast.sys.pojo.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ActiveUser {
	
	private User user;

	//权限编码集合
	private List<String> percodes;
	
	//这个角色暂时用不到
	private List<String> role;
}
