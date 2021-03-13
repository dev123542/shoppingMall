package com.shoppingMall.product.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.product.dao.ProductDAO;
import com.shoppingMall.product.vo.ImageFileVO;
import com.shoppingMall.product.vo.ProductVO;
//import com.shoppingMall.product.vo.ImageFileVO;

@Service("productService")
@Transactional(propagation=Propagation.REQUIRED)
public class ProductServiceImpl implements ProductService{
	@Autowired
	private ProductDAO productDAO;
	
	/*
	public Map<String,List<ProductVO>> listProduct() throws Exception {
		Map<String,List<ProductVO>> productMap=new HashMap<String,List<ProductVO>>();
		List<ProductVO> productList=productDAO.selectProductList("bestseller");
		productMap.put("bestseller",productList);
		productList=productDAO.selectProductList("newbook");
		productMap.put("newbook",productList);
		
		productList=productDAO.selectProductList("steadyseller");
		productMap.put("steadyseller",productList);
		return productMap;
	}
	*/
	public Map productDetail(String _product_no) throws Exception {
		Map productMap=new HashMap();
		ProductVO productVO = productDAO.selectProductDetail(_product_no);
		productMap.put("productVO", productVO);
		// (삭제할 생각)
		//List<ImageFileVO> imageList =productDAO.selectProductDetailImage(_product_no);
		//productMap.put("imageList", imageList);
		
		return productMap;
	}
	
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=productDAO.selectKeywordSearch(keyword);
		return list;
	}
	
	/*
	public List<ProductVO> searchProduct(String searchWord) throws Exception{
		List productList=productDAO.selectProductBySearchWord(searchWord);
		return productList;
	}
	*/
	
	
	// new 카테고리의 상품 목록
	public List<ProductVO> newProductList(Map<String, Object> param) throws Exception{
		return productDAO.newProductList(param);
	}
	
	// new 카테고리의 총 상품 개수
	public int newProductCount(Map<String, Object> param) throws Exception {
		return productDAO.newProductCount(param);
	}
}
