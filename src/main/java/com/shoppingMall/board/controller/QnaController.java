package com.shoppingMall.board.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shoppingMall.board.service.QnaService;
import com.shoppingMall.board.service.ReplyService;
import com.shoppingMall.board.vo.CriteriaVO;
import com.shoppingMall.board.vo.PageMaker;
import com.shoppingMall.board.vo.QnaVO;
import com.shoppingMall.board.vo.ReplyVO;
import com.shoppingMall.board.vo.SearchCriteria;

@Controller
@RequestMapping("/qna/*")
public class QnaController {

	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	@Autowired
	QnaService qnaservice;
	
	@Autowired
	ReplyService replyservice;
	
	// 게시판 글 작성 화면
	@RequestMapping(value = "/writeView", method = RequestMethod.GET)
	public String writeView() throws Exception{
		return "/qna/writeView";
	}

	// 게시판 글 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String write(QnaVO qnaVO, MultipartHttpServletRequest mpRequest) throws Exception{
		qnaservice.write(qnaVO, mpRequest);
		logger.info("로거:"+qnaVO.getTitle());
		logger.info("로거:"+qnaVO.getContent());
		return "redirect:/qna/list";
	}
	
	// 게시판 목록 조회
	@RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		model.addAttribute("list", qnaservice.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(qnaservice.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		return "/qna/list";
	}
	
	// 게시판 조회
	@RequestMapping(value = "/readView", method = {RequestMethod.GET, RequestMethod.POST})
	public String read(QnaVO qnaVO, @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		model.addAttribute("read", qnaservice.read(qnaVO.getBno()));
		model.addAttribute("scri", scri);

		List<ReplyVO> replyList = replyservice.readReply(qnaVO.getBno());
		model.addAttribute("replyList", replyList);

		List<Map<String, Object>> fileList = qnaservice.selectFileList(qnaVO.getBno());
		model.addAttribute("file", fileList);
		return "/qna/readView";
	}

	// 게시판 수정뷰
	@RequestMapping(value = "/updateView", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateView(QnaVO qnaVO, @ModelAttribute("scri") SearchCriteria scri, Model model)
			throws Exception {
		model.addAttribute("update", qnaservice.read(qnaVO.getBno()));
		model.addAttribute("scri", scri);

		List<Map<String, Object>> fileList = qnaservice.selectFileList(qnaVO.getBno());
		model.addAttribute("file", fileList);
		return "/qna/updateView";
	}
	
	// 게시판 수정
	@RequestMapping(value = "/update", method = {RequestMethod.GET, RequestMethod.POST})
	public String update(QnaVO qnaVO, 
			 @ModelAttribute("scri") SearchCriteria scri, 
			 RedirectAttributes rttr,
			 @RequestParam(value="fileNoDel[]") String[] files,
			 @RequestParam(value="fileNameDel[]") String[] fileNames,
			 MultipartHttpServletRequest mpRequest) throws Exception {
		qnaservice.update(qnaVO, files, fileNames, mpRequest);
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/qna/list";
		}

	// 게시판 삭제
	@RequestMapping(value = "/delete", method = {RequestMethod.GET, RequestMethod.POST})
	public String delete(QnaVO qnaVO, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception{
		qnaservice.delete(qnaVO.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		return "redirect:/qna/list";
	}
	
	//댓글 작성
	@RequestMapping(value="/replyWrite", method = RequestMethod.POST)
	public String replyWrite(ReplyVO replyvo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		replyservice.writeReply(replyvo);
		
		rttr.addAttribute("bno", replyvo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/qna/readView";
	}
	
	//댓글 수정 GET
	@RequestMapping(value="/replyUpdateView", method = RequestMethod.GET)
	public String replyUpdateView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		model.addAttribute("replyUpdate", replyservice.selectReply(vo.getRno()));
		model.addAttribute("scri", scri);
		
		return "/qna/replyUpdateView";
	}
	
	//댓글 수정 POST
	@RequestMapping(value="/replyUpdate", method = RequestMethod.POST)
	public String replyUpdate(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		replyservice.updateReply(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/qna/readView";
	}
	
	//댓글 삭제 GET
	@RequestMapping(value="/replyDeleteView", method = RequestMethod.GET)
	public String replyDeleteView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		model.addAttribute("replyDelete", replyservice.selectReply(vo.getRno()));
		model.addAttribute("scri", scri);

		return "/qna/replyDeleteView";
	}
	
	//댓글 삭제 POST
	@RequestMapping(value="/replyDelete", method = RequestMethod.POST)
	public String replyDelete(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		replyservice.deleteReply(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/qna/readView";
	}
	
	//첨부파일 다운로드
	@RequestMapping(value="/fileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = qnaservice.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
		
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("D:\\mp\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
	}
	
}