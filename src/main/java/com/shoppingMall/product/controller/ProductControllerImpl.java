package com.shoppingMall.product.controller;

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

import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.board.vo.PageMaker;
import com.shoppingMall.common.base.BaseController;
import com.shoppingMall.product.service.ProductService;
import com.shoppingMall.product.vo.ProductVO;
import com.shoppingMall.review.service.ReviewService;
import com.shoppingMall.review.vo.ReviewVO;

import net.sf.json.JSONObject;

@Controller("productController")
@RequestMapping(value = "/product")
public class ProductControllerImpl extends BaseController implements ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductControllerImpl.class);

	@Autowired
	private ProductService productService;

	@Autowired
	private ReviewService reviewService;
	
	// 상품번호조회 productDetail
	@RequestMapping(value = "/productDetail.do", method = RequestMethod.GET)
	public ModelAndView productDetail(@RequestParam("product_no") String product_no, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		HttpSession session = request.getSession();
		// 상품번호 Map으로 반환
		Map productMap = productService.productDetail(product_no);
		ModelAndView mav = new ModelAndView(viewName);
		logger.info("상세 상품번호:"+product_no);
		//logger.info("상세 imageList:"+productMap.get("imageList"));
		logger.info("상세 productVO:"+productMap.get("productVO"));
		logger.info("상세 이미지:"+productMap.get("productVO"));
		
		// 상품 후기 목록 불러오기
		int review_product_no = Integer.parseInt(String.valueOf(product_no));
		List<ReviewVO> reviewList = reviewService.selectReview(review_product_no);
		logger.info("후기 상품 번호:"+review_product_no);
		logger.info("후기 목록:"+reviewList.toString());
		//productMap.put("reviewList", reviewList);
		
		mav.addObject("productMap", productMap);
		
//		ProductVO productVO=(ProductVO)productMap.get("productVO");
//		addproductInQuick(product_no,productVO,session);
		return mav;
	}

	@RequestMapping(value = "/keywordSearch.do", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public @ResponseBody String keywordSearch(@RequestParam("keyword") String keyword, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		// System.out.println(keyword);
		if (keyword == null || keyword.equals(""))
			return null;

		keyword = keyword.toUpperCase();
		List<String> keywordList = productService.keywordSearch(keyword);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList);

		String jsonInfo = jsonObject.toString();
		// System.out.println(jsonInfo);
		return jsonInfo;
	}

	/*
	 * @RequestMapping(value="/searchproduct.do" ,method = RequestMethod.GET) public
	 * ModelAndView searchproduct(@RequestParam("searchWord") String searchWord,
	 * HttpServletRequest request, HttpServletResponse response) throws Exception{
	 * String viewName=(String)request.getAttribute("viewName"); List<ProductVO>
	 * productList=productService.searchProduct(searchWord); ModelAndView mav = new
	 * ModelAndView(viewName); mav.addObject("productList", productList); return
	 * mav;
	 * 
	 * }
	 */
	private void addproductInQuick(String product_no, ProductVO productVO, HttpSession session) {
		boolean already_existed = false;
		List<ProductVO> quickProductList;
		quickProductList = (ArrayList<ProductVO>) session.getAttribute("quickProductList");

		if (quickProductList != null) {
			if (quickProductList.size() < 4) {
				for (int i = 0; i < quickProductList.size(); i++) {
					ProductVO _productBean = (ProductVO) quickProductList.get(i);
					if (product_no.equals(_productBean.getProduct_no())) {
						already_existed = true;
						break;
					}
				}
				if (already_existed == false) {
					quickProductList.add(productVO);
				}
			}

		} else {
			quickProductList = new ArrayList<ProductVO>();
			quickProductList.add(productVO);

		}
		session.setAttribute("quickProductList", quickProductList);
		session.setAttribute("quickProductListNum", quickProductList.size());
	}

	// 상품 대분류 카테고리별로 상품 보여주기
	@RequestMapping(value = "/newProductList.do", method = { RequestMethod.GET })
	public ModelAndView newProductList(@RequestParam(required = false) String sort,
									   @RequestParam(required = false) String s, 
									   @RequestParam(required = false) String cate_name, CriteriaVO cri) throws Exception {
		// 파라미터: cri(페이징), sort= new, best, it 및 대분류 번호, s = best, new, asc, desc 정렬,
		// sort : itbag, best , 대분류 번호 / s : best, new, asc, desc 인기순,신상품순, 가격오름,내림 상품정렬 / cate_name : 소분류 이름 
		// new : s=new product_credate desc, best:매출액순으로 desc 하면 됨(현재는 데이터가 없음)
		// 반환값: productvo
		// logger.info("파라미터 대분류sort:"+sort+"/정렬s:"+s+"/소분류cate_name:"+cate_name);

		ModelAndView mav = new ModelAndView("/product/newProductList");
		// 다중 파라미터를 담을 맵
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("sort", sort); // 대분류
		param.put("s", s); // 정렬
		param.put("cate_name", cate_name); // 소분류

		// 페이징을 위한 값
		cri.setPerPageNum(12);
		int rowStart = cri.getRowStart();
		int rowEnd = cri.getRowEnd();
		param.put("rowStart", rowStart);
		param.put("rowEnd", rowEnd);

		// 상품 목록
		List<ProductVO> productList = productService.newProductList(param);
		//logger.info("controller productList >>>> " + productList);
		// 페이징
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		// product_sort 전부 or '베스트'인 상품 총 개수
		int total = productService.newProductCount(param);
		// pageMaker.setTotalCount(total);

		// 상품이 없어도 페이지 번호 1이 보이게 함
		if (total == 0) {
			pageMaker.setTotalCount(1);
		} else {
			pageMaker.setTotalCount(total);
		}

		mav.addObject("productList", productList);
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("total", total);
		mav.addObject("sort", sort);
		mav.addObject("s", s);
		return mav;
	}

}
