package com.shoppingMall.admin.product.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.product.vo.CategoryVO;
import com.shoppingMall.product.vo.ProductDetailVO;
import com.shoppingMall.product.vo.ProductVO;


public interface AdminProductDAO {
	public int addNewProduct(Map<String, Object> newProductMap) throws DataAccessException;
//	public void inserProductImageFile(List fileList) throws DataAccessException;
//	public List<ProductVO> selectProductList() throws DataAccessException;
//	public List<ProductVO> selectProductList(CriteriaVO cri) throws DataAccessException;
	public List<ProductVO> selectAdminProductList(Map param) throws DataAccessException;
	public int selectAdminProductListCount() throws DataAccessException;
	public int adminProductSearchCount(Map searchCount) throws DataAccessException;
	public void insertNewProductDetail(Map productDetailMap) throws DataAccessException;
	public List<ProductDetailVO> selectProductDetail() throws DataAccessException;
//	public List<CategoryVO> chart()  throws DataAccessException;
}
