package com.shoppingMall.review.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.shoppingMall.review.service.ReviewService;

@Controller("reviewController")
@RequestMapping("/review")
public class ReviewController {

	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	private static final String CURR_IMAGE_REPO_PATH = "C:\\shoppingMall\\file_repo\\review";
	
	@Autowired
	private ReviewService reviewService;

	// 후기 작성
	@RequestMapping(value = "/writeReview", method = RequestMethod.POST)
	public ResponseEntity writeReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
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
		logger.info("상품번호:"+product_no);
		
		// 이미지 뽑기
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while(fileNames.hasNext()){
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			logger.info("image name:"+ originalFileName);
			
			// 랜덤 문자 생성
			UUID uuid = UUID.randomUUID();
			originalFileName = uuid + "-" + originalFileName;
			reviewMap.put("review_file", originalFileName);
			logger.info("******** 파라미터값:"+reviewMap.toString());
			logger.info("input file name:"+ fileName);
			logger.info("random image name:"+ originalFileName);
			
			reviewService.writerReview(reviewMap);
			
			// 파일 저장 경로
			File file = new File(CURR_IMAGE_REPO_PATH +"\\"+ product_no + "\\" + originalFileName); // 파일을 저장할 경로 + 상품 번호 + 파일 이름

			// null check
			if(mFile.getSize()!=0) {
				// 경로상에 파일이 존재하지 않을 경우
				if(!file.exists()) {
					// 경로상에 해당하는 디렉토리를 생성
					if(file.getParentFile().mkdir()) {
						// 파일 생성
						file.createNewFile();
					}
				}
				// 임시로 저장된 multipartFile을 실제 파일로 전송
				mFile.transferTo(file);
			}
		}

		message= "<script>";
		message += " alert('상품 등록 성공');";
		message +=" history.go(-2); ";
		message +=("</script>");
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		
		return resEntity;
	}
}
