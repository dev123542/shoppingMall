package com.shoppingMall.admin.product.service;

import java.util.List;
import java.util.Map;

import com.shoppingMall.board.vo.CriteriaVO;

import net.sf.json.JSONObject;


public interface AdminProductService {
	public int addNewProduct(Map<String, Object> newProductMap) throws Exception;
//	public Map<String, Object> selectProductList() throws Exception;
//	public Map<String, Object> selectProductList(CriteriaVO cri) throws Exception;
	public Map<String, Object> selectAdminProductList(Map param) throws Exception;
	public int selectAdminProductListCount() throws Exception;
	public int adminProductSearchCount(Map searchCount) throws Exception;
	public void insertNewProductDetail(Map productDetailMap)throws Exception;
//	public JSONObject chart() throws Exception;
	
}
