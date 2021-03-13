package com.shoppingMall.cart.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

public interface CartController {
//	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public @ResponseBody String addProductInCart(@RequestParam("product_no") int product_no, HttpServletRequest request, HttpServletResponse response)throws Exception;
//	public @ResponseBody String modifyCartQty(@RequestParam("product_no") int product_no,@RequestParam("cart_product_qty") int cart_product_qty,
//			                  HttpServletRequest request, HttpServletResponse response)  throws Exception;
//	public ModelAndView removeCartProduct(@RequestParam("cart_id") int cart_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	

}
