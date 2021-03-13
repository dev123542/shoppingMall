/* 회원가입 유효성 검사 */
function signUpCheck(){
  var id = document.getElementById("member_id");
  var pw = document.getElementById("pw");
  var pwCheck = document.getElementById("pwCheck");
  var email = document.getElementById("email");
  var phone = document.getElementById("phone");
  var name = document.getElementById("member_name");

  if(name.value == ""){
    alert("이름을 입력하세요");
    name.focus();
    return false;
  }
  if(id.value == ""){
    alert("아이디를 입력하세요");
    id.focus();
    return false;
  }
  if(pw.value == ""){
    alert("비밀번호를 입력하세요");
    pw.focus();
    return false;
  }
  if(email.value == ""){
    alert("이메일을 입력하세요");
    email.focus();
    return false;
  }
  if(phone.value == ""){
    alert("전화번호를 입력하세요");
    phone.focus();
    return false;
  }
}

//아이디 중복확인
function idCheck(){
  var member_id = $("#member_id").val();
  $.ajax({
    url: "${pageContext.request.contextPath}/member/idCheck.do",		
    		type:"post", 
			data: {"member_id" : member_id},
			success:function(data){
				if($.trim(data) == 1){
					$("#idResult").html("이미 사용 중인 아이디입니다");
					$("#idResult").css("color", "red");
				}else if($.trim(data) == 0){
					$("#idResult").html("사용 가능한 아이디입니다");
					$("#idResult").css("color", "green");
				}
			},
			error: function(){
				console.log("아이디 중복확인 ajax 에러");
			}
  });
}