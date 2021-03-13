package com.shoppingMall.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.shoppingMall.board.dao.QnaDAO;
import com.shoppingMall.board.utill.FileUtils;
import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.board.vo.QnaVO;
import com.shoppingMall.board.vo.SearchCriteria;


@Service
public class QnaServiceImpl implements QnaService {
	@Autowired
	private FileUtils fileUtils;
	@Autowired
	private QnaDAO qnadao;
	
	//게시글 작성
	public void write(QnaVO qnaVO, MultipartHttpServletRequest mpRequest) throws Exception {
		qnadao.write(qnaVO);
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(qnaVO, mpRequest); 
		int size = list.size();
		for(int i=0; i<size; i++){ 
			qnadao.insertFile(list.get(i)); 
		}
	}
	//게시물 목록 조회
	public List<QnaVO> list(SearchCriteria scri) throws Exception {
		return qnadao.list(scri);
	}
	//게시물 총 갯수
	public int listCount(SearchCriteria scri) throws Exception {
		return qnadao.listCount(scri);
	}
	//게시물 조회
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public QnaVO read(int bno) throws Exception {
		qnadao.boardHit(bno);
		return qnadao.read(bno);
	}
	//게시물 수정
	public void update(QnaVO qnaVO, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception {
		qnadao.update(qnaVO);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(qnaVO, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for(int i = 0; i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				qnadao.insertFile(tempMap);
			}else {
				qnadao.updateFile(tempMap);
			}
		}
	}
	//게시물 삭제
	public void delete(int bno) throws Exception {
		qnadao.delete(bno);
	}
	//첨부파일 조회
	public List<Map<String, Object>> selectFileList(int bno) throws Exception {
		return qnadao.selectFileList(bno);
	}
	//첨부파일 다운로드
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return qnadao.selectFileInfo(map);
	}

}