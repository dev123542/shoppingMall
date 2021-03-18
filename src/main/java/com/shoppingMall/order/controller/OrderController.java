package com.shoppingMall.order.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.order.service.OrderService;
import com.shoppingMall.order.vo.OrderDetailsVO;
import com.shoppingMall.order.vo.OrderListVO;
import com.shoppingMall.order.vo.OrderVO;
import com.shoppingMall.product.vo.ProductVO;

@Controller("orderController")
@RequestMapping("/order")
public class OrderController {

	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private OrderService orderService;
	
	// 상품 바로 주문 화면
	@RequestMapping(value="/orderMain.do", method=RequestMethod.GET)
	public ModelAndView orderMain(@ModelAttribute("product") ProductVO productvo,HttpServletRequest request) throws Exception{
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		//int product_no = Integer.parseInt(String.valueOf(request.getParameter("product_no")));
		
		mav.addObject("productvo",productvo);
		
		return mav;
	}
	
	
	// 장바구니 주문 화면
	@RequestMapping(value = "/orderCartMain.do")
	public ModelAndView orderCartMain(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("/order/orderMain");
		HttpSession session = request.getSession();
		String member_id = (String) session.getAttribute("member");
		try {
			Map<String, List> cartMap = orderService.selectOrderCartList(member_id);
			int amount = orderService.selectOrderCount(member_id);
			mav.addObject("cartMap", cartMap);
			mav.addObject("member_id", member_id);
			mav.addObject("amount", amount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	// 주문 하기
	@RequestMapping(value = "/order.do", method = RequestMethod.POST)
	public ModelAndView order(@RequestParam Map<String, String> orderMap, HttpServletRequest request) {
//		public ModelAndView order(OrderVO orderVO, OrderDetailsVO orderDetailVO, HttpServletRequest request) {
		/*
		   파라미터(맵으로 받아야겠음) - 일단은 회원만 주문 가능, 비회원은 제외
		 	 1. 회원
		 	  - 수령인이름: orderRec
		 	  - 연락처1 : emergency21 + emergency22 + emergency23 -> 합치기
		 	  - 주소 : member_add1 / member_add2 / member_add3 -> 3개 각자 저장
		 	  - 배송 메세지 : order_msg
		 	 
		 	 2. 비회원
		 	  - 이름 :
		 	  - 이메일 : 이메일 앞자리+뒷자리 -> 합치기
		 	  - 전화 번호 : 앞+중+끝 -> 합치기
		*/
		
		// 주문 완료 후 주문한 정보를 보여주는 페이지로 이동 - 아직 안만듦
		String viewName = "/order/orderComplete";
		ModelAndView mav = new ModelAndView(viewName);
		
		logger.info("orderMap:" + orderMap.toString());
		OrderDetailsVO orderDetailVO = new OrderDetailsVO();
		OrderVO orderVO = new OrderVO();
		
		// 맵에 저장된 파라미터 뽑아서 orderVO 객체에 담기
		String orderRec = orderMap.get("orderRec");
		String emergency21 = orderMap.get("emergency21");
		String emergency22 = orderMap.get("emergency22");
		String emergency23 = orderMap.get("emergency23");
		String phone = emergency21 + emergency22 + emergency23;
		String member_add1 = orderMap.get("member_add1");
		String member_add2 = orderMap.get("member_add2");
		String member_add3 = orderMap.get("member_add3");
		String order_msg = orderMap.get("order_msg");
		String payment = orderMap.get("payment");
		String bank = orderMap.get("bank");
		String status = "배송준비";
		int amount = Integer.parseInt(orderMap.get("amount"));
		int totalGoodsPrice = Integer.parseInt(orderMap.get("totalGoodsPrice"));
		
		orderVO.setOrderRec(orderRec);
		orderVO.setMember_add1(member_add1);
		orderVO.setMember_add2(member_add2);
		orderVO.setMember_add3(member_add3);
		orderVO.setOrder_msg(order_msg);
		orderVO.setPhone(phone);
		orderVO.setPayment(payment);
		orderVO.setBank(bank);
		orderVO.setStatus(status);
		orderVO.setTotal_goods_price(totalGoodsPrice);
		orderVO.setAmount(amount);
		
		// 세션에 저장된 로그인한 아이디 뽑기
		HttpSession session = request.getSession();
		String member_id = (String) session.getAttribute("member");
		
		// 년/월/일과 랜덤숫자를 이용해 주문 번호 만들기
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";

		// 무작위 6자리 숫자 생성
		for (int i = 1; i <= 6; i++) {
			subNum += (int) (Math.random() * 10);
		}

		// 주문번호 = "날짜-랜덤숫자"
		String order_no = ymd + "-" + subNum;

		try {
			// 주문 정보 저장
			orderVO.setOrder_no(order_no);
			orderVO.setMember_id(member_id);
			orderService.orderInfo(orderVO);
			
			List<OrderVO> orderList = orderService.orderComplete(order_no);
			mav.addObject("orderList", orderList);
			
			// 주문 상세 정보 저장 - 무결성 제약 오류남(해결)
			orderDetailVO.setOrder_no(order_no);
			orderService.orderInfoDetails(orderDetailVO);
			
			// 주문 후 장바구니 지우기
			orderService.deleteCart(member_id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	// 특정 회원의 주문 목록 조회 - order_details 테이블에 값이 없어서 오류
	@RequestMapping(value="/orderList.do", method = RequestMethod.GET)
	public ModelAndView orderList(HttpServletRequest request) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		String member_id = (String) session.getAttribute("member");
		OrderVO orderVO = new OrderVO();
		orderVO.setMember_id(member_id);
		try {
			List<OrderVO> orderList = orderService.orderList(orderVO);
			mav.addObject("orderList", orderList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	// 주문 상세 목록(주문 정보, 주문 상세 정보)
	@RequestMapping(value="/orderView.do", method = RequestMethod.GET)
	public ModelAndView orderView(@RequestParam("n") String order_no, HttpServletRequest request) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		String member_id = (String) session.getAttribute("member");
		OrderVO orderVO = new OrderVO();
		orderVO.setOrder_no(order_no);
		orderVO.setMember_id(member_id);
		
		try {
			List<OrderListVO> orderView = orderService.orderView(orderVO);
			logger.info(orderView.toString());
			mav.addObject("orderView", orderView);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return mav;
	}
}
