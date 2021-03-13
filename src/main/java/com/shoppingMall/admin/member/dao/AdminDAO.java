package com.shoppingMall.admin.member.dao;

import java.util.List;

import com.shoppingMall.member.vo.MemberVO;

public interface AdminDAO {
	public List<MemberVO> memberList();
	public MemberVO selectMember(String member_id);
}
