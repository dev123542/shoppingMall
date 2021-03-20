package com.shoppingMall.admin.member.servicce;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.admin.member.dao.AdminDAO;
import com.shoppingMall.admin.member.dao.AdminDAOImpl;
import com.shoppingMall.member.vo.MemberVO;

@Service("adminService")
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminDAO adminDAO;
	
	// 회원 목록 보여주기
	@Override
	public List<MemberVO> memberList(){
		return adminDAO.memberList();
	}
	
	// 회원 상세 보기
	@Override
	public MemberVO selectMember(String member_id) {
		return adminDAO.selectMember(member_id);
	}
	
	// 관리자 메인 회원수 통계 차트
	@Override
	public List<MemberVO> memberchart(){
		return adminDAO.memberchart();
	}

}
