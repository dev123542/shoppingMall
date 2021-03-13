package com.shoppingMall.product.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.product.vo.ImageFileVO;
import com.shoppingMall.product.vo.ProductVO;

public interface ProductDAO {
	public List<ProductVO> selectProductList(String productStatus) throws DataAccessException;
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	public ProductVO selectProductDetail(String product_no) throws DataAccessException;
//	public List<ImageFileVO> selectProductsDetailImage(String product_id) throws DataAccessException;
//	public List<ProductVO> selectProductBySearchWord(String searchWord) throws DataAccessException;
	public List<ProductVO> newProductList(Map<String, Object> param) throws DataAccessException;
	public int newProductCount(Map<String, Object> param) throws DataAccessException;
	//public List<ImageFileVO> selectProductDetailImage(String product_no) throws DataAccessException;
}
