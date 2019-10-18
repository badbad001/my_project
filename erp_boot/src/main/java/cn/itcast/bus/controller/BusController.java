package cn.itcast.bus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("bus")
@Controller
public class BusController {
	
	/**
	 * 去客户页面
	 * @return
	 */
	@RequestMapping("toCustomerManager")
	public String toCustomerManager() {
		return "bus/customer/customerManager";
	
	}
	
	/**
	 * 去供应商页面
	 * @return
	 */
	@RequestMapping("toProviderManager")
	public String toProviderManager() {
		return "bus/provider/providerManager";
		
	}
	
	/**
	 * 去商品页面
	 * @return
	 */
	@RequestMapping("toGoodsManager")
	public String toGoodsManager() {
		return "bus/goods/goodsManager";
		
	}
	
	/**
	 * 去进货页面
	 * @return
	 */
	@RequestMapping("toInportManager")
	public String toInportManager() {
		return "bus/inport/inportManager";
		
	}
	
	/**
	 * 去退货页面
	 * @return
	 */
	@RequestMapping("toOutportManager")
	public String toOutportManager() {
		return "bus/outport/outportManager";
		
	}
	
	/**
	 * 去销售页面
	 * @return
	 */
	@RequestMapping("toSalesManager")
	public String toSalesManager() {
		return "bus/sales/salesManager";
		
	}
	
	/**
	 * 去销售页面
	 * @return
	 */
	@RequestMapping("toSalesBackManager")
	public String toSalesBackManager() {
		return "bus/salesback/salesBackManager";
		
	}

}
