package com.shoppingMall.admin.order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.admin.order.service.AdminOrderService;
import com.shoppingMall.order.vo.OrderVO;

@Controller("adminOrderContoller")
@RequestMapping("/admin/order")
public class AdminOrderController {
	
	@Autowired
	private AdminOrderService adminOrderService;

	// 주문 목록
	@RequestMapping(value="/adminOrderList.do", method=RequestMethod.GET)
	public ModelAndView adminOrderList(HttpServletRequest request) {
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		try {
			List<OrderVO> orderList = adminOrderService.adminOrderList();
			mav.addObject("orderList", orderList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
}
