package com.shoppingMall.cart.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.shoppingMall.cart.vo.CartVO;
import com.shoppingMall.product.vo.ProductVO;

@Repository("cartDAO")
public class CartDAOImpl implements CartDAO{
	@Autowired
	private SqlSession sqlSession;
	
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {
		List<CartVO> cartList = (List)sqlSession.selectList("mapper.cart.selectCartList",cartVO);
		return cartList;
	}
	

	public List<ProductVO> selectProductList(List<CartVO> cartList) throws DataAccessException {
		List<ProductVO> myProductList;
		myProductList = sqlSession.selectList("mapper.cart.selectProductList",cartList);
		System.out.println("카트 상품 dao:"+myProductList.toString());
		return myProductList;
	}
	
		
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException {
		String  result = sqlSession.selectOne("mapper.cart.selectCountInCart",cartVO);
		return Boolean.parseBoolean(result);
	}

	public void insertProductInCart(CartVO cartVO) throws DataAccessException{
		int cart_no = selectMaxCartId();
		cartVO.setCart_no(cart_no);
		sqlSession.insert("mapper.cart.insertProductInCart",cartVO);
	}
	
	
	public void updateCartProductCount(CartVO cartVO) throws DataAccessException{
		sqlSession.insert("mapper.cart.updateCartProductCount",cartVO);
	}
	
	public void deleteCartProduct(int cart_no) throws DataAccessException{
		sqlSession.delete("mapper.cart.deleteCartProduct",cart_no);
	}

	private int selectMaxCartId() throws DataAccessException{
		int cart_no = sqlSession.selectOne("mapper.cart.selectMaxCartId");
		return cart_no;
	}

	
	

}
