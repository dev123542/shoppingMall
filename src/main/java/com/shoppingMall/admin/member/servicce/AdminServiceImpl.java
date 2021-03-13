package com.shoppingMall.admin.member.servicce;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingMall.admin.member.dao.AdminDAOImpl;
import com.shoppingMall.member.vo.MemberVO;

@Service("adminService")
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminDAOImpl adminDAO;
	
	// 회원 목록 보여주기
	public List<MemberVO> memberList(){
		return adminDAO.memberList();
	}
	
	// 회원 상세 보기
	public MemberVO selectMember(String member_id) {
		return adminDAO.selectMember(member_id);
	}

}
