package com.shoppingMall.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.admin.product.service.AdminProductService;
import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.product.service.ProductService;
import com.shoppingMall.product.vo.ProductVO;


@Controller("mainController")
@EnableAspectJAutoProxy //loggingAdvice
public class MainController {
	
	@Autowired
	private ProductService productService;
	
	//@RequestMapping(value= {"/main/main.do"} ,method={RequestMethod.POST,RequestMethod.GET})
	@RequestMapping(value= {"/", ""} ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		mav.setViewName("/main/main");
		CriteriaVO cri = new CriteriaVO();
		Map<String, Object> param = new HashMap<String, Object>();
		cri.setPerPageNum(12);
		int rowStart = cri.getRowStart();
		int rowEnd = cri.getRowEnd();
		String sort = "new";
		String s = "new";
		//String cate_name = null;
		param.put("rowStart", rowStart);
		param.put("rowEnd", rowEnd);
		//param.put("sort", sort);
		param.put("s", s);
		//param.put("cate_name", cate_name);
		List<ProductVO> productList = productService.newProductList(param);
		mav.addObject("productList", productList);
		return mav;
		
	}
}
