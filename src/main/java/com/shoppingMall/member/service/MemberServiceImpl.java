package com.shoppingMall.member.service;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.member.dao.MemberDAO;
import com.shoppingMall.member.vo.MemberVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;
	
	// 회원 가입
	public int signUp(MemberVO membervo) throws Exception {
		return memberDAO.signUp(membervo);
	}
	
	// 회원 가입 아이디 중복 확인
	public int idCheck(String member_id) throws Exception {
		return memberDAO.idCheck(member_id);
	}
	
	// 로그인
	public MemberVO login(MemberVO membervo) throws Exception {
		return memberDAO.login(membervo);
	}

	// 아이디 찾기
	public List<MemberVO> findId(MemberVO membervo) throws Exception { 
		return memberDAO.findId(membervo);
	}

		
	// 회원 정보 수정에서 정보 보여주기
	public MemberVO showInfo(String member_id) throws Exception {
		return memberDAO.showInfo(member_id);
	}
	
	// 회원 정보 수정에서 현재 비밀번호 비교
	public MemberVO pwCheck(MemberVO membervo) throws Exception {
		return memberDAO.pwCheck(membervo);
	}
	
	// 회원 정보 수정
	public int updateMyInfo(MemberVO membervo) throws Exception {
		return memberDAO.updateMyInfo(membervo);
	}
	
	// 회원 탈퇴
	public boolean signOut(String member_id, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if(memberDAO.siginOut(member_id) != 1) {
			out.println("<script>");
			out.println("alert('회원탈퇴 실패');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return false;
		}else {
			//탈퇴 성공
			return true;
		}
	}
	
	// 관리자 로그인
	public MemberVO adminLogin(MemberVO membervo) throws Exception{
		return memberDAO.adminLogin(membervo);
	}

	
}
