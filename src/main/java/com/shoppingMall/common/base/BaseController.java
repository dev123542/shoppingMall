package com.shoppingMall.common.base;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.shoppingMall.product.vo.ImageFileVO;

//import com.shoppingMall.product.vo.ImageFileVO;

public abstract class BaseController  {
	private static final String CURR_IMAGE_REPO_PATH = "C:\\shoppingMall\\file_repo";

	protected List<ImageFileVO> upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		List<ImageFileVO> fileList= new ArrayList<ImageFileVO>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while(fileNames.hasNext()){
			ImageFileVO imageFileVO =new ImageFileVO();
			String fileName = fileNames.next();
			imageFileVO.setFile_type(fileName);
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName=mFile.getOriginalFilename();
			imageFileVO.setFile_name(originalFileName);
			
			// 랜덤으로 이미지 파일 이름 생성하는 방법 - 찾아보기
//	         UUID uuid = UUID.randomUUID(); 
//	         originalFileName = uuid +"_" +originalFileName;
			 
			imageFileVO.setFile_name(originalFileName);
			
			fileList.add(imageFileVO);
			
			File file = new File(CURR_IMAGE_REPO_PATH +"\\"+ fileName);
			if(mFile.getSize()!=0){ 							// 파일이 있다면, File Null Check
				if(! file.exists()){    						//경로상에 파일이 존재하지 않을 경우
					if(file.getParentFile().mkdirs()){ 			//경로에 해당하는 디렉토리들을 생성
							file.createNewFile();  				//이후 파일 생성
					}
				}
				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH +"\\"+"temp"+ "\\"+originalFileName));  //임시로 저장된 multipartFile을 실제 파일로 전송
			}
		}
		
		return fileList;
	}
	
//	private void deleteFile(String fileName) {
//		File file =new File(CURR_IMAGE_REPO_PATH+"\\"+fileName);
//		try{
//			file.delete();
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//	}

	
	@RequestMapping(value="/*.do" ,method={RequestMethod.POST,RequestMethod.GET})
	protected  ModelAndView viewForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
		
	}
	
}
