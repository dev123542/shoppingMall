<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
  request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
 <%--  <title><tiles:insertAttribute name="header" /></title> --%>
 <link href="${contextPath}/resources/css/style.css" rel="stylesheet" type="text/css" media="screen">
</head>
<body>
	<div class="footer_container">
	<footer class="footer inbox">
        <div class="footer__copy">
            <ul>
                <li><h3 class="footer__logo"><a href="">WHOSBAG</a></h3></li>
                <li>믿고 사는 쇼핑몰 후즈백</li>
                <li>SINCE 2004</li>
            </ul>
            <span>&copy;whosbag.com All rights reserved</span>
        </div>
        <div class="footer__info">
            <div class="footer__tel">
                <h4>CUSTOMER CENTER</h4>
                <div class="footer__txt">
                    <span class="txt_big">02. 1234. 1234</span>
                    <div class="txt_small">
                        <span>MON-FRI 10:00AM ~ 05:00PM</span>
                        <span>LUNCH 12:30AM ~ 01:30PM</span>
                        <span>Weekend &amp; Holiday Closed</span>
                        <span><a href="">개인정보 취급방침</a></span>
                    </div>
                </div>
            </div>
            <div class="footer__bank">
                <h4>BANKING INFO</h4>
                <div class="footer__txt">
                    <span class="txt_md">예금주: 후즈백</span>
                    <div class="txt_small">
                        <span>국민은행 933901-01-111111</span>
                        <span>신한은행 110-111-111111</span>
                        <span>우리은행 1002-111-111111</span>
                        <span>농협 302-1111-1111-11</span>
                    </div>
                </div>
            </div>
            <div class="footer__company">
                <h4>COMPANY INFOMATION</h4>
                <div class="footer__txt">
                    <span class="txt_big">whosbag</span>
                    <div class="txt_small">
                        <span>Business licence / 211-11-11111 <a href="">사업자 정보확인</a></span>
                        <span>Mail order licence / 동대문구 제02904호</span>
                        <span>Owner. Song</span>
                        <span>Add. 서울 동대문구 천호대로</span>
                        <span>Email. whosbag@gmail.com</span>  
                    </div>
                </div> 
            </div>
        </div>
	</footer> 	
</div>
</body>
</html>