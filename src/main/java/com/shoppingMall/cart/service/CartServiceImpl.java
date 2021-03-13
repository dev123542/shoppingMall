package com.shoppingMall.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.shoppingMall.cart.dao.CartDAO;
import com.shoppingMall.cart.vo.CartVO;
import com.shoppingMall.product.vo.ProductVO;

@Service("cartService")
@Transactional(propagation=Propagation.REQUIRED)
public class CartServiceImpl  implements CartService{
	@Autowired
	private CartDAO cartDAO;
	
	public Map<String ,List> myCartList(CartVO cartVO) throws Exception{
		Map<String,List> cartMap=new HashMap<String,List>();
		List<CartVO> myCartList=cartDAO.selectCartList(cartVO);
		if(myCartList.size()==0){ 
			return null;
		}
		List<ProductVO> myProductList=cartDAO.selectProductList(myCartList);
		cartMap.put("myCartList", myCartList);
		cartMap.put("myProductList",myProductList);
		return cartMap;
	}
	
	public boolean findCartProduct(CartVO cartVO) throws Exception{
		 return cartDAO.selectCountInCart(cartVO);
		
	}	
	public void addProductInCart(CartVO cartVO) throws Exception{
		cartDAO.insertProductInCart(cartVO);
	}
	
	public boolean modifyCartQty(CartVO cartVO) throws Exception{
		boolean result=true;
		cartDAO.updateCartProductCount(cartVO);
		return result;
	}
	public void removeCartProduct(int cart_id) throws Exception{
		cartDAO.deleteCartProduct(cart_id);
	}
	
}
