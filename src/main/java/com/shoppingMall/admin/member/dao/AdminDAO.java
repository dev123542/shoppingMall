package com.shoppingMall.admin.member.dao;

import java.util.List;

import com.shoppingMall.member.vo.MemberVO;
import com.shoppingMall.order.vo.OrderVO;

public interface AdminDAO {
	public List<MemberVO> memberList();
	public MemberVO selectMember(String member_id);
	public List<MemberVO> memberchart();
	public List<OrderVO> orderChart();
}
