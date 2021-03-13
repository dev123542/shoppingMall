package com.shoppingMall.admin.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller("adminMainController")
@RequestMapping("/admin/main")
public class AdminMainController {
	
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
		mav.setViewName(viewName);
		return mav;
	}
	
}
