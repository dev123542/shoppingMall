package com.shoppingMall.cart.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.shoppingMall.cart.vo.CartVO;
import com.shoppingMall.product.vo.ProductVO;

public interface CartDAO {
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException;
	public List<ProductVO> selectProductList(List<CartVO> cartList) throws DataAccessException;
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException;
	public void insertProductInCart(CartVO cartVO) throws DataAccessException;
	public void updateCartProductCount(CartVO cartVO) throws DataAccessException;
	public void deleteCartProduct(int cart_no) throws DataAccessException;
	
	

}
