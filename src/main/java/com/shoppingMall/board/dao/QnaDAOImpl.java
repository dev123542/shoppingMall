package com.shoppingMall.board.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.board.vo.QnaVO;
import com.shoppingMall.board.vo.SearchCriteria;


@Repository
public class QnaDAOImpl implements QnaDAO {

	@Autowired
	private SqlSession sqlSession;
	
	//게시글 작성
	public void write(QnaVO qnaVO) throws Exception {
		sqlSession.insert("insert",qnaVO);
	}
	//게시물 목록 조회
	public List<QnaVO> list(SearchCriteria scri) throws Exception {
		return sqlSession.selectList("listPage", scri);
	}
	//게시물 총 갯수
	public int listCount(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne("listCount", scri);
	}
	//게시물 조회
	public QnaVO read(int bno) throws Exception {
		return sqlSession.selectOne("read", bno);
	}
	//게시물 수정
	public void update(QnaVO qnaVO) throws Exception {
		sqlSession.update("update", qnaVO);
	}
	//게시물 삭제
	public void delete(int bno) throws Exception {
		sqlSession.delete("delete", bno);
	}
	//첨부파일 업로드
	public void insertFile(Map<String, Object> map) throws Exception {
		sqlSession.insert("insertFile", map);
	}
	//첨부파일 조회
	public List<Map<String, Object>> selectFileList(int bno) throws Exception {
		return sqlSession.selectList("selectFileList", bno);
	}
	//첨부파일 다운로드
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("selectFileInfo", map);
	}
	//첨부파일 수정
	public void updateFile(Map<String, Object> map) throws Exception {
		sqlSession.update("updateFile", map);
	}
	//게시판 조회수
	public void boardHit(int bno) throws Exception {
		sqlSession.update("boardHit", bno);
	}
}
