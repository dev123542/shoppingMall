package com.shoppingMall.admin.product.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.shoppingMall.admin.product.controller.AdminProductContoller;
import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.product.vo.CategoryVO;
import com.shoppingMall.product.vo.ImageFileVO;
import com.shoppingMall.product.vo.ProductDetailVO;
import com.shoppingMall.product.vo.ProductVO;


@Repository("adminProductDAO")
public class AdminProductDAOImpl implements AdminProductDAO{
	
	private static final Logger logger = LoggerFactory.getLogger(AdminProductDAOImpl.class);

	@Autowired
	private SqlSession sqlSession;
	
	// 상품 등록
	public int addNewProduct(Map<String, Object> newProductMap) throws DataAccessException{
		System.out.println("dao"+newProductMap.get("file_name"));
		
		ArrayList<ImageFileVO> imageFileList = (ArrayList<ImageFileVO>) newProductMap.get("imageFileList");
		System.out.println("imageFileList:"+imageFileList);
		System.out.println(imageFileList.get(0).getFile_name());
		
		// 상품 테이블에 메인 이미지(썸네일) 넣기
		newProductMap.put("file_name",imageFileList.get(0).getFile_name());
		sqlSession.insert("addNewProduct", newProductMap);
		
		// 상품 번호 반환
		return (int) newProductMap.get("product_no");
	}
	
	// 파일 테이블에 상품 이미지 등록(삭제할 생각)
//	public void inserProductImageFile(List fileList) throws DataAccessException{
//		for(int i = 0; i < fileList.size(); i++) {
//			System.out.println("dao에서 fileList:"+fileList.get(i).toString());
//			ImageFileVO imageFileVO = (ImageFileVO) fileList.get(i);
//			sqlSession.insert("insertProductImageFile", imageFileVO);
//		}
//	}
	
	// 상품 목록
//	public List<ProductVO> selectProductList(Map condMap) throws DataAccessException{
//		return sqlSession.selectList("selectProductList", condMap);
//	}
//	public List<ProductVO> selectProductList() throws DataAccessException{
//		return sqlSession.selectList("selectProductList");
//	}
//	public List<ProductVO> selectProductList(CriteriaVO cri) throws DataAccessException{
//		return sqlSession.selectList("selectProductList", cri);
//	}
	public List<ProductVO> selectAdminProductList(Map param) throws DataAccessException{
		return sqlSession.selectList("selectAdminProductList", param);
	}
	
	// 상품 개수
	public int selectAdminProductListCount() throws DataAccessException{
		return sqlSession.selectOne("selectAdminProductListCount");
	}
	
	// 상품 검색 결과 총 개수
	public int adminProductSearchCount(Map searchCount) throws DataAccessException{
		return sqlSession.selectOne("adminProductSearchCount", searchCount);
	}
	
	// 상품 목록에서 새 정보 추가
	public void insertNewProductDetail(Map productDetailMap) throws DataAccessException{
		sqlSession.insert("insertNewProductDetail", productDetailMap);
	}
	
	// 상품 목록에 상품추가정보 불러오기
	public List<ProductDetailVO> selectProductDetail() throws DataAccessException{
		return sqlSession.selectList("selectAdminProductDetail");
	}
	
	// 관리자 메인에서 차트
//	public List<CategoryVO> chart()  throws DataAccessException{
//		return sqlSession.selectList("chart");
//	}
}