package com.shoppingMall.admin.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shoppingMall.member.vo.MemberVO;
import com.shoppingMall.order.vo.OrderVO;

@Repository("adminDAO")
public class AdminDAOImpl implements AdminDAO{

	@Autowired
	private SqlSession sqlSession;
	
	// 회원 목록 보여주기
//	public List<MemberVO> memberList(MemberVO membervo){
	@Override
	public List<MemberVO> memberList(){
		return sqlSession.selectList("memberList");
	}
	
	// 회원 상세 보기
	@Override
	public MemberVO selectMember(String member_id) {
		return sqlSession.selectOne("selectMember", member_id);
	}

	// 관리자 메인 회원수 통계 차트
	@Override
	public List<MemberVO> memberchart(){
		return sqlSession.selectList("memberchart");
	}
	// 관리자 메인 월별 매출액 차트
	@Override
	public List<OrderVO> orderChart(){
		return sqlSession.selectList("orderChart");
	}
}
