package cn.itcast.sys.common;

import com.alibaba.fastjson.JSON;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CacheBean {
	
	private String key;
	private Object value;
		
	/**
	 * 序列化成json显示到页面
	 * @return
	 */
	public Object getValue() {
		return JSON.toJSONString(value);
	}
	
}
