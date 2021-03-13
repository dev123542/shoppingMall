<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function(){	
	 	$(".write_btn").on("click", function(){
	 		
	 		/* 과제2번 */
		 	var strv = document.getElementsByClassName('chk').value;
			var __entityMap = { 
					"&": "&amp;", 
					"<": "&lt;", 
					">": "&gt;", 
					'"': '&quot;', 
					"'": '&#39;', 
					"/": '&#x2F;' 
			}; 
			
			  var escapeHTML = function(str) { 
			     return String(str).replace(/[&<>"'\/]/g, function (s) { 
			        return __entityMap[s]; 
			        }); 
			  }
			
			 /* function submitForm() { */
			    //console.log("wow");
			    var tit = document.getElementById("title");
			   var con = document.getElementById("content");
			     var title = escapeHTML(tit.value);      
			     var content = escapeHTML(con.value);
			      
			     tit.value = title;
			     con.value = content; 
			     console.log(tit.value); 
			     document.writeForm.submit();
			  /* } */

			
			/* 과제2번끝 */
			
			if(fn_valiChk()){
				return false;
			}
			formObj.attr("action", "${path }/qna/write.do");
			formObj.attr("method", "post");
			formObj.submit();
		});
		fn_addFile();
	})
	/* fn_valiChk()수정필요 */
	function fn_valiChk(){
		var regForm = $("form[name='writeForm'] .chk").length;
		for(var i = 0; i<regForm; i++){
			if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
	}
	function fn_addFile(){
		var fileIndex = 1;
		$(".fileAdd_btn").on("click", function(){
			$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
		});
		$(document).on("click","#fileDelBtn", function(){
			$(this).parent().remove();
		});
	}
	
    $(document).ready(function(){
        $("#write_btn").click(function(){
            var title = $("#title").val();
            var content = $("#content").val();
            if(title == ""){
                alert("제목을 입력하세요");
                document.writeForm.title.focus();
                return;
            }
            if(content == ""){
                alert("내용을 입력하세요");
                document.writeForm.content.focus();
                return;
            }

        });
    });
</script>

<section id="container">
<br>
<div>
<%@include file="nav.jsp" %>
</div>
<hr />
	<form name="writeForm" method="post" action="${path }/qna/write.do" enctype="multipart/form-data">
	<table>
	<tbody>
		<c:if test="${not empty sessionScope.member && sessionScope.member != null }">
			<tr>
				<td>
					<label for="title">제목</label>
					<input type="text" id="title" name="title" class="chk" title="제목을 입력하세요."/>
				</td>
			</tr>	
			<tr>
				<td>
					<label for="content">내용</label>
					<textarea id="content" name="content" class="chk" title="내용을 입력하세요."></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<label for="writer">작성자</label>
					<input type="text" id="writer" name="writer" class="chk" title="작성자를 입력하세요." value="${sessionScope.member}" />
				</td>
			</tr>
			<tr>
			<tr>
				<td id="fileIndex">
				</td>
			</tr>
			<tr>
				<td>						
					<button class="write_btn" type="submit">작성</button>	
					<button class="fileAdd_btn" type="button">파일추가</button>	
				</td>
			</tr>	
		</c:if>
		<c:if test="${empty sessionScope.member && sessionScope.member == null && empty sessionScope.admin && sessionScope.admin == null }">
			<p>로그인 후에 작성하실 수 있습니다.</p>
		</c:if>
						
			</tbody>			
		</table>
	</form>
	
</section>
<hr />
</div>
</body>
</html>