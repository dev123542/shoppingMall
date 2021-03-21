package com.shoppingMall.admin.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.admin.member.servicce.AdminService;
import com.shoppingMall.member.vo.MemberVO;
import com.shoppingMall.order.vo.OrderVO;
import com.sun.media.jfxmedia.logging.Logger;

@Controller("adminMainController")
@RequestMapping("/admin/main")
public class AdminMainController {
	
	@Autowired
	private AdminService adminServie;
	
	// 메뉴에 맞는 페이지 이동
//	@RequestMapping(value="/{path}/*.do", method= {RequestMethod.GET, RequestMethod.POST})
//	private ModelAndView adminView(@PathVariable("path") String path,HttpServletRequest request, HttpServletResponse response) {
//		ModelAndView mav = new ModelAndView();
//		String viewName = (String)request.getAttribute("viewName");
//		mav.setViewName(viewName);
//		return mav;
//	}
	
	// 관리자 메인 페이지
	@RequestMapping(value="/main.do")
	private ModelAndView adminMain(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String viewName = (String)request.getAttribute("viewName");
		
		// 차트 그리기 위한 데이터
		// 회원 통계
		List<MemberVO> list = adminServie.memberchart();
		System.out.println("list:"+list.toString());
		
		// 월별 매출 통계
		List<OrderVO> orderList = adminServie.orderChart();
		System.out.println("order:"+orderList.toString());
		
		mav.addObject("list",list);
		mav.addObject("orderList",orderList);
		mav.setViewName(viewName);
		return mav;
	}
	
}
