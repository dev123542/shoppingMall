<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path }/resources/css/style.css" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	//현재 비밀번호 비교하기
	function bfPwCheck(){
	  /* var idReg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,12}$/;   /* 영문,숫자 4~12자리만 가능 */ 
	  var member_id = $("#member_id").val();
	  var pw = $("#pw").val();
	  $.ajax({
	    url: "${pageContext.request.contextPath}/member/pwCheck.do",		
	    		type:"post", 
				data: {"member_id" : member_id, "pw" : pw},
				success:function(data){
					if($.trim(data) == 1){
						$("#pwReg").html("");
					}else if($.trim(data) == 0){
						$("#pwReg").html("비밀번호가 일치하지 않습니다");
						$("#pwReg").css("color", "red");
					}
				},
				error: function(){
					console.log("현재 비밀번호 확인 ajax 에러");
				}
	  });
	}
	
	//새 비밀번호 유효성 검사
	function newPwRegCheck(){
	  var pwc = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{4,12}$/;
	  var newPw = document.getElementById("newPw");
	  var newPwReg = document.getElementById("newPwReg");

	  if(!pwc.test(newPw.value)){
		  newPwReg.innerHTML = "영문자,숫자,특수문자 조합으로 4~12자리를 입력해주세요";
		  newPwReg.style.color = "red";
	  }else if(pwc.test(newPw.value)){
		  newPwReg.innerHTML = "";
	  }
	}
	// 비밀번호 일치
	function newPwRCh(){
	  var newPw = document.getElementById("newPw");
	  var newPwCheck = document.getElementById("newPwCheck");
	  var newPwResult = document.getElementById("newPwResult");
	  if(newPw.value != newPwCheck.value){
		  newPwResult.innerHTML = "비밀번호가 일치하지 않습니다";
		  newPwResult.style.color = "red";
		}else if(newPw.value == newPwCheck.value){
			newPwResult.innerHTML = "";
	  }
	}

	//이메일 유효성 검사
	function checkEmail(){
	    //이메일 정규식
	    var emailReg =  /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
	    var email = document.getElementById("email");
	    var emailResult = document.getElementById("emailResult");
	    if(!emailReg.test(email.value)){
	      emailResult.innerHTML = "올바른 이메일 형식이 아닙니다";
	      emailResult.style.color = "red";
	    }else{
	      emailResult.innerHTML = "";
	    }
	}

	//전화번호 유효성 검사
	function phoneCheck(){
	  //숫자만 입력하는 정규식
	  var reg = /^[0-9]+/g;
	  var phone = document.getElementById("phone");
	  var phoneResult = document.getElementById("phoneResult");
	  if(!reg.test(phone.value)){
	    phoneResult.innerHTML = "숫자만 입력하세요";
	    phoneResult.style.color = "red";
	  }else{
	    phoneResult.innerHTML = "";
	  }
	}
	
	
	// 회원 탈퇴
	function signOut(){
		location.href = "${path}/member/signOut.do";
	}
</script>
</head>
<body>
<br><br>
	<section>
	    <div class="signUp-wrap">
	      <div class="signUp-inner">
	        <form action="${path }/member/updateMyInfo.do" method="POST" onsubmit="return signUpCheck()">
	          <table>
	            <colgroup>
	              <col width="21%" />
	            </colgroup>
	            <thead>
	              <tr>
	                <th colspan="7"><h2>회원 정보 수정</h2></th>
	              </tr>
	            </thead>
	            <tbody>
	              <tr>
	                <td><label for="member_name">이름</label></td>
	                <td colspan="6">
	                	<input type="text" name="member_name" id="member_name" value="${membervo.member_name }" readonly="readonly"/>
	                </td>
	              </tr>
	              <tr>
	                <td><label for="member_id">아이디</label></td>
	                <td colspan="6">
	                	<input type="text" name="member_id" id="member_id" value="${membervo.member_id }" readonly="readonly" />
	                	<span id="idResult"></span>
	                </td>
	              </tr>
	              <tr>
	                <td><label for="pw">현재 비밀번호</label></td>
	                <td colspan="6">
	                	<input type="password" name="pw" id="pw" onkeyup="bfPwCheck()" maxlength="12" placeholder="현재 비밀번호를 입력하세요" />
	                	<input type="hidden" name="b_pw" id="b_pw" maxlength="12" value="${membervo.pw }" />
	                	<span id="pwReg"></span>
	                </td>
	              </tr>
	              <tr>
	                <td><label for="newPw">새 비밀번호</label></td>
	                <td colspan="6">
	                	<input type="password" name="newPw" id="newPw" onkeyup="newPwRegCheck()" maxlength="12" placeholder="영문,숫자,특수문자포함 4~12자리" />
	                	<span id="newPwReg"></span>
	                </td>
	              </tr>
	              <tr>
	                <td><label for="newPwCheck">비밀번호 확인</label></td>
	                <td colspan="6">
	                	<input type="password" name="newPwCheck" id="newPwCheck" onkeyup="newPwRCh()" maxlength="12" placeholder="새 비밀번호 확인" />
	                	<span id="newPwResult"></span>
	                </td>
	              </tr>
	              <tr>
	                <td><label for="email">이메일</label></td>
	                <td colspan="6">
	                	<input type="text" name="email" id="email" oninput="checkEmail()" value="${membervo.email }" />
	                	<span id="emailResult"></span>
	                </td>
	              </tr>
	              <tr>
	                <td><label for="phone">전화번호</label></td>
	                <td colspan="6">
	                	<input type="text" name="phone" id="phone" oninput="phoneCheck()" maxlength="11" value="${membervo.phone }" />
	                	<span id="phoneResult"></span>
	                </td>
	              </tr>
	              <tr>
	                <td><label for="member_credate">가입일</label></td>
	                <td colspan="6">
	                	<input type="text" name="member_credate" id="member_credate"value="${membervo.member_credate }" readonly="readonly" />
	                </td>
	              </tr>
	            </tbody>
	          </table>
	          <div class="signUp-button-wrap">
	            <button type="submit" class="signUp-button">수정</button>
	            <button type="button" class="signUp-button" style="background:#bbb;" onclick="signOut()">회원탈퇴</button>
	          </div>
	        </form>
	      </div>
	    </div>
	</section>
</body>
</html>