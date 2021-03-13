package com.shoppingMall.product.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.product.vo.ProductVO;

public interface ProductService {
	
//	public Map<String,List<ProductVO>> listProduct() throws Exception;
	public Map productDetail(String _product_no) throws Exception;
	
	public List<String> keywordSearch(String keyword) throws Exception;
//	public List<ProductVO> searchProduct(String searchWord) throws Exception;
	public List<ProductVO> newProductList(Map<String, Object> param) throws Exception;
	public int newProductCount(Map<String, Object> param) throws Exception;
}
