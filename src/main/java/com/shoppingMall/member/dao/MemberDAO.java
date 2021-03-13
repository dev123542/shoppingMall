package com.shoppingMall.member.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.shoppingMall.member.vo.MemberVO;

public interface MemberDAO {

	public int signUp(MemberVO membervo) throws DataAccessException;
	public MemberVO login(MemberVO membervo) throws DataAccessException;
	public List<MemberVO> findId(MemberVO membervo) throws DataAccessException; 
	public int idCheck(String member_id) throws DataAccessException;
	public MemberVO showInfo(String member_id) throws DataAccessException;
	public MemberVO pwCheck(MemberVO membervo) throws DataAccessException;
	public int updateMyInfo(MemberVO membervo) throws DataAccessException;
	public int siginOut(String member_id) throws DataAccessException;
	public MemberVO adminLogin(MemberVO membervo) throws DataAccessException;
}
