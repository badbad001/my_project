package cn.itcast.sys.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResultObj {
	
	private Integer code;
	private String msg;
	
	//登录方面
    public static final ResultObj LOGIN_SUCCESS = new ResultObj(Constant.OK, "登录成功");
    public static final ResultObj LOGIN_ERROR = new ResultObj(Constant.ERROR, "用户名或者密码错误");
    public static final ResultObj CODE_ERROR = new ResultObj(Constant.ERROR, "验证码错误");
    
    //未授权
    public static final ResultObj UNAUTHORIZED = new ResultObj(Constant.UNAUTHORIZED, "未授权");
    
    //增删改
    public static final ResultObj ADD_SUCCESS = new ResultObj(Constant.OK, "添加成功");
    public static final ResultObj ADD_ERROR = new ResultObj(Constant.ERROR, "添加失败");
    public static final ResultObj DELETE_SUCCESS = new ResultObj(Constant.OK, "删除成功");
    public static final ResultObj DELETE_ERROR = new ResultObj(Constant.ERROR, "删除失败");
    public static final ResultObj UPDATE_SUCCESS = new ResultObj(Constant.OK, "更新成功");
    public static final ResultObj UPDATE_ERROR = new ResultObj(Constant.ERROR, "更新失败");
    
    //重置
    public static final ResultObj RESET_SUCCESS = new ResultObj(Constant.OK, "重置成功");
    public static final ResultObj RESET_ERROR = new ResultObj(Constant.ERROR, "重置失败");
    
    //分配
    public static final ResultObj DISPATCH_SUCCESS = new ResultObj(Constant.OK, "分配成功");
    public static final ResultObj DISPATCH_ERROR = new ResultObj(Constant.ERROR, "分配失败");
    
    //操作
    public static final ResultObj OPETRATE_SUCCESS = new ResultObj(Constant.OK, "操作成功");
    public static final ResultObj OPETRATE_ERROR = new ResultObj(Constant.ERROR, "操作失败");
    
    //操作
    public static final ResultObj MODIFY_SUCCESS = new ResultObj(Constant.OK, "修改成功");
    public static final ResultObj MODIFY_ERROR = new ResultObj(Constant.ERROR, "修改失败");
	
    //旧密码错误
    public static final ResultObj OLD_PWD_ERROR = new ResultObj(Constant.ERROR, "旧密码错误");
        
    //部署流程
	public static final ResultObj DEPLOY_SUCCESS = new ResultObj(Constant.OK, "部署成功");
	public static final ResultObj DEPLOY_ERROR = new ResultObj(Constant.ERROR, "部署失败");
	
    
}
