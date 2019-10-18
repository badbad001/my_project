package cn.itcast.sys.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DataGrid {
	
	private Integer code = 0;
	private String msg = "";
	private Long count = 0l;
	private Object data;
	
	/**
	 * 分页用
	 * @param code
	 * @param msg
	 */
	public DataGrid(Long count, Object data) {
		super();
		this.count = count;
		this.data = data;
	}
	
	

	//基本返回页面

	public DataGrid(Object data) {
		super();
		this.data = data;
	}



	




	
	
	
	
	

}
