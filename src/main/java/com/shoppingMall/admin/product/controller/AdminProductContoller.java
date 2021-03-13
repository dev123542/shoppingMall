package com.shoppingMall.admin.product.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.shoppingMall.admin.product.service.AdminProductService;
import com.shoppingMall.board.vo.PageMaker;
import com.shoppingMall.board.vo.SearchCriteria;
import com.shoppingMall.common.base.BaseController;
import com.shoppingMall.member.vo.MemberVO;
import com.shoppingMall.product.vo.ImageFileVO;

@Controller("adminProductController")
@RequestMapping("/admin/product")
public class AdminProductContoller extends BaseController{
	
	private static final Logger logger = LoggerFactory.getLogger(AdminProductContoller.class);

	private static final String CURR_IMAGE_REPO_PATH = "C:\\shoppingMall\\file_repo";
	
	@Autowired
	private AdminProductService adminProductService;

	// 메뉴에 맞는 페이지 이동
	@RequestMapping("/*Form.do")
	private ModelAndView productForm(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		mav.setViewName(viewName);
		return mav;
	}

	// 상품 등록
	@RequestMapping(value = "/addNewProduct.do", method = { RequestMethod.GET, RequestMethod.POST })
	private ResponseEntity addNewProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)  throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		String imageFileName = null;
		
		// 다중 파라미터 뽑기
		Map<String, Object> newProductMap = new HashedMap();
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			newProductMap.put(name, value);
			System.out.println("name"+name+"value"+value);
		}
		// 파일 테이블에 넣기 위해 아이디 뽑기
		HttpSession session = multipartRequest.getSession();
		MemberVO membervo = (MemberVO) session.getAttribute("admin");
		String reg_id = membervo.getMember_id();
		
		// 이미지 파일 이름
		List<ImageFileVO> imageFileList = upload(multipartRequest);
		if(imageFileList != null && imageFileList.size() != 0) {
			for(ImageFileVO imageFileVO : imageFileList) {
				imageFileVO.setReg_id(reg_id);
			}
			newProductMap.put("imageFileList", imageFileList);
		}
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			// 상품 등록
			int product_no = adminProductService.addNewProduct(newProductMap);
			if(imageFileList != null && imageFileList.size() != 0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFile_name();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+product_no);	// 상품 번호 별로 폴더를 생성해서 상품 번호에 해당하는 이미지를 저장
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
			message= "<script>";
			message += " alert('상품 등록 성공');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/admin/product/addNewProductForm.do';";
			message +=("</script>");
			
		}catch(Exception e){
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO  imageFileVO:imageFileList) {
					imageFileName = imageFileVO.getFile_name();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
				}
			}
			
			message = "<script>";
			message += " alert('상품 등록 실패');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/admin/product/addNewProductForm.do';";
			message +=("</script>");
			e.printStackTrace();
		}
		
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	// ck 에디터에서 파일 업로드
	@RequestMapping(value="/ckUpload", method = RequestMethod.POST)
	public void ckEditorUpload(@RequestParam(value="upload") MultipartFile upload,HttpServletRequest request, HttpServletResponse response) {
		// ck 에디터에서 파일을 넘겨주는 이름이 upload로 설정되어있으므로 똑같이 설정
		
		logger.info("ckeditor image upload");
		response.setContentType("text/html; charset=UTF-8");
		
		// 무작위 문자 생성
		UUID uid = UUID.randomUUID();
		
		OutputStream ops = null;
		PrintWriter out = null;
		
		try {
			// 파일 원래 이름
			String fileName = upload.getOriginalFilename();
			// 파일을 바이트 배열에 저장
			byte[] bytes = upload.getBytes();
			
			// 업로드 경로 = 물리적 실제 저장 경로 (File.separator는 구분자임)
			String ckUploadPath = CURR_IMAGE_REPO_PATH + File.separator + "upload" + File.separator + uid + "_" + fileName;
//			String ckUploadPath = ckUpload + File.separator + "upload" + File.separator + uid + "_" + fileName;
			
			ops = new FileOutputStream(new File(ckUploadPath));
			ops.write(bytes);
			// 데이터 전송 후 초기화
			ops.flush();
			
			//String callback = request.getParameter("CKEditorFuncNum");
			out = response.getWriter();
			
			// 에디터 화면, url 상에서 볼 수 있는 이미지 경로
			String fileUrl = "/upload/" + uid + "_" + fileName;
			
			System.out.println("물리 경로:"+fileUrl);
			System.out.println("절대 경로:"+ckUploadPath);
//			out.println("<script type='text/javascript'>"
//						+ "window.parent.CKEDITOR.tools.callFunction("
//						+ callback +", '" + fileUrl + "', '이미지 업로드 완료')"
//						+ "</script>"
//					   );
			out.println("{\"filename\" : \""+ fileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
			out.flush();
			
		} catch (IOException e) {
			e.printStackTrace();
			
		// 항상 실행됨
		} finally {
			try {
				if(ops != null) {
					ops.close();
				}
				if(out != null) {
					out.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	// 상품 목록
//	@RequestMapping(value="/productList.do" ,method={RequestMethod.POST,RequestMethod.GET})
//	private ModelAndView productList(HttpServletRequest request, HttpServletResponse response) {
//		String viewName = (String) request.getAttribute("viewName");
//		ModelAndView mav = new ModelAndView();
//		HttpSession session=request.getSession();
//		session=request.getSession();
//		session.setAttribute("side_menu", "admin_mode");
//		
//		CriteriaVO cri = new CriteriaVO();
//		PageMaker pageMaker = new PageMaker();
//		
//		Map<String, Object> productMap = null;
//		
//		try {
////			productMap = adminProductService.selectProductList();
//			productMap = adminProductService.selectProductList(cri);
//			pageMaker.setCri(cri);
//			pageMaker.setTotalCount(adminProductService.selectAdminProductListCount());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		System.out.println("cri:"+cri);
//		System.out.println("pageMaker start:"+pageMaker.getStartPage());
//		System.out.println("pageMaker end:"+pageMaker.getEndPage());
//		System.out.println("pageMaker isNext:"+pageMaker.isNext());
//		mav.addObject("productMap",productMap);
//		mav.addObject("pageMaker", pageMaker);
//		mav.setViewName(viewName);
//		return mav;
//	}
	@RequestMapping(value="/productList.do" ,method={RequestMethod.POST,RequestMethod.GET})
	private ModelAndView productList(@RequestParam(value="product_name", required=false) String product_name,
									 @RequestParam(value="product_sort", required=false) String product_sort,
									 @RequestParam(value="cate_parent", required=false) String cate_parent,
									 @RequestParam(value="origin_price", required=false) String origin_price,
									 SearchCriteria scri, HttpServletRequest request, HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session=request.getSession();
		session.setAttribute("side_menu", "admin_mode");
		
		// db에 보낼 파라미터
		Map<String, Object> param = new HashMap<String, Object>();
		int rowStart = scri.getRowStart();
		int rowEnd = scri.getRowEnd();
		
		param.put("rowStart", rowStart);
		param.put("rowEnd", rowEnd);
		param.put("product_name", product_name);
		param.put("product_sort", product_sort);
		param.put("cate_parent", cate_parent);
		param.put("origin_price", origin_price);
		
		
		// view페이지에 보낼 맵
		Map<String, Object> productMap = new HashMap<String, Object>();
		PageMaker pageMaker = new PageMaker();
		//productMap.put("param", productMap);
		try {
//			productMap = adminProductService.selectProductList();
			//productMap = adminProductService.selectProductList(cri);
			productMap = adminProductService.selectAdminProductList(param);
			pageMaker.setCri(scri);
//			pageMaker.setTotalCount(adminProductService.selectAdminProductListCount());
			int adminSearchCount = adminProductService.adminProductSearchCount(productMap);
			pageMaker.setTotalCount(adminSearchCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mav.addObject("productMap",productMap);
		mav.addObject("pageMaker", pageMaker);
		mav.setViewName(viewName);
		return mav;
	}
	
	// 상품 목록에서 상품 정보 추가 팝업창 띄움
	@RequestMapping(value="/addNewModelForm.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView addNewModel(@RequestParam("product_no") String product_no,
									@RequestParam("cate_code") String cate_code,
									HttpServletRequest request, HttpServletResponse response) {
		
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("product_no", product_no);
		mav.addObject("cate_code", cate_code);
		return mav;
	}

	// 상품 정보 추가
	@RequestMapping(value="/addNewModel.do", method= RequestMethod.POST)
	public ResponseEntity addNewModel(HttpServletRequest request, HttpServletResponse response) {
		
		Map<String, Object> productDetailMap = new HashedMap();
		Enumeration enu = request.getParameterNames();
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value = request.getParameter(name);
			productDetailMap.put(name, value);
		}
		
		try {
			adminProductService.insertNewProductDetail(productDetailMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		String message=null;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders=new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		message="<script> ";
		message+=" alert('상품 등록 완료');";
		message+=" self.close();";
		message+=" location.href='/admin/product/productList.do'"; 
		message+=" </script>";
		
		resEnt = new ResponseEntity(message,responseHeaders,HttpStatus.OK);
		
		return resEnt;
	}
	
	// 관리자 메인에서 차트
//	@RequestMapping(value="/chart.do", method=RequestMethod.POST)
//	@ResponseBody
//	public JSONObject chart() throws Exception {
//		return adminProductService.chart();
//	}
}
