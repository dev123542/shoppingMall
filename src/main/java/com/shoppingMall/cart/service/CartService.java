package com.shoppingMall.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.shoppingMall.cart.vo.CartVO;
import com.shoppingMall.product.vo.ProductVO;

public interface CartService {
	@SuppressWarnings("rawtypes")
	public Map<String, List> myCartList(CartVO cartVO) throws Exception;
	public boolean findCartProduct(CartVO cartVO) throws Exception;
	public void addProductInCart(CartVO cartVO) throws Exception;
	public boolean modifyCartQty(CartVO cartVO) throws Exception;
	public void removeCartProduct(int cart_no) throws Exception;
}
