package com.shoppingMall.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.shoppingMall.member.service.MemberService;
import com.shoppingMall.member.vo.MemberVO;
import com.shoppingMall.order.controller.OrderController;

import jdk.nashorn.internal.parser.JSONParser;

@Controller("memberController")
@RequestMapping("/member")
public class MemberController{

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	// 네이버 로그인
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	// 카카오 로그인
	private KakaoLoginBO kakaoLoginBO;

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder pwEncoder; // 비밀번호 암호화를 위한 객체

	@Autowired
	private JavaMailSender mailSender; // 이메일 전송

	@Autowired // 네이버 로그인
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	// form 페이지로 이동
	@RequestMapping(value = "/*Form.do", method = RequestMethod.GET)
	public String loginForm(Model model, HttpServletRequest request, HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");

		// 로그인 뷰페이지로 이동할 경우, 네이버/카카오 로그인 url을 model에 붙인다.
		if (viewName.equals("/member/loginForm")) {
			/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
			HttpSession session = request.getSession();
			String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
			// 카카오 로그인
			String kakaoAuthUrl = kakaoLoginBO.getAuthorizationUrl(session);

			// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
			// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
			System.out.println("네이버:" + naverAuthUrl);
			System.out.println("카카오:" + kakaoAuthUrl);

			// 네이버, 카카오
			model.addAttribute("naver_url", naverAuthUrl);
			model.addAttribute("kakao_url", kakaoAuthUrl);

		}

		return viewName;
	}

	// 로그인 처리
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("membervo") MemberVO membervo, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/member/loginForm.do");
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		try {
			// db에 저장되어있는 회원 정보와 파라미터 id 값을 비교 후 값을 가져옴
			MemberVO login = memberService.login(membervo);

			if ((login) != null) {
				// 파라미터 비밀번호 값과 db에 암호화 되어있는 비밀번호를 비교
				boolean pwMatch = pwEncoder.matches(membervo.getPw(), login.getPw());
				// 아이디, 비밀번호 일치
				if (login != null && pwMatch && membervo.getMember_id().equals(login.getMember_id())) {
					// 로그인 여부 확인을 위해 세션에 회원아이디를 붙여준다
					String loginID = login.getMember_id();
					session.setAttribute("member", loginID);
					session.setAttribute("isLogOn", true);
					session.setAttribute("memberInfo", membervo);
					mav.setViewName("redirect:/");

					// 아이디만 맞았을 경우
				} else if (!pwMatch && membervo.getMember_id().equals(login.getMember_id())) {
					// 세션에 null을 붙여준다
					session.setAttribute("member", null);
					out.println("<script>");
					out.println("alert('비밀번호가 다릅니다');");
					out.println("history.back()");
					out.println("</script>");
					out.close();
					mav.setViewName("redirect:/member/loginForm.do");
					mav.addObject("message", "비밀번호가 다릅니다");

					// 수정해야 함
				}
			} else {
				// 세션에 null을 붙여준다
				// session.setAttribute("member", null);
				out.println("<script>");
				out.println("alert('아이디를 확인해주세요');");
				out.println("history.back()");
				out.println("</script>");
				out.close();
				mav.setViewName("redirect:/member/loginForm.do");
				mav.addObject("message", "일치하는 아이디가 없습니다.");
			}
			// 관리자 로그인
			login = memberService.adminLogin(membervo);
			if (login == null) {
				mav.setViewName("redirect:/");
			} else {
				// 관리자를 나타내는 1이 있을 경우
				if (login.getAuthority().equals("1") && login.getAuthority() != null) {
					session.setAttribute("admin", login);
					mav.setViewName("redirect:/admin/main/main.do");

					// 비밀번호가 다를 경우
				} else if (login.getAuthority().equals("1") && login.getMember_id() != membervo.getMember_id()) {
					session.setAttribute("admin", null);
					out.println("<script>");
					out.println("alert('비밀번호를 확인해주세요');");
					out.println("history.back()");
					out.println("</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert('아이디 또는 비밀번호를 확인해주세요');");
					out.println("history.back()");
					out.println("</script>");
					out.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/naverLoginCallback", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView naverCallback(Model model, @RequestParam(value = "code", required = false) String code,
			@RequestParam(value = "state", required = false) String state, HttpSession session,
			HttpServletRequest request) throws IOException {
		System.out.println("여기는 callback");

		ModelAndView mav = new ModelAndView("redirect:/");
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		// 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String 형식의 json 데이터

		model.addAttribute("result", apiResult);
		System.out.println("result" + apiResult);

		// String형식인 apiResult를 json형태로 바꿈
		JsonParser parser = new JsonParser();
		Object obj = parser.parse(apiResult);
		JsonObject jsonObj = (JsonObject) obj;

		// 데이터 파싱
		JsonObject response_obj = (JsonObject) jsonObj.get("response");
		// response의 nickname 값 파싱
		// String nickname = (String) response_obj.get("nickname");
		String id = response_obj.get("id").getAsString();

		logger.info("데이터:" + response_obj.toString());

		// 파싱한 닉네임을 세션에 저장
		session.setAttribute("member", id);

		return mav;
	}

	// 카카오 로그인
	@RequestMapping(value = "/kakaoLoginCallback", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView kakaoCallback(@RequestParam(value = "code", required = false) String code, HttpSession session) throws IOException {
		ModelAndView mav = new ModelAndView("redirect:/");
		
		String accessToken = kakaoLoginBO.getAccessToken(code);
		HashMap<String, Object> kakaoUserInfo = kakaoLoginBO.getUserInfo(accessToken);
		//String nickname = (String) kakaoUserInfo.get("nickname");
		String kakaoID = (String) kakaoUserInfo.get("kakaoID");
		System.out.println("code:" + code);
		//System.out.println("nickname:" + nickname);

		session.setAttribute("member", kakaoID);
		session.setAttribute("accessToken", accessToken);

		return mav;
	}

	// 아이디 찾기 - 수정필요
	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	public ModelAndView findId(@ModelAttribute MemberVO membervo, HttpSession session, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		List<MemberVO> userList = memberService.findId(membervo);
		System.out.println(userList);
		String findId = membervo.getMember_id();
		System.out.println(findId);
		mav.setViewName("findIdForm");
		mav.addObject("findId", userList);
		return mav;
	}

	// 로그아웃 처리
	@RequestMapping(value = "/logout.do")
	public ModelAndView logout(HttpSession session) {
		if(session.getAttribute("accessToken") != null) {
			// 카카오 계정 로그아웃
			String accessToken = session.getAttribute("accessToken").toString(); 
			kakaoLoginBO.logout(accessToken);
		}
		// 세션 삭제
		session.invalidate();
		ModelAndView mav = new ModelAndView("redirect:/");
		
		
		return mav;
	}

	// 회원 가입 처리
	@RequestMapping(value = "/signUp.do", method = RequestMethod.POST)
	public ModelAndView signUp(@ModelAttribute("membervo") MemberVO membervo, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("redirect:/");
		// membervo 객체로 만들어진 파라미터에서 뽑은 비밀번호
		String inputPW = membervo.getPw();
		// 뽑은 비밀번호를 암호화
		String encodePW = pwEncoder.encode(inputPW);
		// 암호화시킨 비밀번호를 다시 membervo 객체에 넣는다
		membervo.setPw(encodePW);
		// 이메일 인증 여부
		membervo.setVerify(1);
		int result;
		try {
			result = memberService.signUp(membervo);
			if (result > 0) {
				return mav;
			} else {
				try {
					PrintWriter out = response.getWriter();
					out.write("<script>");
					out.write("alert('회원가입 실패')");
					out.write("</script>");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return mav;
	}

	// 아이디 중복확인
	@ResponseBody
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	public String idCheck(@RequestParam("member_id") String member_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		int result = memberService.idCheck(member_id);
		return String.valueOf(result);
	}

	// 회원가입 이메일 인증
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailAuthkey(String email) throws Exception {

		// 뷰페이지에서 넘어온 데이터
		logger.info("이메일: " + email);

		// 인증번호를 위한 난수 생성
		Random random = new Random();
		int authkey = random.nextInt(589641) + 111111;
		logger.info("생성된 인증번호: " + authkey);

		// 이메일 보내기
		String setFrom = "zappydep@gmail.com"; // xml에 작성한 본인 이메일 계정
		String toMail = email; 				   // 뷰에서 받은 이메일 주소
		String title = "회원가입 인증번호"; 		   // 이메일 제목
		String content = "THEBAG 회원가입을 위한 인증번호입니다." + "<br>" // 이메일 내용
				+ "<h2>인증번호: [ " + authkey + " ]</h2> <br>";

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom, "THEBAG(더백)");
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		// ajax를 통한 요청을 뷰페이지로 반환, 반환 데이터 타입은 String만 가능하므로 형변환 후 반환
		String num = Integer.toString(authkey);

		return num;
	}

	// 회원 정보 수정에 정보 보이게 하기
	@RequestMapping(value = "/updateMyInfoForm.do", method = RequestMethod.GET)
	public ModelAndView showInfo(@RequestParam("member_id") String member_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("/member/updateMyInfoForm");
		MemberVO membervo = memberService.showInfo(member_id);
		mav.addObject("membervo", membervo);
		return mav;
	}

	// 회원 정보 수정에서 현재 비밀번호 비교
	@ResponseBody
	@RequestMapping(value = "/pwCheck.do", method = RequestMethod.POST)
	public String pwCheck(@ModelAttribute("membervo") MemberVO membervo, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		int result = 0;

		// db에 저장되어있는 회원 정보와 파라미터 id 값을 비교 후 값을 가져옴
		MemberVO loginPw = memberService.pwCheck(membervo);

		// 파라미터 비밀번호 값과 db에 암호화 되어있는 비밀번호를 비교
		boolean pwMatch = pwEncoder.matches(membervo.getPw(), loginPw.getPw());
		// 비밀번호가 일치한다면
		if (loginPw != null && pwMatch) {
			result = 1;
		}

		return String.valueOf(result);
	}

	// 회원 정보 수정
	@RequestMapping(value = "/updateMyInfo.do", method = RequestMethod.POST)
	public ModelAndView updateMyInfo(@RequestParam Map<String, String> info, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = null;
		String member_id = info.get("member_id");
		String b_pw = info.get("b_pw");
		String newPw = info.get("newPw");
		String email = info.get("email");
		String phone = info.get("phone");
		// 뽑은 비밀번호를 암호화
		String encodePW = pwEncoder.encode(newPw);
		System.out.println(member_id + "/원래비번:" + b_pw + "/새비번:" + newPw + "/" + email + "/" + phone);
		MemberVO membervo = new MemberVO(member_id, encodePW, email, phone);
		// 비밀번호를 변경안 할 경우
		if (newPw == null || newPw == "") {
			membervo.setPw(b_pw);
		}
		System.out.println("membervo:" + membervo);
		int result = memberService.updateMyInfo(membervo);
		if (result > 0) {
			mav = new ModelAndView("/member/myPageForm");
		} else {
			mav = new ModelAndView("redirect:/member/updateMyInfoForm.do");
		}
		return mav;
	}

	// 회원 탈퇴
	@RequestMapping(value = "/signOut.do")
	public String signOut(HttpSession session, HttpServletResponse response) throws Exception {
		// 세션에 붙은 아이디
		String member_id = (String) session.getAttribute("member");
		// true = 탈퇴성공
		if (memberService.signOut(member_id, response)) {
			// 세션 삭제
			session.invalidate();
		}
		// 메인으로 돌아감
		return "/main/main";
	}

}
