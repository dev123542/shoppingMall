package com.shoppingMall.cart.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.admin.product.controller.AdminProductContoller;
import com.shoppingMall.cart.service.CartService;
import com.shoppingMall.cart.vo.CartVO;
import com.shoppingMall.common.base.BaseController;
import com.shoppingMall.product.vo.ProductVO;
import com.shoppingMall.member.vo.MemberVO;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{
	
	private static final Logger logger = LoggerFactory.getLogger(CartControllerImpl.class);
	
	@Autowired
	private CartService cartService;
	@Autowired
	private CartVO cartVO;
	@Autowired(required=false)
	private MemberVO memberVO;
	
	//myCartMain
	@RequestMapping(value="/myCartList.do" , method = RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String memberID = (String) session.getAttribute("member");
		cartVO.setMember_id(memberID);
		
		Map<String, List> cartMap = cartService.myCartList(cartVO);
//		logger.info("카트:"+cartMap.get("myCartList"));
//		logger.info("상품:"+cartMap.get("myProductList"));
		session.setAttribute("cartMap", cartMap);
		mav.addObject("cartMap", cartMap);
		return mav;
	}
	
	// 장바구니에 담기 버튼 눌렀을 때
	@RequestMapping(value="/addProductInCart.do" ,method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public @ResponseBody String addProductInCart(@RequestParam("product_no") int product_no, 
			HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
//		memberVO=(MemberVO)session.getAttribute("memberInfo");
//		String member_id=memberVO.getMember_id();
		String member = (String) session.getAttribute("member");
		
		cartVO.setProduct_no(product_no);
//		cartVO.setMember_id(member_id);
		cartVO.setMember_id(member);
		logger.info("장바구니:"+cartVO.toString());
		boolean isAreadyExisted=cartService.findCartProduct(cartVO);
		System.out.println("isAreadyExisted:"+isAreadyExisted);
		if(isAreadyExisted==true){
			return "already_existed";
		}else{
			cartService.addProductInCart(cartVO);
			return "add_success";
		}
	}
	
	@RequestMapping(value="/removeCartProduct.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartProduct(@RequestParam("cart_no") int cart_no,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		cartService.removeCartProduct(cart_no);
		mav.setViewName("redirect:/cart/myCartList.do");
		return mav;
	}
	
	@RequestMapping(value="/modifyCartQty.do" ,method = RequestMethod.POST)
	public @ResponseBody String  modifyCartQty(@RequestParam("product_no") int product_no,
			                                   @RequestParam("cart_goods_qty") int cart_goods_qty,
			                                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMember_id();
		cartVO.setProduct_no(product_no);
		cartVO.setMember_id(member_id);
		cartVO.setCart_goods_qty(cart_goods_qty);
		boolean result=cartService.modifyCartQty(cartVO);
		
		if(result==true){
		   return "modify_success";
		}else{
			  return "modify_failed";	
		}
		
	}
	
    
}
