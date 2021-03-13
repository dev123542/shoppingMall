<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${path }/resources/css/style.css" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>아이디 찾기</title>
<script type="text/javascript"> 
function check(){
	if (document.form1.member_name.value.length == 0) {
        document.form1.member_name.focus();
        alert('이름을 입력하세요.');
        return;
    }
    if (document.form1.email.value.length == 0) {
        document.form1.email.focus();
        alert('이메일을 입력하세요.');
        return;
    }
	
    /* 수정필요 */
	$.ajax({
        url:"${contextPath}/findId",
        type:"POST",
        async : true,
        data : {
        		member_name : $("member_name").val(),
				email : $("#email").val()
        },
        success:function(data, textStatus){
        	var findId = data.member_id;
        	console.log(data);
       	 	$("idList").append("<h1>"+"회원님의 정보로 등록된 아이디는 : "+ findId +" 입니다.</h1>")
       	 	alert("회원님의 정보로 등록된 아이디는 : "+ data +" 입니다.</h1>");
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
        	alert("입력하신 정보가 없습니다.");
        }
    });  
  
}
</script>
</head>
<body>
<div id="contentWrapper">
<div id="contentWrap">
<div id="content">
	<div id="findIdPwd">
	<h2 class="tit_page">
		<img src="${path }/resources/image/tit_lostpass.gif" alt="id&pass"  title="id&pass" />
	</h2>
	<form name="form1" method="post" action="${path }/member/findId.do" target="loginiframe">
		<div class="">
		<div class="content_container">
			<ul class="cb_clear">
				<li class="tit">
					<p>본인확인 정보 입력</p>
					<div class="ud_line"><img src="${path }/resources/image/info_line.gif" alt="라인"></div>
					<h3 class="w-normal">아이디/패스워드 재발급을 위해 본인 인증을 하셔야 합니다.</br>본인 인증시 입력된 정보는 안전하게 보호 됩니다.</h3>
				</li>
				<li class="txt">
					<div class="input_table cb_clear">
						<div class="find-info">
						<table>
							<colgroup>
							<col width="135"/>
							<col width="*"/>
							<col width="191"/>
							</colgroup>
							<tr>
								<th><div>이&nbsp;&nbsp;름</div></th>
								<td><div> <input type="text" id="member_name" name="member_name"  class="MS_input_txt" value="" maxlength="30" title="이름" placeholder=""></div></td>
								<td rowspan="2">
								<div class="btn-area">
								<a class="info-confirm" href="javascript:check();"><img alt="확인" src="${path }/resources/image//my_info_submit.gif"/></a>
								</div>
							</td>
							</tr>
						  	<tr>
							<th><div>이메일</div></th>
							<td><div><input type="text" id="email" name="email"  class="MS_input_txt" value="" maxlength="80" title="이메일 주소" placeholder="" ></div></td>
							</tr>
						</table>
						<br>
						<span id="idList"></span>
						</div>
					</div>
				</li>
			</ul>
		
	</div>
	<div>
	</div>
	</div>
	</form>
	<div class="btn-foot">
		<img src="${path }/resources/image/lostpass_cancel_btn.gif" alt="돌아가기" title="돌아가기" onmouseover="this.src='${path }/resources/image/lostpass_cancel_btn_on.gif'" onmouseout="this.src='${path }/resources/image/lostpass_cancel_btn.gif'" onclick="Javascript:history.back();" />
	</div>
    </div><!-- #findIdPwd -->
</div><!-- #content -->
</div><!-- #contentWrap -->
</div><!-- #contentWrapper-->
<hr />
</body>
</html>