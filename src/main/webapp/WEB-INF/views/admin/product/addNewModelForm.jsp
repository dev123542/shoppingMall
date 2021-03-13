<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>상품 등록</title>
  <script src="${contextPath }/resources/lib/jquery/jquery.min.js"></script>
  <script>
    function exit(){
      
      self.close();
    }
    
   /*  function submitBtn(){
      document.modelform.submit();
       alert('정보 등록 완료');
      self.close();
      opener.parent.location.reload();
    } */
  </script>
  <style>
    td, th {
      padding: 3px;
    }
  </style>
</head>

<body>
	<h1>상품 정보 추가하기</h1>
			
			
	<form method="post" name="modelform" action="${contextPath }/admin/product/addNewModel.do">
		<table>
		<tr>
			<td>상품번호 :</td>
			<td><input type="text" value="${product_no }" name="product_no" disabled /></td>		
			<td><input type="hidden" value="${product_no }" name="product_no"  /></td>		
		</tr>
		
		<tr>
			<td>상품 카테고리 :</td>
			<td><input type="text" value="${cate_code }" name="cate_code" disabled /></td>
			<td><input type="hidden" value="${cate_code }" name="cate_code"  /></td>
		</tr>
		
		<tr>
			<td>상품 세부 카테고리 :</td>
			<td>
			<c:choose>
				<c:when test="${cate_code =='100'}">
					<select name="cate_name">
						<option value="토트백" selected>토트백</option>
						<option value="숄더백" >숄더백</option>
						<option value="크로스백" >크로스백</option>
						<option value="모터백" >모터백</option>
						<option value="백팩" >백팩</option>
					    <option value="패브릭백" >패브릭백</option>
					    <option value="클러치백" >클러치백</option>
					</select>
				</c:when>
			
				<c:when test="${cate_code =='200'}">
					<select name="cate_name">
						<option value="토트백" selected>토트백</option>
						<option value="숄더백" >숄더백</option>
						<option value="크로스백" >크로스백</option>
						<option value="모터백" >모터백</option>
						<option value="백팩" >백팩</option>
						<option value="패브릭백" >패브릭백</option>
			      	    <option value="여행 가방" >여행 가방</option>
						<option value="클러치백" >클러치백</option>
					</select>
				</c:when>
				
				<c:when test="${cate_code =='300'}">
					<select name="cate_name">
						<option value="토트백" selected>토트백</option>
						<option value="숄더백" >숄더백</option>
						<option value="크로스백" >크로스백</option>
						<option value="투웨이백" >투웨이백</option>
					</select>
				</c:when>
				
				<c:when test="${cate_code =='400'}">
					<select name="cate_name">
						<option value="지갑" selected>지갑</option>
						<option value="멀티지갑" >멀티지갑</option>
						<option value="커버케이스" >커버케이스</option>
						<option value="카드지갑" >카드지갑</option>
						<option value="동전지갑" >동전지갑</option>
						<option value="파우치" >파우치</option>
					</select>
				</c:when>
				
				<c:when test="${cate_code =='500'}">
					<select name="cate_name">
						<option value="플랫" selected>플랫</option>
						<option value="구두" >구두</option>
						<option value="로퍼" >로퍼</option>
						<option value="스니커즈" >스니커즈</option>
			      		<option value="부츠" >부츠</option>
			      		<option value="샌들" >샌들</option>
					</select>
				</c:when>
				
				<c:when test="${cate_code =='600'}">
					<select name="cate_name">
						<option value="참장식" selected>참장식</option>
						<option value="스트랩" >스트랩</option>
						<option value="트윌리" >트윌리</option>
						<option value="왁스" >왁스</option>
						<option value="악세사리" >악세사리</option>
					</select>
				</c:when>
				
				<c:when test="${cate_code =='700'}">
					<select name="cate_name">
						<option value="스카프" selected>스카프</option>
						<option value="양말" >양말</option>
						<option value="모자" >모자</option>
						<option value="벨트" >벨트</option>
						<option value="안경" >안경</option>
						<option value="시계" >시계</option>
				        <option value="목걸이" >목걸이</option>
				        <option value="타투" >타투</option>
					</select>
				</c:when>
			</c:choose>
			</td>	
		</tr>
		
		<tr>
			<td>상품 색상 :</td>
			<td>
			<select name="product_color">
			  <option value="블랙" selected>블랙</option>
			  <option value="머드">머드</option>
		      <option value="카멜">카멜</option>
		      <option value="브라운">브라운</option>
		      <option value="아이보리">아이보리</option>
		      <option value="베이지">베이지</option>
		      <option value="카키">카키</option>
		      <option value="네이비">네이비</option>
		      <option value="그레이">그레이</option>
		      <option value="그린">그린</option>
		      <option value="옐로우">옐로우</option>
		      <option value="오렌지">오렌지</option>
		      <option value="화이트">화이트</option>
		      <option value="스카이">스카이</option>
		      <option value="라벤더">라벤더</option>
		      <option value="핑크">핑크</option>
		      <option value="올리브">올리브</option>
		      <option value="차콜">차콜</option>
		      <option value="와인">와인</option>
		      <option value="코발트블루">코발트블루</option>
		      <option value="타프베이지">타프베이지</option>
		      <option value="실버">실버</option>
			</select>
			</td>
		</tr>
		
		<!-- <tr>
			<td>판매 재고 :</td>
			<td>지금 애 스트링으로 받아옴 
				<input type="text" name="pro_quantity" />개		
			</td>
		</tr> -->
		<tr>
			<td>&nbsp;</td>
			<td>
 				<input type="submit" value="등록" />
				<input type="button" onclick="exit()" value="취소" />
			</td>
		</tr>
			
		</table>	
	</form>
</body>
</html>