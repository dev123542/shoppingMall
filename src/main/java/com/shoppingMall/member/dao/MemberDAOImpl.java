package com.shoppingMall.member.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.shoppingMall.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO{

	@Autowired
	private SqlSession sqlSession;
	
	// 회원 가입
	public int signUp(MemberVO membervo) throws DataAccessException{
		return sqlSession.insert("signUp", membervo);
	}
	
	// 회원가입 아이디 중복 확인
	public int idCheck(String member_id) throws DataAccessException{
		return sqlSession.selectOne("idCheck", member_id);
	}
	
	// 로그인
	public MemberVO login(MemberVO membervo) throws DataAccessException{
		return sqlSession.selectOne("login", membervo);
	}
	
	// 아이디 찾기
	public List<MemberVO> findId(MemberVO membervo) throws DataAccessException {
		return sqlSession.selectList("findId" , membervo);
	}


	// 회원 정보 수정에서 정보 보여주기
	public MemberVO showInfo(String member_id) throws DataAccessException{
		return sqlSession.selectOne("showInfo",member_id);
	}
	
	// 회원 정보 수정에서 현재 비밀번호 비교
	public MemberVO pwCheck(MemberVO membervo) throws DataAccessException{
		return sqlSession.selectOne("pwCheck",membervo);
	}
	
	// 회원 정보 수정
	public int updateMyInfo(MemberVO membervo) throws DataAccessException{
		return sqlSession.update("updateMyInfo", membervo);
	}
	
	// 회원 탈퇴
	public int siginOut(String member_id) throws DataAccessException{
		return sqlSession.delete("siginOut",member_id);
	}
	
	// 관리자 로그인
	public MemberVO adminLogin(MemberVO membervo) throws DataAccessException{
		return sqlSession.selectOne("adminLogin", membervo);
	}


}
