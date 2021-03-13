package com.shoppingMall.admin.member.servicce;

import java.util.List;

import com.shoppingMall.member.vo.MemberVO;

public interface AdminService {
	public List<MemberVO> memberList();
	public MemberVO selectMember(String member_id);

}
