package com.shoppingMall.admin.member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.admin.member.servicce.AdminServiceImpl;
import com.shoppingMall.member.vo.MemberVO;

@Controller("adminMemberController")
@RequestMapping("/admin/member")
public class AdminMemberController {

	@Autowired
	private AdminServiceImpl adminService;

	// 회원 목록 보여주기 - 검색창 아직 안만들었음, 페이징도 아직못함, 수정해야 함
	@RequestMapping(value = "/memberList.do", method = { RequestMethod.GET, RequestMethod.POST })
	private ModelAndView memberList(HttpServletRequest request, HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		List<MemberVO> list = adminService.memberList();
		mav.addObject("list", list);
		return mav;
	}
	
	// 회원 정보 상세보기 - 상세 정보에 어떤걸 넣어야 할지 생각해보기, 수정해야 함
	@RequestMapping(value="selectMember.do", method= {RequestMethod.GET, RequestMethod.POST})
	private ModelAndView selectMember(@RequestParam("member_id") String member_id,HttpServletRequest request, HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		MemberVO membervo = adminService.selectMember(member_id);
		mav.addObject("membervo", membervo);
		return mav;
	}
	

}
