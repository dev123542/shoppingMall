package com.shoppingMall.common;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.shoppingMall.member.vo.MemberVO;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	// 주소창에서 입력해도 관리자 페이지로 접속 못하게 함
	// 세션으로 비교해서 회원과 관리자를 구분함

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		HttpSession session = request.getSession();
		MemberVO membervo = (MemberVO) session.getAttribute("admin");

		// 로그인 상태가 아닌 경우
		if (membervo == null) {
			try {
				response.sendRedirect("/project/member/loginForm.do");
				return false;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 로그인했지만 관리자가 아닌 경우
		if (!(membervo.getAuthority().equals("1")) && membervo.getAuthority() == null) {
			try {
				response.sendRedirect("/project/");
				return false;
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		//관리자인 경우	
		} else {
			return true;
		}

		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}
