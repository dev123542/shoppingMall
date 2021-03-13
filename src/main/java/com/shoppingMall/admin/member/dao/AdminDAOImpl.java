package com.shoppingMall.admin.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shoppingMall.member.vo.MemberVO;

@Repository("adminDAO")
public class AdminDAOImpl implements AdminDAO{

	@Autowired
	private SqlSession sqlSession;
	
	// 회원 목록 보여주기
//	public List<MemberVO> memberList(MemberVO membervo){
	public List<MemberVO> memberList(){
		return sqlSession.selectList("memberList");
	}
	
	// 회원 상세 보기
	public MemberVO selectMember(String member_id) {
		return sqlSession.selectOne("selectMember", member_id);
	}
}
