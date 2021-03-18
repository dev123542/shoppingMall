package com.shoppingMall.review.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.board.vo.PageMaker;
import com.shoppingMall.review.service.ReviewService;
import com.shoppingMall.review.vo.ReviewVO;

@Controller("reviewController")
@RequestMapping("/review")
public class ReviewController {

	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	private static final String CURR_IMAGE_REPO_PATH = "C:\\shoppingMall\\file_repo\\review";

	@Autowired
	private ReviewService reviewService;

	// 후기 작성
	@RequestMapping(value = "/writeReview", method = RequestMethod.POST)
	public ResponseEntity writeReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");

		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");

		// 다중 파라미터 뽑기
		Map<String, Object> reviewMap = new HashedMap();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			reviewMap.put(name, value);
			logger.info("name:" + name + "/ value:" + value);
		}

		// 작성자 아이디
		HttpSession session = request.getSession();
		String writer = (String) session.getAttribute("member");
		reviewMap.put("writer", writer);

		// 이미지를 뽑아서 상품 번호별로 후기 사진 넣기
		int product_no = Integer.parseInt(String.valueOf(reviewMap.get("product_no")));
		logger.info("상품번호:" + product_no);

		// 이미지 뽑기
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			logger.info("image name:" + originalFileName);

			// 파일이 없다면
			if (originalFileName == "") {
				originalFileName = null;
			}

			// 파일이 있다면
			if (originalFileName != null) {
				// 랜덤 문자 생성
				UUID uuid = UUID.randomUUID();
				originalFileName = uuid + "-" + originalFileName;
				reviewMap.put("review_file", originalFileName);
				logger.info("******** 파라미터값:" + reviewMap.toString());
				logger.info("input file name:" + fileName);
				logger.info("random image name:" + originalFileName);
				logger.info("작성값:" + reviewMap.toString());

			}

			reviewService.writerReview(reviewMap);

			if (originalFileName != null) {
				// 파일 저장 경로
				File file = new File(CURR_IMAGE_REPO_PATH + "\\" + product_no + "\\" + originalFileName); // 파일을 저장할 경로
																											// + 상품
																											// 번호 + 파일
																											// 이름

				// null check
				if (mFile.getSize() != 0) {
					// 경로상에 파일이 존재하지 않을 경우
					if (!file.exists()) {
						// 경로상에 해당하는 디렉토리를 생성
						if (file.getParentFile().mkdir()) {
							// 파일 생성
							file.createNewFile();
						}
					}
					// 임시로 저장된 multipartFile을 실제 파일로 전송
					mFile.transferTo(file);
				}
			}
		}
		message = "<script>";
		message += " alert('상품 등록 성공');";
		message += " history.go(-2); ";
		message += ("</script>");
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);

		return resEntity;
	}
	
	// 마이페이지 후기 목록
	@RequestMapping(value = "/myreviewList.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView myReview(CriteriaVO cri ,HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("/member/myreviewList");

		HttpSession session = request.getSession();
		String writer = (String) session.getAttribute("member");
		
		Map<String, Object> param = new HashMap<String, Object>();
		cri.setPerPageNum(5);
		int rowStart = cri.getRowStart();
		int rowEnd = cri.getRowEnd();
		param.put("writer", writer);
		param.put("rowStart", rowStart);
		param.put("rowEnd", rowEnd);
		logger.info("회원이 쓴 댓글목록 rowStart/end:" + rowStart+"/"+rowEnd);
		
		List<ReviewVO> reviewList = reviewService.myReviewList(param);
//		List<ReviewVO> reviewList = reviewService.myReviewList(writer);
		logger.info("회원이 쓴 댓글목록:" + reviewList.toString());
		
		int page = reviewService.myReviewCount(writer);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(page);

		mav.addObject("reviewList", reviewList);
		mav.addObject("pageMaker", pageMaker);
		
		return mav;
	}
//	@RequestMapping(value = "/myreviewList.do", method = { RequestMethod.POST, RequestMethod.GET })
//	public ModelAndView myReview(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("/member/myreviewList");
//		
//		HttpSession session = request.getSession();
//		String writer = (String) session.getAttribute("member");
//		
//		List<ReviewVO> reviewList = reviewService.myReviewList(writer);
//		logger.info("회원이 쓴 댓글목록:" + reviewList.toString());
//		
//		mav.addObject("reviewList", reviewList);
//		
//		return mav;
//	}
	
	// 후기 수정 창
	@ResponseBody
	@RequestMapping(value="/updateBtn", method=RequestMethod.POST)
	public ReviewVO updateBtn(@RequestParam("review_no") int review_no) throws Exception{
		ReviewVO view = reviewService.updateBtn(review_no);
		return view;
	}

	// 후기 수정
	@RequestMapping(value = "/updateReview", method = RequestMethod.POST)
	public ResponseEntity updateReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");

		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");

		// 다중 파라미터 뽑기
		Map<String, Object> reviewMap = new HashedMap();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			reviewMap.put(name, value);
			logger.info("name:" + name + "/ value:" + value);
		}

		// 작성자 아이디
		HttpSession session = request.getSession();
		String writer = (String) session.getAttribute("member");
		reviewMap.put("writer", writer);

		// 이미지를 뽑아서 상품 번호별로 후기 사진 넣기
		int product_no = Integer.parseInt(String.valueOf(reviewMap.get("product_no")));
		logger.info("상품번호:" + product_no);

		// 이미지 뽑기
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			logger.info("image name:" + originalFileName);

			if (originalFileName == "") {
				originalFileName = null;
			}

			if (originalFileName != null) {
				// 랜덤 문자 생성
				UUID uuid = UUID.randomUUID();
				originalFileName = uuid + "-" + originalFileName;
				reviewMap.put("review_file", originalFileName);

			}
			logger.info("******** 파라미터값:" + reviewMap.toString());
			logger.info("input file name:" + fileName);
			logger.info("random image name:" + originalFileName);

			reviewService.updateReview(reviewMap);

			if (originalFileName != null) {
				// 파일 저장 경로
				File file = new File(CURR_IMAGE_REPO_PATH + "\\" + product_no + "\\" + originalFileName); // 파일을 저장할 경로
				// + 상품 번호 +
				// 파일 이름

				// null check
				if (mFile.getSize() != 0) {
					// 경로상에 파일이 존재하지 않을 경우
					if (!file.exists()) {
						// 경로상에 해당하는 디렉토리를 생성
						if (file.getParentFile().mkdir()) {
							// 파일 생성
							file.createNewFile();
						}
					}
					// 임시로 저장된 multipartFile을 실제 파일로 전송
					mFile.transferTo(file);
				}
			}

		}
		message = "<script>";
		message += " alert('상품 수정 성공');";
		message += " location.href='"+multipartRequest.getContextPath()+"/review/myreviewList.do'; ";
//		message += " history.go(-1); ";
		message += ("</script>");
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);

		return resEntity;
	}
	
	// 후기 삭제
	@RequestMapping(value="/deleteReview", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView deleteReview(@ModelAttribute("review") ReviewVO review, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView("/member/myreviewList");
		
		HttpSession session = request.getSession();
		String writer = (String) session.getAttribute("member");
		review.setWriter(writer);
		
		reviewService.deleteReview(review);
		
		return mav;
	}
}
