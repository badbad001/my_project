package cn.itcast.stat.controller;

import java.io.ByteArrayOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import cn.itcast.bus.pojo.Customer;
import cn.itcast.bus.pojo.Provider;
import cn.itcast.bus.service.CustomerService;
import cn.itcast.bus.service.ProviderService;
import cn.itcast.bus.vo.CustomerVo;
import cn.itcast.bus.vo.ProviderVo;
import cn.itcast.stat.pojo.BaseEntity;
import cn.itcast.stat.service.StatService;
import cn.itcast.stat.utils.CustomerExportUtils;
import cn.itcast.stat.utils.ProviderExportUtils;
import cn.itcast.sys.common.Constant;


@RequestMapping("stat")
@Controller
public class StatController {
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private ProviderService providerService;
	
	@Autowired
	private StatService statService;
       
	 /**
    *
    *导出客户数据
    * @param customerVo
    * @return
    */
   @RequestMapping("exportCustomerData")
   public ResponseEntity<Object> exportCustomerData(CustomerVo customerVo){
       //查询所有客户信息，有条件也条件查询
	   
	    QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
		
		//查询可用的
		queryWrapper.eq("available", Constant.AVAILABLE);
		
		//构造条件
		queryWrapper.like(StringUtils.isNotBlank(customerVo.getCustomername()), "customername", customerVo.getCustomername());
		queryWrapper.like(StringUtils.isNotBlank(customerVo.getConnectionperson()),"connectionperson" ,customerVo.getConnectionperson());
		queryWrapper.like(StringUtils.isNotBlank(customerVo.getAddress()), "address", customerVo.getAddress());
	   
        List<Customer> list = customerService.list(queryWrapper);

        String fileName = "客户数据表.xlsx";
        String sheetName = "客户数据";

       //拿到内存流
       ByteArrayOutputStream os = CustomerExportUtils.exportCustomer(list,sheetName);

       //下载回页面
       try {
          fileName =  URLEncoder.encode(fileName,"UTF-8");
       } catch (UnsupportedEncodingException e) {
           e.printStackTrace();
       }

       HttpHeaders header=new HttpHeaders();
       //封装响应内容类型(APPLICATION_OCTET_STREAM 响应的内容不限定)
       header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
       //设置下载的文件的名称  文件处理方式，附件形式处理，且设置文件名称
       header.setContentDispositionFormData("attachment", fileName);

       return new  ResponseEntity<Object>(os.toByteArray(),header, HttpStatus.CREATED);

   }
   
   /**
    * 导出供应商数据
    * @param providerVo
    * @return
    */
  @RequestMapping("exportProviderData")
  public ResponseEntity<Object> exportCustomerData(ProviderVo providerVo){
       //查询所有供应商信息，有条件也条件查询
	   
	    QueryWrapper<Provider> queryWrapper = new QueryWrapper<>();
		
		
		//查询可用的
		queryWrapper.eq("available", Constant.AVAILABLE);
		
		//构造条件
		queryWrapper.like(StringUtils.isNotBlank(providerVo.getProvidername()), "providername", providerVo.getProvidername());
		queryWrapper.like(StringUtils.isNotBlank(providerVo.getConnectionperson()),"connectionperson" ,providerVo.getConnectionperson());
		queryWrapper.like(StringUtils.isNotBlank(providerVo.getAddress()), "address", providerVo.getAddress());
	   
	
       List<Provider> list = providerService.list(queryWrapper);

       String fileName = "供应商数据表.xlsx";
       String sheetName = "供应商数据";

      //拿到内存流
      ByteArrayOutputStream os = ProviderExportUtils.exportProvider(list,sheetName);

      //下载回页面
      try {
         fileName =  URLEncoder.encode(fileName,"UTF-8");
      } catch (UnsupportedEncodingException e) {
          e.printStackTrace();
      }

      HttpHeaders header=new HttpHeaders();
      //封装响应内容类型(APPLICATION_OCTET_STREAM 响应的内容不限定)
      header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
      //设置下载的文件的名称  文件处理方式，附件形式处理，且设置文件名称
      header.setContentDispositionFormData("attachment", fileName);

      return new  ResponseEntity<Object>(os.toByteArray(),header, HttpStatus.CREATED);

  }
  
  
	  /**
	   * 跳转到客户地区分析
	   * @return
	   */
	  @RequestMapping("toCustomerAreaStat")
	  public String toCustomerAreaStat(){
	      
	      return "stat/customerAreaStat";
	  }
	  
	  
	  /**
	     * 查询用户地区信息
	     * @return
	     */
	    @RequestMapping("loadCustomerAreaList")
	    @ResponseBody
	    public List<BaseEntity> loadCustomerAreaList(){
	       return statService.loadCustomerAreaList();
	    }
	    
	    /**
	     * 跳转到公司年度销售额分析
	     * @return
	     */
	    @RequestMapping("toCompanyYearGradeStat")
	    public String toCompanyYearGradeStat(){

	        return "stat/companyYearGradeStat";
	    }
	    
	    /**
	     * 加载年度销售额数据
	     * @param year
	     * @return
	     */
	    @ResponseBody
	    @RequestMapping("loadCompanyYearGrade")
	    public List<Double> loadCompanyYearGrade(String year){
	        List<Double> list = statService.queryCompanyYearGrade(year);

	        //遍历查询如果是结果为空，就设置为0
	        for (int i = 0; i < list.size(); i++) {
	            if (list.get(i) == null){
	                list.set(i,0.0);
	            }
	        }

	        return list;
	    }
	    
	    /**
	     * 去客户销售额页面
	     * @return
	     */
	    @RequestMapping("toCustomerYearSalesManager")
	    public String toCustomerYearSalesManager() {
			return "stat/customerYearSalesManager";
		}
	    
	    
	    /**
	     * 查询客户年度销售额数据
	     * @param year
	     * @return
	     */
	    @ResponseBody
	    @RequestMapping("loadCustomerYearSales")
	    public Map<String,Object> loadCustomerYearSales(@RequestParam("year") String year){
	        //查询到基础数据
	          List<BaseEntity> list = statService.queryCustomerYearSales(year);

	          //下面组装页面需要的数据
	         List<String> names =  new ArrayList<>();
	         List<Double> values =  new ArrayList<>();
	         Map<String,Object> map = new HashMap<>();

	         for (BaseEntity entity : list) {
	        	 //查到的是客户id
	        	 Integer customerid = Integer.parseInt(entity.getName());
	        	 
	        	 Customer customer = customerService.getById(customerid);
        	 
	        	 //查到客户名称放回去
	            names.add(customer.getCustomername());
	            
          
	            //为空设置为0
	            if (entity.getValue() == null) {
					entity.setValue(0.0);
				}
	            
	            values.add(entity.getValue());
	         }

	         map.put("names",names);
	         map.put("values",values);

	         return map;

	    }
	
}
