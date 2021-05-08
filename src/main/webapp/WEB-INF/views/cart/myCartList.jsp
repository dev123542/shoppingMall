<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myProductList"  value="${cartMap.myProductList}"  />
<c:set var="totalGoodsNum" value="0" />  <!--주문 개수 -->
<c:set var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 --> 
<c:set var="totalDiscart_goods_qtyedPrice" value="0" /> <!-- 총 할인금액 -->
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.MS_security_checkbox { }
/* 배송비 레이어 */
.MS_tb_delivery { position: relative; cursor: pointer; }
.MS_tb_delivery .MS_deli_block { display: block; }
.MS_tb_delivery .MS_layer_delivery { 
    display: none; 
    position: absolute; 
    right: -221px; 
    top: 0px; 
    border: 3px solid #747474; 
    cursor: default; 
    background: #fff;
}
.MS_tb_delivery .MS_layer_delivery iframe.MS_layer_delivery_iframe { 
    left:-3px;
    top:-3px;
    width:192px;
    height:100px;
    position:absolute;
    filter:alpha(opacity=0); 
    opacity:0;
    z-index:-1;
}
.MS_tb_delivery .MS_layer_delivery dl { padding: 10px; width: 180px; text-align: left; border: 3px solid #eee; }
.MS_tb_delivery .MS_layer_delivery dl dt { font-weight: bold; }
.MS_tb_delivery .MS_layer_delivery dl dd { margin-top: 5px; }
.MS_tb_delivery .MS_layer_delivery .bull { 
    display: block; 
    position: absolute; 
    left: -13px; 
    top: 0px; 
    width: 0px; 
    height: 0px; 
    font-size:0; 
    line-height: 0; 
    border: 5px solid #fff; 
    border-right: 5px solid #747474;
}

</style>

<script type="text/javascript">
/* 체크박스 선택 */
$("#allCheck").click(function(){
    var chk = $("#allCheck").prop("checked");
    if(chk) {
        $(".txt_c").prop("checked", true);
            itemSum();
    } else {
         $(".txt_c").prop("checked", false);
        	itemSum();
    }
});
 
/* 체크박스를 하나라도 풀면 전체선택 체크박스를 푸는 스크립트 */
$(".txt_c").click(function(){
  $("#allCheck").prop("checked", false);
});


function overcase(obj, cnt) {
    obj._tid = setTimeout('imgview(' + cnt + ')', 200);
}

function outcase(obj, cnt) {
    document.getElementById('deliverycase' + cnt).style.display = 'none';
    clearTimeout(obj._tid);
}

function imgview(cnt) {
    document.getElementById('deliverycase' + cnt).style.display = 'block';
}

function change(num){
var x  = document.frm_order_all_cart;
var y = Number(x.amount.value) + num;
if(y < 1) y = 1;
x.amount.value = y;
} 

function calcProductPrice(bagPrice,obj){
	var totalPrice, final_total_price, totalNum;
	var product_qty =document.getElementById("select_goods_qty"); //select_goods_qty가 없음
	var p_totalNum =document.getElementById("p_totalNum");
	var p_totalPrice =document.getElementById("p_totalPrice");
	var p_final_totalPrice =document.getElementById("p_final_totalPrice");
	
	var h_totalNum=document.getElementById("h_totalNum");
	var h_totalPrice=document.getElementById("h_totalPrice");
	var h_totalDelivery=document.getElementById("h_totalDelivery");
	var h_final_total_price=document.getElementById("h_final_totalPrice");
	
	if(obj.checked==true){
		alert("checked")
		
		totalNum=Number(h_totalNum.value)+Number(goods_qty.value);
		//alert("totalNum:"+totalNum);
		totalPrice=Number(h_totalPrice.value)+Number(goods_qty.value*bagPrice);
		//alert("totalPrice:"+totalPrice);
		final_total_price=totalPrice+Number(h_totalDelivery.value);
		//alert("final_total_price:"+final_total_price);

	}else{
		alert("unchecked")
	//	alert("h_totalNum.value:"+h_totalNum.value);
		totalNum=Number(h_totalNum.value)-Number(goods_qty.value);
	//	alert("totalNum:"+ totalNum);
		totalPrice=Number(h_totalPrice.value)-Number(goods_qty.value)*bagPrice;
	//	alert("totalPrice="+totalPrice);
		final_total_price=totalPrice-Number(h_totalDelivery.value);
	//	alert("final_total_price:"+final_total_price);
	}
	
	h_totalNum.value=totalNum;
	
	h_totalPrice.value=totalPrice;
	h_final_total_price.value=final_total_price;
	
	p_totalNum.innerHTML=totalNum;
	p_totalPrice.innerHTML=totalPrice;
	p_final_totalPrice.innerHTML=final_total_price;
}

function modify_cart_qty(product_no,bagPrice,index){
	var length=document.frm_order_all_cart.cart_goods_qty.length;
    var _cart_goods_qty=0;
	if(length>1){ //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index].value;		
	}else{
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty.value;
	}
	var cart_goods_qty=Number(_cart_goods_qty);
	var totalGoodsNum = document.getElementById("h_totalGoodsNum");
	var totalGoodsPrice = document.getElementById("h_totalGoodsPrice");
	
	$.ajax({
		type : "post",
		url : "${path}/cart/modifyCartQty.do",
		data : {
			product_no:product_no,
			cart_goods_qty:cart_goods_qty
		},
		
		success : function(data, textStatus) {
			if(data.trim()=='modify_success'){
				alert("수량을 변경했습니다!!");
				totalGoodsNum.value=_cart_goods_qty;
				totalGoodsPrice.value=totalGoodsNum.value*bagPrice;
			}else{
				alert("다시 시도해 주세요!!");	
			}
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
		}
	}); //end ajax	
}

function delete_cart_goods(cart_no){
	var cart_id=Number(cart_no);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_no";
	i_cart.value=cart_no;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${path}/cart/removeCartProduct.do";
    formObj.submit();
}

/* function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	var total_price,final_total_price,_goods_qty;
	var cart_goods_qty=document.getElementById("cart_goods_qty");
	
	_order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=_order_goods_qty;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
}

function fn_order_all_cart_goods(){
//	alert("모두 주문하기");
	var order_goods_qty;
	var order_goods_id;
	var objForm=document.frm_order_all_cart;
	var cart_goods_qty=objForm.cart_goods_qty;
	var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
	var checked_goods=objForm.checked_goods;
	var length=checked_goods.length;
	
	
	//alert(length);
	if(length>1){
		for(var i=0; i<length;i++){
			if(checked_goods[i].checked==true){
				order_goods_id=checked_goods[i].value;
				order_goods_qty=cart_goods_qty[i].value;
				cart_goods_qty[i].value="";
				cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
				//alert(select_goods_qty[i].value);
				console.log(cart_goods_qty[i].value);
			}
		}	
	}else{
		order_goods_id=checked_goods.value;
		order_goods_qty=cart_goods_qty.value;
		cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
		//alert(select_goods_qty.value);
	}
		
 	objForm.method="post";
 	objForm.action="${contextPath}/order/orderAllCartGoods.do";
	objForm.submit();
} */

</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 장바구니 content -->
<div id="content">
<div id="cartWrap">
	<h2 class="tit-page">
	<img src="${path }/resources/image/cart_title.gif" alt="shopping cart" title="shopping cart" />
	</h2>
    	<div class="page-body">
        <div class="table-cart table-fill-prd">
            <table summary="번호, 사진, 제품명, 수량, 적립, 가격, 배송비, 취소">
                <%-- <caption>장바구니 담긴 상품</caption>	 --%>	
		         <colgroup>
		             <col width="60" />
		             <col width="100" />
		             <col width="*" />
		             <col width="100" />
		             <col width="110" />
		             <col width="110" />
		             <col width="110" />
		             <col width="80" />
		         </colgroup>
                     <thead>
                         <tr>
                             <th scope="col">번호</th>
                             <th scope="col" colspan="2">제품명</th>
                             <th scope="col">수량</th>
                             <th scope="col" class="notborder_right">적립</th>
                             <th scope="col">가격</th>
                             <th scope="col">배송비</th>
                             <th scope="col" class="notborder_right">취소</th>
                         </tr>
                     </thead>
                     
                     <c:choose>
				   	 <c:when test="${ empty myCartList}">
                     <tfoot>
                         <tr>
                   	          <td colspan="8">
                                <div class="not_basket">
									<img src="${path }/resources/image/basket_none.gif"><br>
									<span class="title">장바구니에 담긴 상품이 없습니다.</span>
								</div>
                             </td>
                         </tr>
                     </tfoot>
		             <tbody>
		             </tbody>
			</table>	
			</c:when>
			
			<c:otherwise>
			<tbody>
			 <form  method="post" name="frm_order_all_cart" id="basket_form">
                    <c:forEach var="item" items="${myProductList }" varStatus="cnt">
				    	<c:set var="cart_goods_qty" value="${myCartList[cnt.count-1].cart_goods_qty}" />
				    	<c:set var="cart_no" value="${myCartList[cnt.count-1].cart_no}" />                                          
                    
	                    <tr class="nbg">
	                    <td><input type="checkbox" name="checked_goods"  checked  class="txt_c" id="allCheck"
	                    		value="${item.product_no }"  onClick="calcProductPrice(${item.sale_price },this)"s></td>
	                    <td class="notborder_right txt_c goods_thumb">
							<div class="thumb">
								<a href="${path}/product/productDetail.do?product_no=${item.product_no }">
								<img src="${path}/thumbnails.do?product_no=${item.product_no}&fileName=${item.product_image}" 
											alt="상품 섬네일" title="상품 섬네일" /></a>
							</div>
	                    </td>
					
	                    <td class="goods_opt">
	                    <div class="txt_l">
						<div class="goods_title">
	                    	<a href="${path}/product/productDetail.do?product_no=${item.product_no }">${item.product_name }</a> 
	                    </div>
	                    </div>
	                    
	                    <td>
	                    <div class="txt_c">
	                    <div class="opt-spin">
		                    <input type="text" name="amount" id="cart_goods_qty" value="${cart_goods_qty}" class="txt-spin"/>													
		                    <a class="up" href="javascript:change(1);">
		                    <img class="btn-up" src="${path }/resources/image/btn_h8_spin_up.gif" /></a>
		                    <a class="down" href="javascript:change(-1);">
		                    <img class="btn-dw" src="${path }/resources/image/btn_h8_spin_dw.gif" /></a>
	                    </div>	
							<a href="javascript:modify_cart_qty(${item.product_no },${item.sale_price },${cnt.count-1 });" >
						    <img src="${path }/resources/image/btn_h19_modify.gif" alt="수정" title="수정" />
							</a>
	                    </div>
	                    </td>
	                    
	                    <td class="notborder_right txt_c">
	                    	<fmt:formatNumber  value="${item.sale_price*0.1}" type="number" 
	                    	var="discart_goods_qtyed_price" pattern="###,###" />
				            ${item.sale_price*0.1}</td>
	                    <td class="txt_c b fc_blue" pattern="###,###">
	                    	<span><fmt:formatNumber value="${item.sale_price }" type="number"  />
							${sale_price }원</span></td>
	                    <td>
		                    <div class="tb-center tb-delivery"><div class="MS_tb_delivery">
			                	<span class="MS_deli_txt" onmouseover="overcase(this, '0')" onmouseout="outcase(this, '0')">
			     				<span class="MS_deli_title MS_deli_block">[기본배송]</span>
			     				<span class="MS_deli_desc MS_deli_block">조건</span>
		 					</span>
							<div id="deliverycase0" class="MS_layer_delivery">
								<dl>
				         			<dt>배송조건 : 기본배송(조건)</dt>
				         			<dd>주문금액이 <span class='MS_highlight'>50,000원</span> 미만시 <br />
			         				<br style='line-height:3px' />배송비 
			         				<span class='MS_highlight'>2,500원</span>이 청구됩니다.</dd>
			                    </dl>
			                    <span class="bull"></span>
			                    <iframe id="deliverycase_iframe0" class="MS_layer_delivery_iframe" frameborder="no" border="0"></iframe>
		                    </div>
		                    </div></div>
	                    </td>
	                    <td class="notborder_right txt_c">
								<a class="del_btn" href="javascript:delete_cart_goods('${cart_no}');">삭제하기</a>
	                    </td>
	                    </tr>
						<c:set  var="totalGoodsPrice" value="${totalGoodsPrice+item.sale_price *cart_goods_qty }" />
						<c:set  var="totalGoodsNum" value="${totalGoodsNum+1*cart_goods_qty }" />
			   	</c:forEach>
		   		</form>
				</tbody>
				
				 <tfoot>
	             	<tr>
	                	 <td colspan="8">
	                    	<div class="total_payment txt_r">
	                    	 <span class="fs_16 b fc_gray8 number_pst">
	                    	 	총 상품수 :
	                    		<input id="h_totalGoodsNum"  value="${totalGoodsNum}" 
	                    		type="text" style="border:none;" background="transparent;" size=1 readonly/>개</p></span><br>
	                       	 <span class="fs_16 b fc_gray8 number_pst">
							 	총 구매금액 :  
								<input id="h_totalGoodsPrice" value="${totalGoodsPrice}" 
								type="number" style="border:none;" background="transparent;" size=1 readonly/>원</p></span>
	                        </div>
	                      </td>
	              	</tr>
	              </tfoot>
                                
                </table>
        </c:otherwise>
		</c:choose>      
		
				<!-- 테스트용 버튼 -->
	           	<%-- <a href="${path }/order/orderCartMain.do">
					     <img src="${path }/resources/image/cart_order_btn_on.gif" alt="주문하기" title="주문하기" 
					     onmouseover="this.src='${path }/resources/image/cart_order_btn.gif'" onmouseout="this.src='${path }/resources/image/cart_order_btn_on.gif'" /></a> --%>       
                           
	             </div><!-- .table-fill-prd -->
				 <div class="btn-order-ctrl">
				     <%-- <a href="javascript:alert('주문이 가능한 금액이 아닙니다.고객센터에 문의 바랍니다.')">
					     <img src="${path }/resources/image/cart_order_btn_on.gif" alt="주문하기" title="주문하기" 
					     onmouseover="this.src='${path }/resources/image/cart_order_btn.gif'" onmouseout="this.src='${path }/resources/image/cart_order_btn_on.gif'" /></a> --%>
					 <a href="${path }/order/orderCartMain.do">
					     <img src="${path }/resources/image/cart_order_btn_on.gif" alt="주문하기" title="주문하기" 
					     onmouseover="this.src='${path }/resources/image/cart_order_btn.gif'" onmouseout="this.src='${path }/resources/image/cart_order_btn_on.gif'" /></a>    
				     <a href="${path }/">
					     <img src="${path }/resources/image/join_cancel_on3.gif" alt="쇼핑계속하기" title="쇼핑계속하기" 
					     onmouseover="this.src='${path }/resources/image/join_cancel.gif'" onmouseout="this.src='${path }/resources/image/join_cancel_on3.gif'" /></a>
					 <a href="javascript:delete_cart_goods('${cart_no}');">
					 	<img src="${path }/resources/image/cart_delete_btn_on.gif" alt="장바구니비우기" title="장바구니비우기" 
					 	onmouseover="this.src='${path }/resources/image/cart_delete_btn.gif'" onmouseout="this.src='${path }/resources/image/cart_delete_btn_on.gif'" /></a>
				                  </div>
				<div class="cart-nhn">
					<div class="cart-nhn-container">
					</div>
				</div>
		
<!-- 장바구니 content end -->
</form>	
</body>
</html>