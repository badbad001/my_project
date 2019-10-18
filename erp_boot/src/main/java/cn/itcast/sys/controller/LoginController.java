package cn.itcast.sys.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import cn.itcast.sys.common.ActiveUser;
import cn.itcast.sys.common.ResultObj;
import cn.itcast.sys.pojo.Loginfo;
import cn.itcast.sys.service.LoginfoService;
import cn.itcast.sys.util.WebUtils;
import cn.itcast.sys.vo.UserVo;

@RestController
@RequestMapping("login")
public class LoginController {
	
	@Autowired
	private LoginfoService loginfoService;
	
	/**
	 * 登录
	 * @param userVo
	 * @return
	 */
	@RequestMapping("login")
	public ResultObj login(UserVo userVo ) {
		
		//传过来的验证码
		String pageCode = userVo.getCode();
		
		//获取session域的验证码
		String code = (String) WebUtils.getHttpSession().getAttribute("code");
		
		//两个验证码不匹配
		if (!StringUtils.equals(pageCode,code)) {
			return ResultObj.CODE_ERROR;
		}
		
		
		//构建tocken
		UsernamePasswordToken token = new UsernamePasswordToken(userVo.getLoginname(), userVo.getPwd());
		//获取subject接口
		Subject subject = SecurityUtils.getSubject();
		
		try {
			//执行登录
			subject.login(token);
			
			//登录成功放进session域
			ActiveUser activeUser = (ActiveUser) subject.getPrincipal();
	
			WebUtils.getHttpSession().setAttribute("user",activeUser.getUser());
			
			//记录登录日志
			Loginfo loginfo = new Loginfo();
			
			loginfo.setLoginip( WebUtils.getHttpServletRequest().getRemoteAddr());
			loginfo.setLoginname(activeUser.getUser().getName());
			loginfo.setLogintime(new Date());
			
			loginfoService.save(loginfo);
			
			return ResultObj.LOGIN_SUCCESS;
		} catch (AuthenticationException e) {
			e.printStackTrace();			
			return ResultObj.LOGIN_ERROR;
		}
		
	}
	
	
	 /**
     * 切换验证码
     */
    @RequestMapping("getCode")
    public void getCode(HttpSession session, HttpServletResponse response){
        //创建一个验证码获取对象
        //四个参数意思分别是验证码图片的宽高,验证码个数，扰乱码个数
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(116, 36,4,5);
        //把验证码存session
        session.setAttribute("code",lineCaptcha.getCode());
        //然后把图片写回页面

        try {
            //把图片写到页面
            lineCaptcha.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
	


}
