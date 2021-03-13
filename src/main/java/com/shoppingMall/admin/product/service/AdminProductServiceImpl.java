package com.shoppingMall.admin.product.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.shoppingMall.admin.product.dao.AdminProductDAO;
import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.product.controller.ProductControllerImpl;
import com.shoppingMall.product.vo.CategoryVO;
import com.shoppingMall.product.vo.ImageFileVO;
import com.shoppingMall.product.vo.ProductDetailVO;
import com.shoppingMall.product.vo.ProductVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("adminProductService")
public class AdminProductServiceImpl implements AdminProductService {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminProductServiceImpl.class);

	@Autowired
	private AdminProductDAO adminProductDAO;

	// 상품 등록
	public int addNewProduct(Map<String, Object> newProductMap) throws Exception {
		int product_no = adminProductDAO.addNewProduct(newProductMap);
		ArrayList<ImageFileVO> imageFileList = (ArrayList<ImageFileVO>) newProductMap.get("imageFileList");
		for (ImageFileVO imageFileVO : imageFileList) {
			imageFileVO.setProduct_no(product_no);
		}
		// 파일 테이블에 상품 이미지 등록(삭제할 생각)
		//adminProductDAO.inserProductImageFile(imageFileList);
		return product_no;
	}

	// 상품 목록
//	public Map<String, Object> selectProductList(Map condMap) throws Exception{
//		Map<String, Object> productMap = new HashedMap();
//		List<ProductVO> productList = adminProductDAO.selectProductList(condMap);
//		List<ProductVO> modelList = adminProductDAO.selectProductDetailList();
//		productMap.put("productList", productList);
//		productMap.put("modelList", modelList);
//		return productMap;
//	}
//	public Map<String, Object> selectProductList() throws Exception{
//		Map<String, Object> productMap = new HashedMap();
//		List<ProductVO> productList = adminProductDAO.selectProductList();
//		productMap.put("productList", productList);
//		return productMap;
//	}
//	public Map<String, Object> selectProductList(CriteriaVO cri) throws Exception {
//		Map<String, Object> productMap = new HashedMap();
//		List<ProductVO> productList = adminProductDAO.selectProductList(cri);
//		productMap.put("productList", productList);
//		return productMap;
//	}
	public Map<String, Object> selectAdminProductList(Map param) throws Exception {
		Map<String, Object> productMap = new HashedMap();
		List<ProductVO> productList = adminProductDAO.selectAdminProductList(param);
		productMap.put("productList", productList);
		List<ProductDetailVO> modelList = adminProductDAO.selectProductDetail();
		productMap.put("modelList", modelList);
		return productMap;
	}

	// 상품 개수
	public int selectAdminProductListCount() throws Exception {
		return adminProductDAO.selectAdminProductListCount();
	}
	
	// 상품 목록 검색 개수
	public int adminProductSearchCount(Map searchCount) throws Exception{
		return adminProductDAO.adminProductSearchCount(searchCount);
	}
	
	// 상품 목록에서 정보 추가
	public void insertNewProductDetail(Map productDetailMap)throws Exception{
		adminProductDAO.insertNewProductDetail(productDetailMap);
	}
	
	// 관리자 메인에서 차트 
//	public JSONObject chart() throws Exception{
//		List<CategoryVO> items = adminProductDAO.chart();
//		//리턴할 json 객체
//		JSONObject data = new JSONObject();
//		
//		// json의 컬럼 객체
//		JSONObject col1 = new JSONObject();
//		
//		//json 배열 객체에 저장
//		JSONArray title = new JSONArray();
//		col1.put("label", "카테고리이름");
//		// 테이블행에 컬럼 추가
//		title.add(col1);
//		
//		//json 객체에 타이틀행 추가  {"cols" : [{"label" : "카테고리이름"}]}
//		data.put("cols", title);
//		
//		JSONArray body = new JSONArray();
//		for(CategoryVO c : items) {
//			JSONObject name = new JSONObject();
//			name.put("cate", c.getCate_name());
//			
//			JSONArray row = new JSONArray();
//			row.add(name);  //테이블의 행에 저장
//			body.add(row);
//		}
//		data.put("row", body);
//		
//		
//		return data;
//	}
}