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
  <script src="${contextPath }/resources/ckeditor/ckeditor.js"></script>
  <script type="text/javascript">
  
  // 상품분류와 상품세부분류
  function itemChange(){
    var leather = ["토트백","숄더백","크로스백","모터백","백팩","패브릭","클러치"];
    var trand = ["토트백","숄더백","크로스백","모터백","백팩","패브릭","여행 가방","클러치"];
    var eco = ["토트백","숄더백","크로스백","투웨이백"];
    var wallet = ["지갑","멀티 지갑","커버케이스","카드 지갑", "동전 지갑", "파우치"];
    var shoes = ["플랫","구두","로퍼","스니커즈","부츠","샌들"];
    var bag_acc = ["참장식","스트랩","트윌리","왁스"];
    var acc=["스카프","양말","모자","벨트","안경","시계","목걸이","타투"];
    
    var selectedItem=$("#cate_parent").val();
    var changeItem;
    
    if(selectedItem == '100'){
      changeItem = leather;
    }else if(selectedItem == '200'){
      changeItem = trand;
    }else if(selectedItem == '300'){
      changeItem = eco;
    }else if(selectedItem == '400'){
      changeItem = wallet;
    }else if(selectedItem == '500'){
      changeItem = shoes;
    }else if(selectedItem == '600'){
      changeItem = bag_acc;
    }else if(selectedItem == '700'){
      changeItem = acc;
    }
    
    $("#cate_name").empty();
    var cate_parent = selectedItem;
    for(var i = 0; i < changeItem.length; i++){
	     var option = $("<option value='"+changeItem[i]+"'>"+changeItem[i]+"</option>");
      $("#cate_name").append(option);			
    }
}
  

  // 숫자만 입력 가능
  function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        return false;
  }
  // 문자,기호 입력 불가
  function removeChar(event) {
      event = event || window.event;
      var keyID = (event.which) ? event.which : event.keyCode;
      if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
          return;
      else
          event.target.value = event.target.value.replace(/[^0-9]/g, "");
  }



  // 업로드 이미지 미리보기
  function readURL(input,id) {
    var reader = new FileReader();

    if (input.files && input.files[0]) {
        reader.onload = function (e) {
          if(id =='main_image'){
            $('#preview').attr('src', e.target.result);  
          }else{
            $("#preview"+id).attr('src', e.target.result);  
          }
        }
      
      reader.readAsDataURL(input.files[0]);
    }
  }
  
  // 상품 상세 내역에 들어갈 이미지, 버튼을 누르면 파일선택이 나옴
  var cnt=1;
	function fn_addFile(){
		
		$("#detail_list").append("디테일이미지 "+cnt+" : <input type='file' name='detail_image"+cnt+"' id='"+cnt+"' onchange='readURL(this,this.id);' />"+"<br>");
		if(cnt % 2 != 0){
			$("#image_list").append("<img src='#' width=200 height=200 id='preview"+cnt+"'> <br>");
		}else{
		$("#image_list").append("<img src='#' width=200 height=200 id='preview"+cnt+"'>");
		}
		cnt++;
	}
	
	/* 상품등록 유효성 검사 */
	function addFileCheck(){
	  var cate_parent = document.getElementById("cate_parent");
	  var product_name = document.getElementById("product_name");
	  var product_sort = document.getElementById("product_sort");
	  var origin_price = document.getElementById("origin_price");
	  var main_image = document.getElementById("main_image");

	  if(cate_parent.value == "상품 분류"){
	    alert("상품분류를 선택하세요");
	    cate_parent.focus();
	    return false;
	  }
	  if(product_name.value == ""){
	    alert("상품 이름을 입력하세요");
	    product_name.focus();
	    return false;
	  }
	  if(product_sort.value == "상품구분"){
	    alert("상품구분을 선택하세요");
	    product_sort.focus();
	    return false;
	  }
	  if(origin_price.value == ""){
	    alert("상품 금액을 입력하세요");
	    origin_price.focus();
	    return false;
	  }
	  if(main_image.value == ""){
	    alert("메인 이미지를 등록하세요");
	    return false;
	  }
	}
	
</script>
  <style>
    td, th {
      padding: 3px;
    }
  </style>
</head>

<body>
  <section id="container" style="background: #fff;">
    
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper" style="background: #fff;">
        <div style="display: flex; justify-content: space-between; justify-content: space-between; align-items: center;">
          <h3><i class="fa fa-angle-right"></i> 상품 등록</h3>
        </div>

         <div class="row">
          <div class="col-sm-5 col-sm-offset-3">
            <form action="${contextPath }/admin/product/addNewProduct.do" method="post" enctype="multipart/form-data" id="frm_register" onsubmit="return addFileCheck()">

              <table style="min-width:50%;">
              <tr>
                <td>상품 분류 </td>
                <td>
                  <select name="cate_parent" id="cate_parent"  class="form-control" onchange="itemChange()">
                    <option value="상품 분류" >상품 분류를 선택하세요</option>
                    <option value="100" >래더백</option>
                    <option value="200" >트렌드백</option>
                    <option value="300" >에코백</option>
                    <option value="400" >지갑</option>
                    <option value="500">신발</option>
                    <option value="600">가방 악세사리</option>
                    <option value="700">악세사리</option>
                  </select>
                </td>
                </tr>
              <tr>
                <td >상품 세부 분류 </td>
                <td >
                  <select id="cate_name" name="cate_name"  class="form-control">
                <option value="상품 세부 분류">상품 세부 분류를 선택하세요</option>
                <!-- <option selected>상품 세부 분류를 선택하세요</option>   	 		 -->
                  </select>
                </td>
              </tr>
              <tr>
                <td>상품 이름 </td>
                <td>
                  <input type="text" id="product_name" name="product_name" size="39" class="form-control"/>
                </td>
                </tr>
                <tr>
                  <td>상품 구분 </td>
                  <td>
                    <select id="product_sort" name="product_sort"  class="form-control">
                      <option value="상품구분">--상품 구분--</option>
                      <!-- <option value="new" selected>신제품</option> -->
                      <option value="신상품">신상품</option>
                      <option value="베스트">베스트</option>
                      <option value="잇백">잇백</option>
                      <option value="할인">할인중</option>
                      <option value="품절">품절</option>
                    </select>
                  </td>
              </tr>
               <tr>
                <td>상품 금액</td>
                <td>
                  <input type="text" name="origin_price" id="origin_price" size="39" maxlength="10" class="form-control"  onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" />
                </td>
                </tr>
                <tr>
                <td>상품 할인 금액</td>
<!--                 <td>상품 할인율(%) </td> -->
                <td>
                  <input type="text" name="sale_price" id="sale_price" size="39"  class="form-control" maxlength="10"  onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"/>
                </td>
              </tr>
             
             <tr>
             <td>상품 색상 </td>
            <td>
            <select name="product_color"  class="form-control">
              <!-- 색상추가 일치시키기 -->
              <option value="상품색상">색상을 선택하세요</option>
              <!-- <option value="머드" selected>머드</option> -->
              <option value="머드">머드</option>
              <option value="카멜">카멜</option>
              <option value="브라운">브라운</option>
              <option value="블랙">블랙</option>
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
              <td>판매 재고(수량) </td>
            <td  class="b">
              <input type="text" name="pro_quantity" size="39" class="form-control" maxlength="10" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" />
              <input type="number" name="pro_quantity" size="39" id="pro_quantity" class="form-control" min="0"/>	
            </td>
              </tr>  -->          
             <tr>
                <td>상품 설명</td>
                <td>
                  <textarea rows="8" cols="39" name="product_content" class="form-control"></textarea>
                </td>
                <!-- ck 에디터 -->
	           	<script>
					 var ckeditor_config = {
					   resize_enaleb : false,
					   enterMode : CKEDITOR.ENTER_BR,
					   shiftEnterMode : CKEDITOR.ENTER_P,
					   filebrowserUploadUrl : "${contextPath }/admin/product/ckUpload"
					 };
					 
					 CKEDITOR.replace("product_content", ckeditor_config);
				</script>
              </tr>
              <tr>
               <td>메인 이미지 추가 </td>
               <td style="display: flex; justify-content: space-between;">
                <input type="file" value="메인 이미지 등록" id="main_image" name="main_image"  onchange="readURL(this,this.id);" />
                <input type="button" value="디테일 이미지 추가" onClick="fn_addFile()" class="btn btn-primary" /> 
               </td>
               </tr>
             <tr>
              <td>상품 이미지 등록 </td>
              <td colspan="2">
                  <!-- 상품 상세 내용에 들어갈 이미지 input file -->
                  <div id="detail_list"></div>
                  <!-- 상품 썸네일 이미지 -->
                  <div id="image_list">
                    <img id="preview" src="" width=200 height=200 /> 
                  </div>
              </td>
             </tr>
           <tr>
             <td colspan="4" style="text-align: center; padding:10px;">
              <input type="submit" value="상품 등록하기" class="btn btn-primary" /> 
              <input type="button" value="목록창으로 돌아가기" onClick="backToList(this.form)" class="btn btn-warning"/>
             </td>
          </tr>
           </table>
           </form>
          </div>
         </div>
      </section>
    </section>
      
  </section>
</body>
</html>