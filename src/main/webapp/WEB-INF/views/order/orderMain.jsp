<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myProductList"  value="${cartMap.myProductList}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 페이지</title>
</head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" type="text/javascript"></script>
<script type="text/javascript">
// 카카오 주소 API
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                
                // 주소변수 문자열과 참고항목 문자열 합치기 - 추가
                addr += extraAddr;
                
                
                // 조합된 참고항목을 해당 필드에 넣는다.
                //document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
               // document.getElementById("sample6_extraAddress").value = '';
               addr += '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('member_add1').value = data.zonecode;
            document.getElementById("member_add2").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("member_add3").focus();
        }
    }).open();
}


// 주문하기 버튼
function order(){
	document.order_form.submit();
}


// 취소 버튼
function order_cancel(){
	if(confirm("결제를 취소하시겠습니까? 장바구니로 이동합니다") == true){
		location.href="";
	}else{
		return;
	}
}

</script>
<style type="text/css">
body,
h1, h2, h3, h4, h5, h6, table,
input, select, textarea, a {
    font-size: 12px;
    line-height: 1.7;
    color: #777;
    font-family: Dotum, AppleGothic, Helvetica, sans-serif;
}

#cartWrap {
    margin:0 auto 50px;
    }
    
    #cartWrap .loc-navi dd {
    height:65px;
    line-height:65px;
    text-align:right;
    color:#555;
    padding:0 10px 0 0;
    }
    
    #cartWrap h2.tit-page {
    position:relative;
    padding: 0 0 11px;
    margin: 40px 0 30px;
    /*border-bottom:1px solid #333;*/
    border-bottom:none;
    }
    
    #cartWrap h2.tit-page .member_info {
    position:absolute;
    top:60px;
    left:250px;
    font-size:12px;
    line-height:18px;
    color:#666;
    }
    
    #cartWrap h2.tit-page .member_info .partition {
    color:#ddd;
    margin:0 10px;
    }
    
    #cartWrap .page-body .tit-cart {
    position:relative;
    height:40px;
    line-height:40px;
    margin:15px 0 0;
    }
    
    #cartWrap .page-body .tit-cart img {
    vertical-align:middle;
    }
    
    #cartWrap .page-body .tit-cart .btns {
    position:absolute;
    top:0;
    right:0;
    }
    
    #cartWrap .page-body .tit-cart .btns .cart_print {
    display:inline-block;
    width:85px;
    height:24px;
    line-height:2.4;
    font-weight:bold;
    text-align:center;
    text-decoration:none;
    letter-spacing:-1px;
    color:#666;
    border:1px solid #dbdbdb;
    background:#fff;
    }
    
    #cartWrap .page-body .tit-cart .btns .cart_del {
    display:inline-block;
    width:100px;
    height:24px;
    line-height:2.4;
    font-weight:bold;
    text-align:center;
    text-decoration:none;
    letter-spacing:-1px;
    color:#fff;
    border:1px solid #d55453;
    background:#f45e5d;
    }
    
    .table-cart {
    margin:0 0 20px;
    border-top:1px solid #898989;
    }
    .table-cart a {
    text-decoration:none;
    }
    
    .table-cart form {
    
    }
    
    .table-cart thead {
    width:100%;
    background:url("http://www.whosbag.com/design/whosbag/smartpc/defalut_img/board_head.gif") repeat-x;
    }
    
    .table-cart thead th {
    height:32px;
    color:#333;
    font-weight:normal;
    border-right:1px solid #ddd;
    box-shadow:inset 1px 1px rgba(255,255,255,0.1), inset -1px -1px rgba(255,255,255,0.1);
    -webkit-box-shadow:inset 1px 1px rgba(255,255,255,0.1), inset -1px -1px rgba(255,255,255,0.1);
    padding: 0px;
    background-color: initial;
    }
    
    .table-cart tbody td {
    height:auto;
    padding:10px 0;
    border-right:1px solid #e3e3e3;
    border-top:1px solid #e3e3e3;
    background:none;
    }
    
    .table-cart tfoot {
    background:none;
    }
    
    .table-cart tbody td .thumb {
    width:80px;
    height:auto;
    margin-left:auto;
    margin-right:auto;
    font-siez:0;
    line-height:0;
    border:2px solid #f6f6f6;
    }
    
    .table-cart tbody td .thumb a, .table-cart tbody td .thumb img {
    display:block;
    width:80px;
    height:auto;
    }
    
    .table-cart tbody td.goods_thumb {
    vertical-align:top;
    }
    
    .table-cart tbody td.goods_opt {
    vertical-align:top;
    padding:15px 20px 15px 10px;
    }
    
    .table-cart tbody td.goods_opt .goods_title {
    margin:0 0 10px;
    }
    
    .table-cart tbody td.goods_opt .uni-opt {
    padding:10px 0;
    border-top:1px dotted #c0c0c0;
    }
    
    .table-cart tbody td.goods_opt .uni-opt a {
    display:inline-block;
    width:80px;
    height:20px;
    line-height:2.2;
    font-size:11px;
    text-align:center;
    color:#777;
    background:url("data:image/gif;base64,R0lGODlhUAAUALMAAL6+vv39/eTk5Ly8vNDQ0Jubm7+/v8nJyevr69vb27q6uvDw8MTExJCQkP///wAAACH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozQ0I1QTk4MjVFOTgxMUU0OTgxOUMwMkVDQTczOTk4QiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozQ0I1QTk4MzVFOTgxMUU0OTgxOUMwMkVDQTczOTk4QiI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjNDQjVBOTgwNUU5ODExRTQ5ODE5QzAyRUNBNzM5OThCIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjNDQjVBOTgxNUU5ODExRTQ5ODE5QzAyRUNBNzM5OThCIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+Af/+/fz7+vn49/b19PPy8fDv7u3s6+rp6Ofm5eTj4uHg397d3Nva2djX1tXU09LR0M/OzczLysnIx8bFxMPCwcC/vr28u7q5uLe2tbSzsrGwr66trKuqqainpqWko6KhoJ+enZybmpmYl5aVlJOSkZCPjo2Mi4qJiIeGhYSDgoGAf359fHt6eXh3dnV0c3JxcG9ubWxramloZ2ZlZGNiYWBfXl1cW1pZWFdWVVRTUlFQT05NTEtKSUhHRkVEQ0JBQD8+PTw7Ojk4NzY1NDMyMTAvLi0sKyopKCcmJSQjIiEgHx4dHBsaGRgXFhUUExIREA8ODQwLCgkIBwYFBAMCAQAAIfkEAAAAAAAsAAAAAFAAFAAABGlwEUarvTjrzTsny4E4ZGmeaKqubMsih+HOdG2rBnDvfG8COp9w2AISj8iSMckULpvQ2zNKdU2r2NQ1yyVtu9kvuCoeR8vmJjqdXLOPgEHgXQ0MFAl6NJBQCAoNgYKDhIWGh4iJiokFAhEAOw==") no-repeat;
    }
    
    .table-cart tbody td.goods_opt .opt_detail {
    color:#888;
    }
    
    .table-cart tbody td.goods_opt .opt_detail img {
    margin:-2px 0 0 0;
    }
    
    .table-cart tbody td.goods_opt .opt_detail .MS_option_price {
    color:#f14f4f;
    }
    
    .table-cart tbody td.goods_opt .opt_detail br:first-child {
    display:none;
    }
    
    
    .table-cart tbody td .opt-spin {
    position:relative;
    width:71px;
    height:29px;
    line-height:0;
    padding:0;
    margin:0 auto 5px;
    }
    
    .table-cart tbody td .opt-spin input.txt-spin {
    width:45px;
    height:27px;
    line-height:2.7;
    text-align:center !important;
    border:1px solid #e0dede;
    background:#f2f2f2;
    margin:0;
    }
    
    .table-cart tbody td .opt-spin a {
    display:block;
    position:absolute;
    right:0;
    width:24px;
    }
    
    .table-cart tbody td .opt-spin .up {
    top:0;
    height:15px;
    background:url("data:image/gif;base64,R0lGODlhGAAPALMAAGNjY2RkZGVlZWZmZt/f32JiYt3d3d7e3v///wAAAAAAAAAAAAAAAAAAAAAAAAAAACH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOkMyQkMxMUU0QTQzRkU0MTFBMjgwOUM0MkRFNTk0QTQ5IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkZDQTk2MUI2NEUwNjExRTQ5MjBCOUJDMkY2Rjk5RUIxIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkZDQTk2MUI1NEUwNjExRTQ5MjBCOUJDMkY2Rjk5RUIxIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzYgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6QUFGQzcxMUNERDRERTQxMUE0NjNEQjQyNzg2MzdDMEMiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6QzJCQzExRTRBNDNGRTQxMUEyODA5QzQyREU1OTRBNDkiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4B//79/Pv6+fj39vX08/Lx8O/u7ezr6uno5+bl5OPi4eDf3t3c29rZ2NfW1dTT0tHQz87NzMvKycjHxsXEw8LBwL++vby7urm4t7a1tLOysbCvrq2sq6qpqKempaSjoqGgn56dnJuamZiXlpWUk5KRkI+OjYyLiomIh4aFhIOCgYB/fn18e3p5eHd2dXRzcnFwb25tbGtqaWhnZmVkY2JhYF9eXVxbWllYV1ZVVFNSUVBPTk1MS0pJSEdGRURDQkFAPz49PDs6OTg3NjU0MzIxMC8uLSwrKikoJyYlJCMiISAfHh0cGxoZGBcWFRQTEhEQDw4NDAsKCQgHBgUEAwIBAAAh+QQAAAAAACwAAAAAGAAPAAAEOfDISas0xFyDuv9g2HFiKR5m+qGqypqCmwJAbL5hEQCBfZY8wGAXKOFaP+RNuWQmnaCDYUqtWq/UCAA7") no-repeat;
    }
    
    .table-cart tbody td .opt-spin .down {
    bottom:0;
    height:14px;
    background:url("data:image/gif;base64,R0lGODlhGAAOALMAAGNjY93d3WVlZWRkZGZmZmJiYvz8/N/f3+Dg4N7e3v///wAAAAAAAAAAAAAAAAAAACH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOkMyQkMxMUU0QTQzRkU0MTFBMjgwOUM0MkRFNTk0QTQ5IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjA4OTI0MzFCNEUwNzExRTRCOTQ3RDYxMkE2MkI5N0M5IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjA4OTI0MzFBNEUwNzExRTRCOTQ3RDYxMkE2MkI5N0M5IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzYgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6QUFGQzcxMUNERDRERTQxMUE0NjNEQjQyNzg2MzdDMEMiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6QzJCQzExRTRBNDNGRTQxMUEyODA5QzQyREU1OTRBNDkiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4B//79/Pv6+fj39vX08/Lx8O/u7ezr6uno5+bl5OPi4eDf3t3c29rZ2NfW1dTT0tHQz87NzMvKycjHxsXEw8LBwL++vby7urm4t7a1tLOysbCvrq2sq6qpqKempaSjoqGgn56dnJuamZiXlpWUk5KRkI+OjYyLiomIh4aFhIOCgYB/fn18e3p5eHd2dXRzcnFwb25tbGtqaWhnZmVkY2JhYF9eXVxbWllYV1ZVVFNSUVBPTk1MS0pJSEdGRURDQkFAPz49PDs6OTg3NjU0MzIxMC8uLSwrKikoJyYlJCMiISAfHh0cGxoZGBcWFRQTEhEQDw4NDAsKCQgHBgUEAwIBAAAh+QQAAAAAACwAAAAAGAAOAAAEMlDJSauV6Wqdt5/d54UipwEDIAiDYGrFkBLGe6rjR3xI6QW+DTB4ORAviaRyyVQGnssIADs=") no-repeat;
    }
    
    .table-cart tbody td.quantity_input input {
    width:45px;
    height:27px;
    line-height:2.7;
    text-align:center !important;
    margin:0 5px 0 0;
    border:1px solid #e0dede;
    background:#fff;
    }
    
    .table-cart tbody td .opt-spin .up img, .table-cart tbody td .opt-spin .down img {
    display:none;
    }
    
    .table-cart tbody td .count_modify {
    display:block;
    width:54px;
    height:20px;
    line-height:2.2;
    font-size:11px;
    color:#777;
    margin:0 auto;
    background:url("data:image/gif;base64,R0lGODlhNgAUAJEAAAAAAP///0lJSf///yH5BAEAAAMALAAAAAA2ABQAAAI+lI+py+0Bo5y02lsN3rxT7YXiJ4zmCJ7qlq4u+cZTK790vd74qe9o6XP1gp4hkWM8YpJKC7MJg4oc1Kq1UQAAOw==") no-repeat;
    }
    
    .table-cart tbody td .count_modify img {
    display:none;
    }
    
    .table-cart tbody td .wish_btn {
    display:block;
    width:54px;
    height:20px;
    line-height:2.2;
    font-size:11px;
    color:#fff;
    margin:0 auto 5px;
    background:url("data:image/gif;base64,R0lGODlhNgAUAJEAAAAAAP///wAhV////yH5BAEAAAMALAAAAAA2ABQAAAIflI+py+0Po5y02ouz3rz7D4biSJbmiabqyrbuC8dxAQA7") no-repeat;
    }
    
    .table-cart tbody td .cart_btn {
    display:block;
    width:54px;
    height:20px;
    line-height:2.2;
    font-size:11px;
    color:#fff;
    margin:0 auto 5px;
    background:url("data:image/gif;base64,R0lGODlhNgAUAJEAAAAAAP///0lJSf///yH5BAEAAAMALAAAAAA2ABQAAAIflI+py+0Po5y02ouz3rz7D4biSJbmiabqyrbuC8dxAQA7") no-repeat;
    }
    
    .table-cart tbody td .del_btn {
    display:block;
    width:54px;
    height:20px;
    line-height:2.2;
    font-size:11px;
    color:#777;
    margin:0 auto;
    background:url("data:image/gif;base64,R0lGODlhNgAUAJEAAAAAAP///0lJSf///yH5BAEAAAMALAAAAAA2ABQAAAI+lI+py+0Bo5y02lsN3rxT7YXiJ4zmCJ7qlq4u+cZTK790vd74qe9o6XP1gp4hkWM8YpJKC7MJg4oc1Kq1UQAAOw==") no-repeat;
    }
    
    .table-cart tfoot tr td {
    padding:0;
    border-top:1px solid #d8d8d8;
    }
    
    .table-cart tfoot tr td .not_basket {
    text-align:center;
    padding:40px 0;
    }
    
    .table-cart tfoot tr td .total_payment {
    font-weight:normal;
    color:#666;
    padding:15px 10px;
    background:#f9f9f9;
    }
    
    .table-cart tfoot tr td .total_payment .sign_ico {
    margin:0 10px 0;
    }
    
    .table-cart tfoot tr td .total_payment img {
    vertical-align:middle;
    }
    
    .table-cart tfoot tr td .not_basket .title {
    display:inline-block;
    font-size:16px;
    font-weight:bold;
    color:#111;
    margin:15px 0 0;
    }
    
    .table-cart tfoot tr td .not_basket .body {
    display:inline-block;
    font-size:12px;
    font-weight:normal;
    color:#666;
    margin:5px 0 0;
    }
    
    
    /* 二쇰Ц 而⑦듃濡� 踰꾪듉 */
    #cartWrap .btn-order-ctrl {
    line-height:0;
    font-size:0;
    text-align:center;
    margin:0 0 25px;
    }
    
    #cartWrap .btn-order-ctrl a {
    margin:0 3px;
    }
    
    /* ETC_container */
    .cart_etc_container {
    width:100%;
    margin:0 0 50px;
    }
    
    .cart_etc_container .bottom_banner {
    width:1200px;
    line-height:0;
    padding:0;
    margin:0 auto;
    }
    
    
    #cartWrap .wish-opt { color: #FFA500; }
    /* �뚯썝 �깃툒 �쒖떆 */
    #cartWrap .mem-lvl { zoom: 1; overflow: hidden; margin-top: 45px; }
    
    /* 諛곗넚 硫붿꽭吏� */
    #cartWrap .delivery {
    text-align: center;
    margin:0 0 20px;
    }
    
    #cartWrap  .cart-nhn{
    margin-bottom: 100px;
    }
    
    #cartWrap .cart-nhn-container{
    width: 124px;
    margin: 0 auto;
    }
    
    #order {
    margin:0 0 50px;
    }
    
    #order .loc-navi dd {
    height:65px;
    line-height:65px;
    text-align:right;
    color:#555;
    padding:0 10px 0 0;
    }
    
    #order h2.tit-page {
    position:relative;
    padding: 0 0 11px;
    margin: 40px 0 30px;
    border-bottom: none;
    }
    
    #order h2.tit-page .member_info {
    position:absolute;
    top:60px;
    left:250px;
    font-size:12px;
    line-height:18px;
    color:#666;
    }
    
    #order .page-body h3.stit {
    position:relative;
    height:40px;
    line-height:40px;
    margin:0;
    }
    
    #order .page-body h3.stit img {
    vertical-align:middle;
    margin: -42px 0 0;
    }
    
    #order .page-body fieldset h3 {
    position:relative;
    height:40px;
    line-height:40px;
    margin:15px 0 0;
    }
    
    #order .page-body fieldset h3 img {
    vertical-align:middle;
    }
    
    
    /* 二쇰Ц�� �뺣낫 */
    #order .page-body .table-order-info {
    display:inline-block;
    *display:inline;
    zoom:1;
    padding:0 20px 15px;
    margin: 50px 0 20px;
    border:none;
    border:1px solid #dedede;
    background: #f2f2f2;
    }
    
    #order .page-body .table-order-info .order-table {
    border:none;
    }
    
    #order .page-body .width60 {
    width:60px;
    }
    
    #order .page-body .width80 {
    width:80px;
    }
    
    #order .page-body .width100 {
    width:100px;
    }
    
    #order .page-body .width180 {
    width:180px;
    }
    
    #order .page-body .width580 {
    width:580px;
    }
    
    #order .page-body .table-order-info .order-table th {
    color:#333;
    vertical-align:top;
    background:none;
    }
    
    #order .page-body .table-order-info .order-table th div {
    padding:10px 10px 10px 0;
    }
    
    #order .page-body .table-order-info .order-table td {
    background:none;
    }
    
    #order .page-body .table-order-info .order-table .sub_title {
    height:40px;
    font-size:17px;
    font-weight:bold;
    letter-spacing:-2px;
    }
    
    #order .page-body .table-order-info .order-table .sub_title_txt {
    position:relative;
    color:#333;
    border-bottom:1px solid #ddd;
    }
    
    #order .page-body .table-order-info .order-table .sub_title_txt .same_data {
    position:absolute;
    top: 10px;
    right:0;
    }
    
    #order .page-body .table-order-info .order-table .sub_title_txt .same_data input {
    margin:-2px 0 0 0;
    }
    
    #order .table-order-info li {
    display:block;
    text-align:left;
    text-align:-webkit-left;
    font-size:11px;
    color:#888;
    padding:4px 0;
    }
    
    #order .page-body .table-order-info .order-table td .ml_10 {
    margin:0 0 0 10px;
    }
    
    #order .page-body .table-order-info .order-table td .tel_input input {
    width:80px;
    }
    
    #order .page-body .table-order-info .order-table td input[type="text"] {
    height:30px;
    line-height:30px;
    padding:0 10px;
    margin:0;
    border:1px solid #bbb;
    background:#fcfcfc;
    }
    
    #order .page-body .table-order-info .order-table td input[type="radio"] {
    vertical-align:middle;
    margin:-2px 3px 0 0;
    }
    
    #order .page-body .table-order-info .order-table td .receiver_zip input {
    width:60px;
    height:30px;
    line-height:30px;
    padding:0 10px;
    margin:0;
    border:1px solid #bbb;
    background:#f0f0f0;
    }
    
    #order .page-body .table-order-info .order-table td .receiver_zip a {
    display:inline-block;
    width:100px;
    height:32px;
    line-height:3.0;
    text-align:center;
    color:#fff;
    margin:0 0 0 5px;
    background:#555;
    }
    
    #order .page-body .table-order-info .order-table td .receiver_zip2 input[type="text"] {
    margin:0 10px 0 0;
    width: 914px;
    }
    
    #order .page-body .table-order-info .order-table td .txt-input2 {
    margin:0 10px 0 0;
    }
    
    #order .page-body .table-order-info .order-table td .refer_box {
    line-height:18px;
    font-size:11px;
    color:#888;
    margin:20px 0 0;
    }
    
    #order .page-body .table-order-info .order-table td .refer_box2 {
    line-height:18px;
    font-size:11px;
    color:#4e6ccd;
    margin:10px 0 0;
    }
    
    #order .page-body .table-order-info .order-table td textarea {
    width: 914px;
    resize:none;
    padding:10px;
    }
    
    #order .page-body .table-order-info .new-privercy-contract {
    padding:0;
    }
    
    #order .page-body .table-order-info .new-privercy-contract p {
    font-weight:bold;
    text-align:left;
    margin:8px 0 10px;
    }
    
    #order .page-body .table-order-info .new-privercy-contract .MS_textarea {
    height:150px;
    }
    
    
    #order .page-body .opt_cube {
    display:block;
    border:1px solid #8d8d8d;
    border-top:2px solid #333;
    }
    
    #order .page-body .opt_cube table tr th {
    height:50px;
    line-height:50px;
    border-right:1px solid #ddd;
    border-bottom:1px solid #dedfe2;
    background:#f7f8fc;
    }
    
    #order .page-body .opt_cube table tr td {
    height:180px;
    vertical-align:top;
    padding:10px;
    border-right:1px solid #ddd;
    }
    
    #order .page-body .opt_cube table tr td.not_login {
    text-align:center;
    letter-spacing:-1px;
    vertical-align:middle;
    background:#e9edf6;
    }
    
    #order .page-body .opt_cube table tr td.not_optcon {
    text-align:center;
    letter-spacing:-1px;
    vertical-align:middle;
    background:#e9edf6;
    }
    
    #order .cnt-box {
    overflow:hidden;
    zoom:1;
    }
    
    #order .cnt-box img {
    vertical-align: middle;
    }
    
    #order .cnt-box .box_top {
    position:relative;
    height:126px;
    background:url("data:image/gif;base64,R0lGODlhGAF0APcAAPr6+t3d3eDg4Ozs7Ovr6+Hh4fb29uLi4unp6erq6ubm5uPj48jIyOTk5Ojo6OXl5efn5+zs6+zr7M7Ozuvs7OHg4ODg4eHg4ejn59jY2Orq6+Li4eHh4Ovq6+Lh4uDh4eHi4evr6uHi4uzr6+Lj4tXV1evq6uDh4Ovs6+nq6uvr7NnZ2eHh4tHR0d/f3+Tj5Orp6uXm5ebl5efn6OLj4+Pi4+Pi4unq6err6uLh4fPz8+Pj4ujo6ejp6OTl5eXk5err6+rp6eTk5efo6Orq6ebn5+Tk49PT0+Li4+np6ufm5+/v79ra2tfX19zc3Ofm5ujn6OPj5Ojo5+fn5uXl5uTj4+bm5enp6OTl5OXk5OXl5OPk4+no6eno6Pn5+dvb2+jp6d7e3u7u7uPk5NbW1ubn5uXm5ufo59LS0tTU1NDQ0Obm5+bl5v79/v7+/f3+/vT09PX19c/Pz/f399/g4MrKyvLy8tjY19XV1N7e3djX193d3N7f3trZ2uDg39bV1dva2t/e397d3trb29na2tbV1tDP0N/f3tra2dvc3Pz8/P7////+/////v7+///+/v7//vv7+/39/f7+/v///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAAGAF0AAAI/wApCRxIsKDBgwgTIpzEUCDDhxAjSpxIsaLFixgzatzIsSNGhw0VihxJsqTJkyY9qlzJsqXLlzBRypxJs+bBSSBhTpLEs6fPn0CDCh1KtKjRo0iT8tQZEqfNp1CjUsKJURLDnkyzat26FevOj06lih0rkqpFqzutKl3Ltq3bt3DXpr16cSrZu3hzVozLt6/fv4CLfsxLOOrepUgVKQ7MuLFjoYoVIU2LdmLhyzTNQiwaubPnz6BDix5NurTp06hTq+4sOKJdzLBHXgRqOtLnSLhz697Nu7fv38CDCx9OvDju26aB1o3N/GbEoLeNS59Ovbr169c/B5XYvLvezbQj2//uDQB3+UgA0qfHzr69e/bq16M331uR7cjbLXtn/vynZ/LxBSjggAQWaOCBCCao4IIMNijfbp4pB9F+zUnkX2QGiAHBAWEE4OGHIIYo4ogklmjiiSimqOKKLLYYYhgHQCCGAaz5xB2FmE3kU2RzDFDAADp4ERaORBaJ0iRe6ODjAHPg55VrRuL1HGWR6aCAGABEqeWWJwEghgI6OKkWlFw+1VB/PFXZABxltukmQnA0EOZiT5455JspoZmmInMowCaegL4JhwJNSmYjmYGWZGFPkQ0gRqKQlinGAGJW9lCkJGl21Z6KGFBAlpiGSiQABdBIp6VUiVpWf5FNquqr+zn/6uSNsDr30I72QaBDrbzCpgME9x16aa8D6akYbgd4QeyyeHlxwHGGLjUhs2iKF8adzGZr0yRh3Bctor0uKsmxkQSg7blRBQBtnSEte+uOuZmL7rw0qXvcT8O6C9649uEmL70Am2RvsNLmy6uO/MYb8MIkDUynfsS+u6d5/zJssUEBnHdqZdnumzB6FV8sMiUZr1sntRJ/DEDII1tcMsEFY/uquMemF8AilEDySCONOEJJI4w08sgikDiyyCKOPOIzJIwYnXTOkOBMSdOPCLTII1H3jDVOjEzS9NVM94zz0T8zItDWjBQ9CdNf7wz01FcT/cjOAhndyCJrM1I1QzpD/wK0I47wnPbekwB99eCOQDIJ3nfjDPgjkzx999yL4xz0Io34PXfRkFAydOCNMDQ33YsEnXF5p9JaK839royzzjz7DLTQRBuNtNI5f/00JFELRLXVWGOetOJTe2001kEbTQnZb3uueNqO5N224HAPrTPdlNiNN9OE9/036INPVTgjh+uc+OKFk/145FVPDjnZl2cuNNaJe440z6LP3cjypmv8Lbgzq1brbpYzt8kuaNazXdKWpruq8U5qv1te8LRGvK61LWzKY57ZnOc1tbHteNQjn/X0VzfMbU9v4vNe08CnM/EZ7hGIUxzj1Jc09v3sau+z3N3kt7n6fQ5/kxjd/v9K14iXpQ6AqmIdelxXwNiVjXZFO9oCc+c0B/Zuak+TYNaGxzXjgS15Y8NZ89DmQUZM720ilBv2tJe37mHte4JrIUNeGEP0NS57NZQcDis3tR1qjn6d+2HogkhCIp4OZqqD1aLIBbLXGfCJCZQi7phWRahBMItgE97WindBMC5PjBskY/Q+eLUQxu16+8ueCduYwjeuMI6Eo6P5ZJg+x+WxfXuEnx/nxzn7gS5/pOtfbh6GxCSCRzyNbGLPIFk7STKwkg/0HSYnyEVOHg+DYSzb2Z5XxjOaLY2oLOHdWMk3VwIOli4UYR1naEvI6ZFyusTcH3spSGAOUZjeipnMAvj/LvHYzJFOnF0kb/fM21lSmlXToiYr6EXkie2T2uQg9KQHQjSekoSqHCf3Wum3VwJNjuMrn9Joecf1vTOHfZQnL314v0EKkX9FXM+spnUw8UmsZkyE3TIF2kyCUtGg0cRiQjNJwS528qEa3GYHR2nGin7zomtc5UbL2dFzfjSW6pylHWnoTlzCU4cq7WEgW2pPmB7yiJfaZ6Q0RSX7/FOZB4SiAifZwIMKFXhb3KQFr+nJpEq0m06tnhpTycaprs2cLMSqSM/HTjx29YZfTSkPAelLIL7UkDL9X1oPpsS36jSuA50iJYF6xQgStZp7/SJSQanUiZLSbU8dYVQ1ikKq/8LxqulcLEm5akP38TF+82TpLwkZzJiiTrM05ee+cErAzzIzij4d7e5KO828MvSoGWTtX5nqTcGGM6MndGNVE5tbGGq1sSb1KkqBu9KxDvey/Tsuu9ql3K8wKjcrMxvvFGc3BNbOaXfz2dGelzO8YXF4PVubgKHnkE+uDW5mm93sOAi4rnmuaTo1Y/ZGilGc7G9rQ4sc7W6buACPbyqjDHH0pLa84QWOaJgLHQT9xju5pg9wilub19JGtJy9zDZYQRVnb0Ul/AZgcEgDnIfZNsjlRW1p8ksazobWtasVDn1mLN3UJEi2B6YtwpDzWua2Bjjf6XRnVfOZ0jSMNVTODv9vaNOw8DIn4icfNmfDs14QYxzgzCWOaDSmsnnb/D613Y18DAnajhcXNUj8+FtCXt1mikwxJAMuej9jckNgDGW/Sdl+VYacjHesZbPF7XVR+/LPwhy0vkXOZ1M7s9Cy5zlHsJl3+ntzEJ8n557ROXB2bmHRsKbnofGsz5wD9JhLN2hcMzp6h8abmBcNY0efB8iIKeZaJ33fSussyZjOnBmbzOmcRXlooF6cqLFMvm9yGdWlY9qqEz1m/sJ6cDxDM63XbDZCw3accTa1r/mbOaTdedjfVpyxeXa/ZNf423obnLNrlz5ET9uMjCbao4OsbUhNqdsgs7SSMz3uTT/Z3J7/RjeV1X1lvGXZ3ae2pKqFRm9XlznWbtO3mm3db1z/G868Fjiw62xwYeeZaHs+dsP//HBBS1xnz664tBWN8WpvPNvJNSaRQZ7fb196ySXHSblprLUpl47lo375lmPuZXnTXMw2v7es01zrW7v5crvesdB/XfAU45nYSF84spkeaGY/vdDQLt3UQ1f1Rl99TFkX1cfTZGSRh1vTYj852T+9ciunvd1rHxq8Z87qer/azDmf9c7tnmu8B3x5Aye63xFebD4vvdGFj3jfoE7xaNOb2o6/NqQ7nqjJj6vyXh+5uBWdeaShvOzp9jy7S/1umbu99HFHfb5VX/ee3x3gQYf9/9CBXXQHHl3htgc24Zete0JH3fcXr3Lwh8nxyIfK+P0KefIvH3YnO3/zKnd20udyoGdqomd9YFZzZCZ3qUd3/OY83wd0eid+fBds5gd46Kd06od77NdsvGdoivd7jadxwld/BqN1dMF1R7Z/YMd8/tdp0Nd560aA1Md2qXZ9Cmhv2ic03PeA/iY44DeBc0ZwFvh3CZd0DLeBygZxHoh4UieC8keC9Id1Jyh53EZ53vY5yod5L/h8nCeAM0hqMHeAbZeAcLeAO6hz3QeBrReEZrR3RFh+Rlh7GuhnHMiEh/d+IRh/GWdtUwh5VXh/V3h8WQhuLUhumnduZhdqLSeGof/XZTdohq2Ghji3fQ7Ic2z4c3n3hhQYh7N3fkg4eHfodLvnhPBHdVHoh/dChfSFgvaFhSHnNUkWOoETOeO2MzVma34TO07hToxWOJ8zUlsGeGDTYkwWZhzUOUWzP2kDjM2IN1eTNKbmc1rjED2mYU3jR9FDPkfDNwEWQzAUOPrTaBMVPAWkNC5mO824OC7YOEpGP4/3FfaHKfhnZAQIZrXIc8emcFMxNyDxM1NxShGWPYMkUEH0OPvDWOSjNrH2YJnTOXZkRjK0jIEzjTozUZaDObVWa9oYjjnDN53Tb6MENCAWPF7jNZSzNAeZjYBTPsO2ah/2kRHnNfEYaYo0iPn/5zoTKDT5OG48w4+E9I/7o25EM5C1OD40h450o5AU15Cd85ABOT7PSJFvA2jmtWJw82E715FN85FrE5K1tjYkqXAmaUEp+ZFrFjgtaV4vyYOeI5MwRJMlyIpq5XE4aY87qTS06JN0tjf+KD4ASZRuR5BzhEAHmTQJKUMLiWnN+JS8E5VAM5VqWZW4hpFZuZF6KU/SqJJfOYwjqTdkGTUnqTfuhJa2ppbHkzZtSTcOhJIWVJPEFyj1SDH3uGo9GTQ/GUT9mFANMZQCCZBHaZBKmZjs2JSNmWkQyTgS+Wy+ZpFXuTiXiTuZ6WcemWOPKZJiCZqEJJpmWZoKd5o9k5q8/yM5rAmXrzmXgNiKVrh1sKiTnMiTe4mbfbmbQhmQ1mOUBWmYw5k9immciuOYySmVEzmZzmmZ5KOVHKmZ1QmSnpmdJcmdKOmdK4maLkmeMfk8cckIsDmP28aehNhIeXmb+6ibQQmYvnmfwJmfSYmQ/FmcDHmcUBmRktmcTnaRapORCDqdw9aV1gmWSuOgoelyERo5psmS4rmaF+qacvmH8hiI9HiXtBmi8TmifsmbHmafRZmihbmiiNmiivei/4mckLmctUOjVmmgGimdL0adPMqg2NlRDyqkpEmk32mkFdo+5Ymh58mkNllfatGeNyOltiifQPmXvYmlgxmc+smiTP8Jpg75mDI6oGZamTcanVupoG3amW86ltspp2dZpxTKlhb6lnq6pKuYnnVZfFAKou+pl4NKpfRpooiKn1sKOfvZqIwZpjGqnDNakTX6nDiKmWu6o5x5nWEJp0E6mp86oeF5pzBJqkqqoejZpOopiB6ak4HaqiKam1Van4JJq0hpq4zan44KoGPaq5Rpo1h5oMLKlcXqo58Zp8oqoWnZrKKKp0k6k9LKp7EJKLPJqhoGn6/KrbF6qN+qpeF6mEtJrrn6qAEamZLqq2daqeyqpu7qlcb6o8jaqfNKp8y6lqo5qq2prxvqpB2agoDqN3vWNJHzQDyJE+gYO/amcHzjOYX/4zk9A3VB9JVCCjQnGT1KUzVtZmF4hhOJt5BX5k564zU2m2R+wzhQp5pSVDlXNp8QUTTRY2sfibNz0zXbiBNRlGDog3RMWzlGozaFozi+VrLV+qTXamQ0dmW8IzprgzQLyV+4Jj4rdjt8M2Dfppe8s0JEk0o5xhDx9mShg7Vdw2oHRD8PYTRw52Lo+I4DprWP66p0K41SlLPswzZ4+1EWFzlgA7RKZmBiaTRdA3WnuV9sm6qyuar5FWYHObcyFGaFez62ZrhnMkpO8xAaS2eRo2CQ0zW+CzkK9595FLy+WItqo5qjc1jomHEIJm6Mlrp+Bowr1kFX242vxhBKVmOJ/3tYnXNhzvc+O3u1C4R0i9C6Q4ayH7oyldNViUYVPqtjP4pjohe8NJu1UhZi2EezlMNytNQ0S0tc58M3dHuSLStt+LNKKQYRegO04ns9gEu8DwF143ll9ps9GrxrtgvB6BM9MKs5q7s47Ctpb0sxEXG8oiO1LRy8X7tf3ruzxNtCIoy2ynvAOtszVLPCX6djNOds7CPCFwyfW2MWoeNvNBtEWgMRYSZqB5zAePvEQCu7ECFtCOe7opNjJ3yTKQwyxrtnEXG/WavFV2zFj0vE54s+aJu7+ZPAl5tj0rY5hJQ4iyvCpKnGETFma2zFBrfFOTye97s9vpg/RPyf/4nAFv8cvIsjwYmDY47QxX5KaSDTx4TEyA9hQY+LwEccESKcnzOsvzM8SmqTNE+sY6jMOTqWY2UsbU78uNa5ygh8wai8wmu8PhAhwTtbuD7MN0q2y3n3o3M0CZLsin/6vgHAy56swzVEy5krEXp8yGb8xCx8wYtbEcocZno8N3rMyGhcy93su8rMEdJcTrlsEYdczOvpvth6EeWsEuPcEWg8zrIbzlwxy5tcEVEcz/hMEfYsEepsrexsZBPRBvfMEG/gEW4AEW2Q0BCx0BQB0ZNg0B0h0QxB0Q/h0A+B0RCh0RqB0R7NEBYdESNNzNPap664KQljMy7S0i790jAd0zI90yP/klnz5br+2lkA4AQG0NM+/dNAHdRCPdREXdRGfdRIndRKvdRM3dRC7QQ2rU9tu1Y2pdI45QQDkNVavdVcrdUR0NVgHdZiPdZkXdZmfdZondZqvdZaDdXypU+voUhV3VZL9AUDEAESMAAoMAASgAISEAFfjdcUEAGDLQGG/dVZTQF/DdgDMAJfTQEj4NWNndcSQAEUoAKQrQJ5rQKBrQJZ3dcEENiJ7dmE7dkDENp37dUUwNd8ndeEbdmXndWPHQGYLdt+/dmrLduAHQF7fdeIvdp43duiPdjA/duB/defPQDAzdqf3deRndu+/dVfENVChtOv2084xQQE4NcjcNsE/xDaXy0BKkAAlf3dnj0CoT0C3f3dKDDeKqACKIACij0C440CBEDfnC3f6t3e5H3fIyAB/k0AFPDdAz7g2+3XA37afs3f7w3g6k0BKBABBNDYli0B6P3e6l3e3/3deS3gd40C/33ZA07Ypy3ekT0AKjACA27f9o3e/53fFn7X903Y4j3e/e3X5A3h8A3hEi7gBMAEmWUo/WqX2N062r3hSJ7kSr7kIbDkTv7kSN4BUD7lVF7lSS7lVp7lWr7lBIDlGw7k0CLkHCrQm8JIALACQJAACRACCSDlbR4COKABJkAAIQAEQNDkGhACcK4BBKABUu7mUt7kBKDmBGACeh4CGv/g50DQAXZ+59/dAThw501uAibQ5iYABARg5wnQ5R3QAXreASbA6IGOA3EO6Yau55iO6N/N5nGO6Z6+4XUeAh0g54Nu537O6ThQ6bP+5yFg6ASQ61KuAQlA6Xxu6LNuAsKu5nO+6aQO55me6J2+64iuAUAQ6isgfGI+5idr1W4FABmg5uCe6OCeADgw7uY+7OMu7MjO5sme7pV+7vDe7vA+7+Ve7uZe6fau5sku5/D+7vmu5mke7so+8OmeAPJO7mpe7pWe5wmv7+T+7u9+7wIP7hGfAdSdSPVF1+iRAUEQBCkQBEkAA0mQAjeAAEQQ8gmQBEmAADcAA0SQADAAAwn/0PIpAAM3kAIIUPNEcPIJQPI6r+YeL/Mw//MfnwJJkABEkAIpTwQwkPNK7/EIEAQlnwIk3/JMr+Y5D/RB4PIznwAsfwNI//VeD/Y5z/IrDwNKH/MlTwQ34PEJ0PFHD/Jb//FbfwMnv/M4f/M3kAQgn/U3j/YpwPYgP/I7H/NeTwRRHwRqrvIWbzKoYt05vVyt0wQIUPmWf/mW3wArMAGcvwINYPkK8AVqwPklIACV7wJHMAErgACbvwIKsPmkXwGWLwAlwPlq8AUOUPmbfwQugACvr/qYH/zCP/zEX/zGf/zIn/zK3wT+M18RI0BLRAZcwANggABX4ABgwAMI4ABc/8AFgFACAzAQA1ACq88HR4AAiiAQOpABK8ADR2AAlNACW5ABlIAAg6AAA6EDJRAGDgAQK1zooERJkYISArZkoGTgCBQmCCi5oHOlCxgwXa6AueKgB48eXbj06OHg4hUePEbyEDmyC0kwDnh4dCATwRUEPHJy8YigS86bXRyA+TgzJMuSSblcCSlzJBeQV1DOZLlU6lAwUGvGTNrzChkAACIpUiTJ7CS0aQuuZdvW7Vu4ceXOhZt2klmzZCNFAlCiJpSagQM7yaDIrQsXLQwcZnJkcQsaDBEwUcDW4YrKbXWU2MGQkoIVESe6kDLEdOAZGAAPqclaSuDTZ2Y4OC1YsP8UKRhgO4AC5TVvwDXP/H6t2zZtKKyPO3jNGnDp38qDF2cuuLeDEmLHlsVrl+538OHFs7WLV5JevmlmnIHQHgMGCDOGQGnhhdKSFhMmIPBSgswSSjbTTyJFWnCMkhYOkIyyzyZYrATPFNAvg8Um84wSJ0RDDIMh3INPNgxSm6G93OCDL74Q24NgCBPjg0AKCEB8D77UIAgRChtlszHEEWE8w8QZRjxxxiFqxBGKFGOkUUUbXVzSgR+ZTEM7sszzbjwss9QyLfPQA+CIIiAIEwIlwlTiCScOuI8MCxRogJAWEimBEi9acKEIIzKQSIEDWwBhwcokfHCAzzKw4okAWiD/Sw2G7KtTIhcCKWMNCNYoYo0ppihCgTNVfAICTYvI9IkpziyjvU/LTFXFMp7otNRLyfy0DFFbVaJMSkUtsz0zlVij0yJIVQICTj+F4FMFpmivDGZFrVQBWkFNtohhj6CSu7PQ0nJbbueyi8vzFNkrEjQUMPdcdL8IVF10C2BoCTLODcMFShDo0916MbPsCAAzKODcPt+tbABIw0D3YIQTVnhhhht2+GGIGUZj3Col+VbbbjPW+Fu80CP3ARkesCKGB6gQmYo016TDDBJWaOGLOesM44ED9NizTxecyDezAEu4g1AF7vDhAScUVYTR+w60zwVBHoghZJHNcJoNKkim/0IBGcyIwQypqbBCBiqqfkDrpx9ggw0FxpbBCq+dliGGGKwAWYa0vzYZ7LXfhtuMtx94QAEq1o7B5LSzFjkGNmRA++m3wYabDbkZ15vtkCfeq2KLr9R4c27B7XjcFrDQQgu/fyjdb0MMw2/AOgsBUIcMBjSohDQIOmC/nRtMIw8BIpxwsQGaeJeMEgybKIAHhn4Ai+R9EKJ000Uf+gflqafeb+wfyOKH5x/ofnTTvfdh6KG7x94H0kVP/gEtpg//B9O1aCB77knH/ocskteCeuWFaN/+8AnBBy2gmHkyNwnOJXBLHMuLuCKhhgYIAQsNwIIPKNgADArkLS5I1GLaAv8aBrElQ4FiAgYb0ASercUALejdff6wAjUdz4QTNKEJhYDBCdKwAVm4YQ0v6IMsYDCIN5xgEH04PyM24AcRTKIQI/jEHTqxhzXUIQaFcEPuNVGCTVSiCdVwOWxdTIFjFA8DwyWuBL3ACFuIQhUaYIQxjMEIJ8wAgAqyhAw04QVfQINECgK7JizABigsiCIO0IQ+BAoRGHwBCZowkEIqAA1foMO7StCA2k1kDy+owgvG8II3boGNL9hCFYxwyjG8MQoYNMIC2JhKNZoQjkZ4QRsbsIA4RgGULyBlFRZQy10awZQNKCUoo7CAKlRhlaaspTIX8Ew3LoCYW1hjA8YQBV3/8lKXRsDmGDq5Rk7ykgQEJEsYNUdGdMbFjOHaS0Ke+U54PnMHYSiBfiZQgjC8UwBNsGcanPDOQ+pHDhlYQECbcIB4OiENAs0AQhfAT3wuQKETCGQ8LXpRjGYUnjvQaEefSQONgtSjI72oAEoARiudM50rJU95OiauAHzhAAfYARJqsAAkIOEAJKgBR2tQAxIcoAY2JQENDkADG5CgpgugAQl4ylFB2vSmQN3pDpBKAyTYwAY0MKpQD4AEGuxgqwdI6lGN+tSbFpQESBCrUHewAxKoNa472ClNd1rQs860BiD96UzhmtSC2gAJURUqUr9KAhvQ1Ko7bWpWdQrStSa1/6mI/SpSd/DTgtJVqwuoaVZ3aoOffiEA20mpWlh62rZcrIGKgEAJZvpaEbz2ALE9wAZEsIENvDa3M/XABjwgW+Dedrev/W1tgwvc4c7WuLcF7kxpG9vivpYF0WWuc2VLW+M2N7vR/e1usTvb78rWA73N7kynq9sDeCAH6T0udUVQAgiUM1sqRe1KEWjGcurgCC4owHhzIIIcrBcEB+jvAUAAgvGCoAAG9gALcttbBU9XBAWYbg5YkIMFb6AACsawhjdwYBFc2AMbJvBt/wtg22oYBCwAQQ48cOAC/HcDLJjuil384hyAmMIbLgCFjcuCA0yXxOsF8gYwLIIVs2DDFv/OMY8R/GEM17jBIMAtjSnsYtxqWAQiaHCPJ6xgMNeWxUr2wCGOoAP5zldbCKzvaVX7UkUsgAw9pnOd7XxnPOdZz3vmc59j7GdA81nJgSZ0ofFMhgWkWc0YazNL3/zSOKxgBQX4wAdO0OMKFIADBajABTZ9AQFwYNOU/gClCyCACxTgAhYQAKU5YAFKXwDUFTiBACrQ6QuU2tIfqIAFQG2BTnOg0qGms6wv0GtbcyDVvLYArDPNa2Ef29Ow5sCzle3pSws71q0WdqZf3exR9zrTx850sint62LL+gMC+ICy122BE5wA1KfWdra9rW5hn0DSccDcotnc6HSu2aWrXUL/CVZQAQEkPOEcSDirG45whFu62axmeLxtffFbs/oCJ4D3xTeOaoWvO9QfALYALPBtAdS61rd+9ak9rfBqvxrhHMc1sJVdAV7XuuEMXzfDU55yDtQa1Am3NMJNzmqd+zrhKu840RHucGWn3OKrDrnCOW7yhK+gBEtQ9AEFDnA3l+cuqxVDBvAQAIWnXe1rZ3vb3f52uMdd7nOne93tXvcAQEgMir7Lt8Be34uNfbVxKIAc0JABJ7hA7X64e+Md/3jIR17yas9ZBtAghwLwu9+B/zvg13lGRdjhAUxQQx0YcHrUp171q2d9613/etjHXvazp33tba/6OqiBCQ+wQzmx/+Xvzrf586B34Lj2EhbkJ1/5y2d+853/fOhHX/rTp371qW98ivnegF7/d/DtG/jtg34s2D9++fmSfPKnX/3rZ3/73f9++Mdf/udHvvm1g31xaX/7ge++9wM+fOIrvvkbQAIsQAM8QAR8P9/rt+7wO/9DLf7zHDhbwAXcDt9LQAzMQA0sQAq0QArUv9LivwcEPEp4tPALwA9MQRVcQRZsQRd8QRiMQRmMwRNsQO/ovxF0NP7rjho0oK7rQSAMQiEcQiIsQiM8wh+sQcGLwBwEuAiUwCOMQimcQiqsQisUwidktCYkwSzMnLO4QjAMQzEcQyIcO7TgPjHCwS10sxLswkoz9LcsjEM5nEM6rEM7vEM89JwzjMMSXMO/Y7M83EEyHERCFMNA5Lw+9EP/O0RGbERHfERIdERF3ELTikRLvERMzMQ5LAjTasKAAAA7") no-repeat;
    }
    
    #order .cnt-box .box_top .MS_input_txt {
    position:absolute;
    top:30px;
    left: 39%;
    width:126px;
    height:23px;
    line-height:23px;
    text-align:center;
    margin:0 0 0 -66px;
    border:2px solid #434759;
    }
    
    #order .cnt-box .box_top a {
    position:absolute;
    bottom:28px;
    right:60px;
    z-index:10;
    display:block;
    width:54px;
    height:18px;
    background:url("data:image/gif;base64,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") no-repeat;
    }
    
    #order .cnt-box .box_bottom {
    letter-spacing:-1px;
    text-align:center;
    color:#555;
    margin:8px 0 0;
    }
    
    #order .cnt-box .cash_top_box  ul li {
    text-align:center;
    }
    
    #order .cnt-box .cash_top_box  ul li.tit {
    height:30px;
    line-height:30px;
    font-size:12px;
    font-weight:bold;
    letter-spacing:-1px;
    color:#555;
    }
    
    #order .cnt-box .cash_top_box  ul li.txt {
    margin:0 0 10px;
    }
    
    #order .cnt-box .cash_body_box {
    padding:10px;
    border-top:1px solid #dfdee3;
    border-bottom:1px solid #dfdee3;
    background:#e9edf6;
    }
    
    #order .cnt-box .cash_body_box dl dt {
    float:left;
    width:110px;
    height:27px;
    line-height:27px;
    font-size:11px;
    letter-spacing:-1px;
    text-align:left;
    color:#4d4d4d;
    }
    
    #order .cnt-box .cash_body_box dl dd {
    float:left;
    width:147px;
    text-align:right;
    padding:3px 0;
    }
    
    #order .cnt-box .cash_body_box dl dd input {
    padding:0 5px;
    }
    
    #order .cnt-box .cash_bottom_box {
    letter-spacing:-1px;
    color:#555;
    margin:15px 0 0;
    }
    
    #MSecure_layer1 {
    display:none !important;
    }
    
    
    
    .table-cart tbody td .thumb img {
    display:block;
    width:80px;
    height:auto;
    }
    
    .table-cart tfoot strong {
    color:#e71818;
    }
    
    #order .page-body h3.stit {
    display:inline-block;
    *display:inline;
    zoom:1;
    }
    
    #order .page-body .table-bank-info {
    display:inline-block;
    zoom:1;
    margin:0 0 20px;
    border:1px solid #333;
    }
    
    #order .page-body .table-bank-info .bank-table th {
    font-size:14px;
    font-weight:bold;
    color:#333;
    text-align:center;
    padding:0 10px;
    border-right:1px solid #ccc;
    }
    
    #order .page-body .table-bank-info .bank-table td {
    padding:35px 10px 35px 20px;
    }
    
    .admin-msg {
    *display:inline-block;
    padding:30px 0;
    border:1px solid #ccc;
    background:#f5f5f5;
    }
    
    #order .btn-foot {
    margin-top:40px;
    text-align:center;
    font-size:0;
    line-height:0;
    }
    
    #order .btn-foot a {
    margin:0 3px;
    }
    
    #order select{
    height: 30px;
    line-height: 30px;
    }
    
    
    #order .table-order-info.table-orderend tbody th, #order .table-order-info.table-orderend tbody td{
    padding: 0;
    }




#order h2.tit-page {
    position: relative;
    padding: 0 0 11px;
    margin: 40px 0 30px;
    border-bottom: none;
}

.table-cart {
    margin-bottom: 0px;
    border-bottom: 1px solid #B7B7B7;
    margin-top: 10px;
}

.table-cart {
    margin: 0 0 20px;
    border-top: 1px solid #898989;
}

 .table-cart {margin-bottom :0px; border-bottom: 1px solid #B7B7B7; margin-top:10px; }
 
 .table-cart thead th {
    height: 32px;
    color: #333;
    font-weight: normal;
    border-right: 1px solid #ddd;
    box-shadow: inset 1px 1px rgb(255 255 255 / 10%), inset -1px -1px rgb(255 255 255 / 10%);
    -webkit-box-shadow: inset 1px 1px rgb(255 255 255 / 10%), inset -1px -1px rgb(255 255 255 / 10%);
    padding: 0px;
    background-color: initial;
}

 table {
    width: 100%;
    border-collapse: collapse;
    border-spacing: 0;
    table-layout: fixed;
    word-wrap: break-word;
    word-break: keep-all;
 }

 
.table-cart thead {
    width: 100%;
    background: url(http://www.whosbag.com/design/whosbag/smartpc/defalut_img/board_head.gif) repeat-x;
}
.table-cart tbody tr.nbg td {
  background-image: none;
}

.table-cart tbody td .thumb {
    width: 80px;
    height: auto;
    margin-left: auto;
    margin-right: auto;
    font-size: 0;
    line-height: 0;
    border: 2px solid #f6f6f6;
}

.table-cart tbody td .thumb img {
    display: block;
    width: 80px;
    height: auto;
}

.table-cart tbody td.goods_opt {
    vertical-align: top;
    padding: 15px 20px 15px 10px;
}

.b {
    font-weight: bold;
}

.txt_l {
    text-align: left;
}

.txt_c {
    text-align: center;
}

.txt_r {
    text-align: right;
}

.table-cart tbody td.goods_opt .goods_title {
    margin: 0 0 10px;
}

a {
    color: #262626;
    text-decoration: none !important;
}

.table-cart tbody td.goods_opt .uni-opt {
    padding: 10px 0;
    border-top: 1px dotted #c0c0c0;
}

table img {
    vertical-align: middle;
}

.table-cart tfoot {
    background: none;
}

.table-cart tfoot tr td {
    padding: 0;
    border-top: 1px solid #d8d8d8;
}

.table-cart tfoot tr td .total_payment {
    font-weight: normal;
    color: #666;
    padding: 15px 10px;
    background: #f9f9f9;
}

.fc_gray8 {
    color: #888;
}

.fs_16 {
    font-size: 16px;
}

.fc_red {
    color: #e71818;
}

.table-cart tfoot tr td .total_payment .sign_ico {
    margin: 0 10px 0;
}

fieldset, img {
    border: 0 none;
}

hr, caption, legend {
    display: none;
}

#order .page-body .table-order-info {
    display: inline-block;
    *display: inline;
    zoom: 1;
    padding: 0 20px 15px;
    margin: 50px 0 20px;
    border: none;
    border: 1px solid #dedede;
    background: #f2f2f2;
}

#order .page-body h3.stit {
    display: inline-block;
    /* display: inline; */
    zoom: 1;
    position: relative;
    height: 40px;
    line-height: 40px;
    margin: 0;
}

#order .page-body h3.stit img {
    vertical-align: middle;
    margin: -42px 0 0;
}

#order .stit img {
    float: left;
}

#order .stit:after {
    content: "";
    display: block;
    clear: both;
}

#order .page-body .table-order-info .order-table {
    border: none;
}

#order .page-body .table-order-info .order-table .sub_title_txt {
    position: relative;
    color: #333;
    border-bottom: 1px solid #ddd;
}

#order .page-body .table-order-info .order-table th {
    color: #333;
    vertical-align: top;
    background: none;
}

#order .page-body .table-order-info .order-table th div {
    padding: 10px 10px 10px 0;
}

.table-order-info tbody th, .table-order-info tbody td {
    padding: 8px 0 7px;
    background: url(/images/d3/modern_simple/common/dot_h1_w10.gif) repeat-x 0 0;
}

#order .page-body .table-order-info .order-table td input[type="text"] {
    height: 30px;
    line-height: 30px;
    padding: 0 10px;
    margin: 0;
    border: 1px solid #bbb;
    background: #fcfcfc;
}

#order .page-body .width180 {
    width: 180px;
}

#order .page-body .table-order-info .order-table td .ml_10 {
    margin: 0 0 0 10px;
}

.fc_gray8 {
    color: #888;
}

.fs_11 {
    font-size: 11px;
}

#order select {
    height: 30px;
    line-height: 30px;
}

#order .page-body .width80 {
    width: 80px;
}

#order .page-body .table-order-info .order-table td .refer_box {
    line-height: 18px;
    font-size: 11px;
    color: #888;
    margin: 20px 0 0;
}

/* 배송지 입력 */
#order .page-body .table-order-info .order-table .sub_title_txt .same_data {
    position: absolute;
    top: 10px;
    right: 0;
}

dl, ul, ol, menu, li {
    list-style: none;
    padding:0;
}

#order .table-order-info li {
    padding: 3px 0;
}

#order .table-order-info li {
    display: block;
    text-align: left;
    text-align: -webkit-left;
    font-size: 11px;
    color: #888;
    padding: 4px 0;
}

#order .page-body .table-order-info .order-table td .receiver_zip input {
    width: 60px;
    height: 30px;
    line-height: 30px;
    padding: 0 10px;
    margin: 0;
    border: 1px solid #bbb;
    background: #f0f0f0;
}

#order .page-body .table-order-info .order-table td .receiver_zip a {
    display: inline-block;
    width: 100px;
    height: 32px;
    line-height: 3.0;
    text-align: center;
    color: #fff;
    margin: 0 0 0 5px;
    background: #555;
}

#order .table-order-info li {
    padding: 3px 0;
}

#order .page-body .table-order-info .order-table td .receiver_zip2 input[type="text"] {
    margin: 0 10px 0 0;
    width: 914px;
}

#order .page-body .table-order-info .order-table td textarea {
    width: 914px;
    resize: none;
    padding: 10px;
}

#order .page-body .table-order-info .order-table td .refer_box2 {
    line-height: 18px;
    font-size: 11px;
    color: #4e6ccd;
    margin: 10px 0 0;
}

body, h1, h2, h3, h4, th, td, input, select, textarea, button {
    font-size: 12px;
    line-height: 1.5;
    font-family: '�뗭�',dotum,sans-serif;
    color: #333;
}

textarea {
    width: 600px;
    height: 47px;
    padding: 2px;
    border: 1px solid #EDEDED;
}

input, select, textarea, button {
    vertical-align: middle;
}

#order .page-body .table-order-info .new-privercy-contract {
    padding: 0;
}

#order .page-body .table-order-info .new-privercy-contract p {
    font-weight: bold;
    text-align: left;
    margin: 8px 0 10px;
}

.privercy-contract {
    clear: both;
}

#order .tbl {
    width: 100%;
    padding: 0;
    margin: 0;
    border-spacing: 0;
    border-collapse: collapse;
    border-top: 1px solid #dadada;
    border-left: 1px solid #dadada;
}

#order .tbl th, #order .tbl td {
    height: 32px;
    padding: 0;
    margin: 0;
    border-right: 1px solid #dadada;
    border-bottom: 1px solid #dadada;
    letter-spacing: -1px;
}

#order .tbl th {
    line-height: 32px;
    color: #3b3b3b;
    font-size: 12px;
    font-weight: bold;
    background: #f0f0f0;
    text-align: center;
}

#order .tbl td .txt-l {
    padding: 5px 0 3px 5px;
    margin: 0;
    text-align: left;
}

[class*="holding"] {
    font-weight: bold;
    font-size: 13px;
}

.privercy-agree {
    margin: 10px 0;
}

.privercy-agree label {
    margin-right: 10px;
}

#order .btn-foot {
    margin-top: 40px;
    text-align: center;
    font-size: 0;
    line-height: 0;
}
</style>
<body>
<hr>           
 <div id="content">
    <div id="order">
         <h2 class="tit-page">
             <img src="${contextPath }/resources/image/order_title.gif" alt="shopping cart" title="shopping cart">
         </h2>
     <div class="page-body">
                    
				<form name="order_form" id="order_form" action="${contextPath }/order/order.do" method="post">
                        <div class="table-cart table-order-prd">
                            <table summary="구입 상품명, 수량, 가격, 적립" class="order-table">
                                <caption>주문할 상품</caption>
                                <colgroup>
                                    <col width="100">
                                    <col width="*">
                                    <col width="100">
                                    <col width="100">
                                    <col width="100">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col" colspan="2">구입 상품명</th>
                                        <th scope="col">수량</th>
                                        <th scope="col">가격</th>
                                        <th scope="col" class="notborder_right">적립</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach var="product" items="${myProductList }"  varStatus="cnt">
                                	<c:set var="cart_goods_qty" value="${myCartList[cnt.count-1].cart_goods_qty}" />
				    				<c:set var="cart_no" value="${myCartList[cnt.count-1].cart_no}" />      	
                                     <tr class="nbg">
                                        <td class="notborder_right">
                                            <div class="thumb txt_c"><img src="${contextPath }/thumbnails.do?product_no=${product.product_no}&fileName=${product.product_image}" width="40"></div>
<%--                                             <div class="thumb txt_c"><img src="${contextPath }/resources/image/0270080002093.jpg" width="40"></div> --%>
                                        </td>
                                        <td class="goods_opt">
                                            <div class="txt_l">
												<div class="goods_title">
													<a href="">${product.product_name }</a>
<!-- 													<a href="/shop/shopdetail.html?branduid=1008946">샌더 라지 쇼퍼 <br> [2COLOR]</a> -->
												</div>
												<div class="uni-opt"><img src="${contextPath }/resources/image/opt_kor_ico.gif"> COLOR : ${product.product_color }</div>
											</div>
                                        </td>
                                        <td>
                                            <div class="txt_c">${cart_goods_qty }개</div>
<!--                                             <div class="txt_c">1개</div> -->
                                        </td>
                                        <td>
                                            <div class="txt_c b">
                                                ${product.sale_price }
                                            </div>
                                        </td>
                                        <td class="notborder_right">
                                            <div class="txt_c">없음</div>
                                        </td>
                                    </tr>
                                     <c:set  var="totalGoodsPrice" value="${totalGoodsPrice+product.sale_price *cart_goods_qty }" />
									 <c:set  var="totalGoodsNum" value="${totalGoodsNum+1 }" />
                                    </c:forEach> 
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="5">
                                        	<div class="total_payment txt_r" style="display:flex; justify-content:space-between;">
	                                        	<span>총 개수: ${amount }개</span>
	                                        	<input type="hidden" name="amount" value="${amount }" />
	                                            <div>
<!-- 	                                            <div class="total_payment txt_r"> -->
	                                                결제금액 :
	                                                <fmt:formatNumber  value="${totalGoodsPrice}" type="number" var="total_goods_price" />
	                                                <span class="fs_16 b fc_gray8 number_pst">${total_goods_price }원</span> 
	                                                <span class="sign_ico"><img src="${contextPath }/resources/image/equals_ico.gif" title="합계"></span> <span class="fs_16 b fc_red number_pst">${total_goods_price }원</span>
	<%--                                                 <span class="fs_16 b fc_gray8 number_pst">82,000</span>원 
	                                                <span class="sign_ico"><img src="${contextPath }/resources/image/equals_ico.gif" title="합계"></span> <span class="fs_16 b fc_red number_pst">82,000원</span> --%>
	                                            	<input type="hidden" name="totalGoodsPrice" value="${totalGoodsPrice}" />
	                                            </div>
                                        	</div>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div><!-- .table-order-prd -->
                                                   
    
                            <fieldset>
                                <legend>주문 폼</legend>
                                <%-- <div class="table-order-info table-user">
									<h3 class="stit">
										<img src="${contextPath }/resources/image/order_title01.gif">
									</h3>
									<!-- 주문자 정보는 비회원만 나오게 하기 -->
                                    <table summary="이름, E-mail, 연락처" class="order-table">
                                        <caption>주문자 정보</caption>
                                        <colgroup>
                                            <col width="150">
                                            <col width="*">
                                        </colgroup>
                                        <tbody>
											<tr class="nbg">
												<td class="sub_title_txt" colspan="2"><strong>*회원등급을 꼭 확인하세요~ 3만원이상 구매시 레이디5% 프린세스10% 퀸15% 자동 할인됩니다.</strong></td>
											</tr>
											<tr>
                                            </tr>
                                            <tr>
                                                <th scope="row"><div class="txt_l">이 름</div></th>
                                                <td>
                                                    <div>
                                                      <input type="text" name="sender" form="order_form" id="sender" class="MS_input_txt txt-input2 width180" value="">                                                    
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><div class="txt_l">E-mail</div></th>
                                                <td>
                                                    <div>
                                                      <input type="hidden" name="oldemail" id="oldemail">
												      <input type="hidden" name="email" id="email">
												      <input type="text" name="email1" id="email1" class="MS_input_txt" maxlength="20" form="order_form">
												      <span>@</span> 
												      <span id="direct_email" style="margin-top:3px;display:inline-block">
												        <input type="text" name="email3" id="email3" value="" class="MS_input_txt txt-input2 width180" maxlength="25" form="order_form">
												      </span>
												      <select name="emailsel" id="emailsel" class="MS_select MS_email" style="margin-right:5px;" onchange="viewdirect()">
												      	<option value="direct">직접입력</option>
												      	<option value="naver.com">naver.com</option>
												      	<option value="hotmail.com">hotmail.com</option>
												      	<option value="hanmail.net">hanmail.net</option>
												      	<option value="yahoo.com">yahoo.com</option>
												      	<option value="nate.com">nate.com</option>
												      	<option value="korea.com">korea.com</option>
												      	<option value="chol.com">chol.com</option>
												      	<option value="gmail.com">gmail.com</option>
												      	<option value="netian.com">netian.com</option>
												      </select>
													  <span class="fs_11 fc_gray8 ml_10"> - 본인이 사용하시는 e-mail을 적어주세요. 주문확인과 발송메일이 전달됩니다.</span>
                                                    </div>
                                                </td>
											</tr>
											<tr>
                                                <th scope="row"><div class="txt_l">연락처</div></th>
                                                <td>
                                                    <div>
                                                       <select name="emergency11" form="order_form" id="emergency11" class="MS_select MS_tel">
											                <option value="">선택</option>            
											                <option value="010">010</option>            
											                <option value="011">011</option>           
											                 <option value="016">016</option>            
											                 <option value="017">017</option>            
											                 <option value="018">018</option>            
											                 <option value="019">019</option>            
											                 <option value="02">02</option>            
											                 <option value="031">031</option>            
											                 <option value="032">032</option>            
											                 <option value="033">033</option>            
											                 <option value="041">041</option>            
											                 <option value="042">042</option>            
											                 <option value="043">043</option>            
											                 <option value="044">044</option>            
											                 <option value="051">051</option>            
											                 <option value="052">052</option>            
											                 <option value="053">053</option>            
											                 <option value="054">054</option>            
											                 <option value="055">055</option>            
											                 <option value="061">061</option>            
											                 <option value="062">062</option>            
											                 <option value="063">063</option>            
											                 <option value="064">064</option>            
											                 <option value="0502">0502</option>            
											                 <option value="0503">0503</option>            
											                 <option value="0504">0504</option>            
											                 <option value="0505">0505</option>            
											                 <option value="0507">0507</option>            
											                 <option value="0508">0508</option>            
											                 <option value="070">070</option>            
											                 <option value="080">080</option>
											            </select>            - 
											            <input type="text" name="emergency12" form="order_form" id="emergency12" size="4" maxlength="4" class="MS_input_txt width80" value="">
											            -
											            <input type="text" name="emergency13" form="order_form" id="emergency13" size="4" maxlength="4" minlength="4" class="MS_input_txt width80" value="">														<div class="refer_box">
														- 본인이 연락받을 수 있는 번호를 입력해 주세요.<br>
														- 회원 가입시 SMS 수신 동의 여부에 따라 배송시 배송알림이 전달돕니다.
														</div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div> --%>

								<!-- 비회원, 회원 둘 다 보여주기 -->
                                <div class="table-order-info">
									<h3 class="stit">
										<img src="${contextPath }/resources/image/order_title02.gif" alt="배송지 정보 입력" title="배송지 정보 입력">
									</h3>
                                    <table summary="이름, 연락처1, 연락처2, 주소, 주문메세지" class="order-table">
                                        <caption>배송지 정보</caption>
                                        <colgroup>
                                            <col width="150">
                                            <col width="*">
                                        </colgroup>
                                        <tbody>
											<tr class="nbg">
												<td class="sub_title_txt" colspan="2">
													배송지 정보는 모두 필수 입력사항입니다. 상품 주문에 꼭 필요한 사항이므로 정확하게 기제해 주시기 바랍니다.
													<!-- <div class="same_data">
														<label>        
															<input type="checkbox" name="same" form="order_form" id="same" onclick="copydata()"> 주문자 정보 입력
														</label>
													</div> -->
												</td>
											</tr>
											<tr>
                                            </tr>
                                            <tr>
                                                <th scope="row"><div class="txt_l">이 름</div></th>
                                                <td>
                                                    <div>
                                                       <input type="text" name="orderRec" form="order_form" id="orderRec" class="MS_input_txt txt-input2 width180">                                                    
                                                    </div>
                                                </td>
											</tr>
											<tr>
											</tr>
											<tr>
                                                <th scope="row"><div class="txt_l">연락처</div></th>
                                                <td>
                                                    <div class="tel_input">
                                                      <select name="emergency21" form="order_form" id="emergency21" class="MS_select MS_tel">
										                <option value="">선택</option>                    
										                <option value="010">010</option>                   
										                <option value="011">011</option>                  
										                <option value="016">016</option>                 
										                <option value="017">017</option>               
										                <option value="018">018</option>                  
										                <option value="019">019</option>                 
										                <option value="02">02</option>                   
										                <option value="031">031</option>                    
										                <option value="032">032</option>                    
										                <option value="033">033</option>                    
										                <option value="041">041</option>                    
										                <option value="042">042</option>                    
										                <option value="043">043</option>                    
										                <option value="044">044</option>                    
										                <option value="051">051</option>                    
										                <option value="052">052</option>                   
										                <option value="053">053</option>                   
										                <option value="054">054</option>                    
										                <option value="055">055</option>                    
										                <option value="061">061</option>                    
										                <option value="062">062</option>                    
										                <option value="063">063</option>                    
										                <option value="064">064</option>                    
										                <option value="0502">0502</option>                    
										                <option value="0503">0503</option>                    
										                <option value="0504">0504</option>                    
										                <option value="0505">0505</option>                    
										                <option value="0507">0507</option>                    
										                <option value="0508">0508</option>                    
										                <option value="070">070</option>                    
										                <option value="080">080</option>
										            </select>            - 
										            <input type="text" name="emergency22" form="order_form" id="emergency22" size="4" maxlength="4" class="MS_input_txt width80" value="">
										            -
										            <input type="text" name="emergency23" form="order_form" id="emergency23" size="4" maxlength="4" minlength="4" class="MS_input_txt width80" value="">														<span class="fs_11 fc_gray8 ml_10"> - 연락 받으실 전화번호(휴대폰)를  입력해 주세요.</span>
                                                    </div>
                                                </td>
											</tr>
											<!-- <tr>
                                                <th scope="row"><div class="txt_l">연락처2</div></th>
                                                <td>
                                                    <div>
                                                       <select name="emergency31" form="order_form" id="emergency31" class="MS_select MS_tel">
											                <option value="">선택</option>                    
											                <option value="010">010</option>                    
											                <option value="011">011</option>                    
											                <option value="016">016</option>                    
											                <option value="017">017</option>                    
											                <option value="018">018</option>                    
											                <option value="019">019</option>                    
											                <option value="02">02</option>                    
											                <option value="031">031</option>                    
											                <option value="032">032</option>                    
											                <option value="033">033</option>                    
											                <option value="041">041</option>                    
											                <option value="042">042</option>                    
											                <option value="043">043</option>                    
											                <option value="044">044</option>                    
											                <option value="051">051</option>                    
											                <option value="052">052</option>                    
											                <option value="053">053</option>                    
											                <option value="054">054</option>                    
											                <option value="055">055</option>                    
											                <option value="061">061</option>                    
											                <option value="062">062</option>                    
											                <option value="063">063</option>                    
											                <option value="064">064</option>                    
											                <option value="0502">0502</option>                    
											                <option value="0503">0503</option>                    
											                <option value="0504">0504</option>                    
											                <option value="0505">0505</option>                    
											                <option value="0507">0507</option>                    
											                <option value="0508">0508</option>                    
											                <option value="070">070</option>                    
											                <option value="080">080</option>
											            </select>            -
											            <input type="text" name="emergency32" form="order_form" id="emergency32" size="4" maxlength="4" class="MS_input_txt width80" value="">
											            - 
											            <input type="text" name="emergency33" form="order_form" id="emergency33" size="4" maxlength="4" minlength="4" class="MS_input_txt width80" value="">														
											            <span class="fs_11 fc_gray8 ml_10"> - 추가로 연락 받으실 전화번호(휴대폰)를  입력해 주세요.</span>
                                                    </div>
                                                </td>
                                            </tr> -->
											<tr>
                                                <th scope="row"><div class="txt_l">주소</div></th>
                                                <td>
                                                    <div class="tb-label-r10">
                                                        <ul>
                                                            <li class="receiver_zip">
                                                               <!-- <input name="post1" id="post1" form="order_form" size="3" class="MS_input_txt" onclick="this.blur();post();">
															      - 
															   <input name="post2" id="post2" form="order_form" size="3" class="MS_input_txt" onclick="this.blur();post();"> -->                                                                
															   <input name="member_add1" id="member_add1" form="order_form" size="3" class="MS_input_txt" readonly="readonly">
															   <a href="javascript:sample6_execDaumPostcode();" title="우편번호 검색">우편번호 검색</a>
															</li>
<!-- 															<li class="receiver_zip2">
															   <input type="hidden" name="old_address" form="order_form" id="old_address" value="">
															   <input type="hidden" name="old_home_address" form="order_form" id="old_home_address" value="">
															   <input type="hidden" name="old_offi_address" form="order_form" id="old_offi_address" value="">                                                            
															</li> -->
                                                            <li class="receiver_zip2">
                                                               <input type="text" name="member_add2" form="order_form" id="member_add2" size="50" class="MS_input_txt txt-input2 width580" placeholder="주소" readonly="readonly">                                                            
                                                               <input type="text" name="member_add3" form="order_form" id="member_add3" size="50" class="MS_input_txt txt-input2 width580" placeholder="상세주소">                                                            
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">
                                                    <div class="txt_l">
                                                        주문메시지
                                                    </div>
                                                </th>
                                                <td>
                                                    <div>
                                                      <textarea name="order_msg" form="order_form" id="order_msg" cols="50" rows="5" class="MS_textarea"></textarea>
        											  <div class="refer_box2">* 메시지는 100자 내외로 작성해 주세요. 예) 부재시 경비실에 맞겨 주세요.</div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<th scope="row">
                                            		<div class="txt_l">
                                                        결제수단
                                                    </div>
                                            	</th>
												<td style="padding-top:20px;">
													<input type="radio" name="payment" form="order_form" value="무통장입금" />무통장입금
													<input type="radio" name="payment" form="order_form" value="카드" />카드 결제
												</td>
											</tr>
											<tr>
												<th scope="row">
													<div class="txt_l">
                                                        입금은행
                                                    </div>
												</th>
												<td>
													<select name="bank">
														<option value="">::은행을 선택하세요::</option>
														<option value="국민">국민은행 933901-01-111111</option>
														<option value="신한">신한은행 110-111-111111</option>
														<option value="우리">우리은행 1002-111-111111</option>
														<option value="농협">농협 302-1111-1111-11</option>
													</select>
												</td>
											</tr>
                                            <%-- <tr>
                                                <th scope="row"><div class="tb-right"></div></th>
                                                <td colspan="1">
                                                   <div class="new-privercy-contract">
                                                   <p>개인정보 수집·이용</p>
							                       <div class="privercy-contract">
							                            <table class="tbl" summary="목적, 항목, 보유기간">
							                                <caption>개인정보 수집/이용</caption>
							                                <colgroup>
							                                    <col width="*">
							                                    <col width="30%">
							                                    <col width="20%">
							                                </colgroup>
							                                <thead>
							                                    <tr>
							                                        <th scope="col">목적</th>
							                                        <th scope="col">항목</th>
							                                        <th scope="col">보유기간</th>
							                                    </tr>
							                                </thead>
							                                <tbody>
							                                                                <tr>
							                                <td class="purpose"><div class="txt-l">서비스 제공(요금정산, 콘텐츠 제공, 구매 및 요금결제, 물품배송, 금융거래 본인 인증 및 금융서비스)</div></td>
							                                <td class="items"><div class="txt-l">구매자 정보(이름, 연락처, 이메일),수취인 정보(이름, 연락처, 주소)</div></td>
							                                <td class="holding"><div class="txt-l">주문일로 부터 90일까지(관계 법령에 따라 필요 시,일정기간 보유)</div></td>
							                </tr>
							             </tbody>
							           </table>
							           <div style="margin-top: 5px;">* 동의하셔야 서비스를 이용하실 수 있습니다.</div>
								           <div class="privercy-agree">
									           <label><input type="radio" name="new_privacy_agree" value="Y"> 정보수집에 동의합니다.</label>
									           <label><input type="radio" name="new_privacy_agree" value="N" checked=""> 동의하지 않습니다.</label>
							           	   </div>
							          </div>                                                
							        </div>
                                      </td>
                                    </tr>
									<tr>
	                                     <th scope="row">
	                                        <div class="txt_l">
	                                           입금자명
	                                        </div>
	                                     </th>
	                                     <td>
	                                        <div>
	                                           <input type="text" name="bankname" form="order_form" class="MS_input_txt" size="10" maxlength="40">
	        								   <span class="MS_bankname_message">(주문자와 같을경우 생략 가능)</span>														
	        								   <div class="refer_box2">무통장 입금시에 적어주세요. 주문자와 같을경우 생략 가능</div>
	                                        </div>
	                                     </td>
                                    </tr> --%>
                                    </tbody>
                                    </table>
                                </div>
								<%-- <div class="opt_cube cb_clear">
								
                                    <table summary="쿠폰,적립금,예치금,마일리지" class="etc_table">
                                        <caption>배송지 정보</caption>
                                        <colgroup>
											<col width="33.33%">
                                            <col width="33.33%">
                                            <col width="33.33%">
                                        </colgroup>
                                        <tbody>
											<tr>
												<th>쿠폰사용</th>
												<th>적립금사용</th>
												<th class="notborder_right">예치금사용</th>
											</tr>
											<tr>
												<td class="not_optcon">
													<span class="fs_12 b fc_gray3">쿠폰을 사용하실수 없습니다.</span><br>
													<span class="fs_11 fc_gray8">고객님께서는 로그인 중이 아니십니다.</span>
												</td>
												<td class="not_login">
													<span class="fs_12 b fc_gray3">적립금을 사용하실수 없습니다.</span><br>
													<span class="fs_11 fc_gray8">고객님께서는 로그인 중이 아니십니다.</span>
												</td>
												<td class="not_login notborder_right">
													<span class="fs_12 b fc_gray3">예치금을 사용하실수 없습니다.</span><br>
													<span class="fs_11 fc_gray8">고객님께서는 로그인 중이 아니십니다.</span>
												</td>
											</tr>
										</tbody>
									</table>
								</div> --%>
								
                                <div class="btn-foot">
                                    <a href="javascript:order();"><span class="smp-btn-pay-info"><img src="${contextPath }/resources/image/order_submit_over.gif" alt="주문하기" title="주문하기" onmouseover="this.src='${contextPath }/resources/image/join_submit.gif'" onmouseout="this.src='${contextPath }/resources/image/order_submit_over.gif'"></span></a>
                                    <a href="javascript:order_cancel()"><img src="${contextPath }/resources/image/join_cancel_over.gif" alt="주문취소" title="주문취소" onmouseover="this.src='${contextPath }/resources/image/join_cancel.gif'" onmouseout="this.src='${contextPath }/resources/image/join_cancel_over.gif'"></a>
                                </div>
                            </fieldset>
                        </form>                    
                     </div><!-- .page-body -->
                </div><!-- #order -->
            </div><!-- #content -->
        </div><!-- #contentWrap -->
    </div>
</body>
</html>