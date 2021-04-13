<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path }/resources/css/style.css" />
<link rel="stylesheet" type="text/css" href="${path }/resources/css/login.css" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
 function CheckKey_log(e) {
    e = e || window.event;
    key = e.keyCode;
    if (key == 13) {
        check_log()
    }
}
function pHolder( obj ){ 

	if( obj.alt != "1"){
		obj.value = ""; obj.alt="1"; obj.className="placeHolderOver";
	}
} 
 
function CheckKey(e) {
    e = e || window.event;
    key = e.keyCode;
    if (key == 13) {
        check()
    }
}

function check() {
    if (document.form1.member_id.value.length == 0) {
        document.form1.member_id.focus();
        alert('회원 ID를 입력하세요.');
        return;
    }
    if (document.form1.pw.value.length == 0) {
        document.form1.pw.focus();
        alert('회원 비밀번호를 입력하세요.');
        return;
    }
    submitsend();
}
function submitsend() {
    document.form1.submit();
}

function sns_login_log(event){
	if(event == "naver"){
		location.href = "${path}/member/naverLogin.do";
	}
}
</script>
</head>
<body>
<!-- html 수정 -->
<div class="login_container inbox">
	<section class="login_wrap">
	    <!-- 로그인입력폼 -->
	    <div class="login_wrap_01">
	        <h3 class="login_title">기존 회원 로그인</h3>
	        <div class="login_txt">
	            <span>안녕하세요 회원님.</span>
	        </div>
	        <!-- 로그인 폼 -->
	        <div class="login_form">
	            <form action="${path }/member/login.do" method="post" name="form1" >
	                <ul>
	                    <li class="login_idpw">
	                        <dl class="login_id">
	                            <dt>Id<span class="em">*</span></dt>
	                            <dd><input type="text" name="member_id" maxlength="20" onblur="document.form1.pw.focus();" class="login_id placeHolder" value="id를 입력해주세요." onclick="pHolder(this)" alt="0"></dd>
	                        </dl>
	                        <dl class="login_pw">
	                            <dt>Password<span class="em">*</span></dt>
	                            <dd><input type="password" name="pw" id="pw" onkeydown="CheckKey(event);" class="MS_login_pw" /></dd>
	                        </dl>
	                    </li>
	                    <li class="se-log"><label><input type="checkbox" name="ssl" value="Y"  class="MS_security_checkbox" /> 보안접속</label></li>
	                    <li class="login_submit">
	                        <a href="javascript:check();">
	                            <button type="button">로그인</button>	
	                        </a>
	                    </li>
	                </ul>
	            </form>
	            <!-- sns로그인 - 미설정임. 업데이트 필요 -->
 	            <%-- <div class="sns_logo">
	                <a href="javascript:sns_login_log('facebook');"><img src="${path }/resources/image/sns_facebook.png" alt="" />페이스북으로 로그인</a>	
	                <a href="javascript:sns_login_log('naver');"><img src="${path }/resources/image/sns_naver.png" alt="" />네이버로 로그인</a>
	                <a href="javascript:sns_login_log('kakao');"><img src="${path }/resources/image/sns_kakaotalk.png" alt="" />카카오로 로그인</a>	
	            </div> --%>
	            <div class="sns_login">
	            <!-- 네이버 로그인 -->
		            <div id="naver_id_login" style="text-align:center">
		            	<a href="${naver_url}">
							<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/>
						</a>
					</div>
					<!-- 카카오 로그인 -->
					<div id="kakao_id_login" style="text-align: center; margin-top:5px;"> 
 						<a href="${kakao_url}"><img width="223" src="${path }/resources/image/kakao_login_medium_narrow.png" /></a>  
					</div>
				</div>
	            
	            <!-- 아이디/비밀번호 찾기 -->
	            <div class="btns">
	                <dl>
	                    <dt>아이디/비밀번호를 잊으셨나요?</dt>
	                    <dd>
	                        <a href="${path }/member/findIdForm.do">
		                        <button>Find ID</button>
		                        <button>Find PW</button>
	                        </a>
	                    </dd>
	                </dl>
	            </div>
	        </div>
	    </div>   <!-- .login_wrap_01 -->
	    <div class="login_wrap_02">
	        <h3 class="signup_title">회원 가입 하기</h3>
	        <div class="signup_txt">
	            <span class="br">더백은 '성함, 아이디, 이메일' 만으로 "간편회원가입" 됩니다.</span>
	            <span>신규회원 첫구매 무료배송쿠폰, 적립금3,000원 즉시할인, 앱으로 구매시 1,000원추가할인까지 좋은상품 합리적인 가격으로 이용하세요.</span>
	        </div>
	        <div class="signup_input">
	        	<a href="${path }/member/signUpForm.do">
	            <input type="submit" title="회원가입" alt="회원가입" value="회원가입" class="btn_submit" id="signup">
	        </div>
	    </div>   <!-- .login_wrap_02 -->
	</section> <!-- .login_container -->
	<section class="login_banner">
	    <div class="login_banner_box">
	        <ul>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_01.png" title="신규회원" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_02.png" title="추천인" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_03.png" title="회원구매" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_04.png" title="1회이상구매" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_05.png" title="구매후" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_06.png" title="회원이벤트1" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_07.png" title="회원이벤트2" /></a></li>
	            <li><a href="${path }/"><img src="${path }/resources/image/join_members_08.png" title="회원이벤트3" /></a></li>
	        </ul>
	    </div>
	</section>   <!-- .login_banner -->
</div>
</body>
</html>