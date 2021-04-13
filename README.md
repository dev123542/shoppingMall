# 👜 THEBAG
> 가방 쇼핑몰 웹사이트  
> [사이트 바로가기](http://localhost:8080/shoppingMall) 


> 테스트 계정 (ID / PW)  
> 회원 : chl1 / chl1!  
<br>

## 사용 기술
`Front-end`  
- HTML5  
- CSS3  
- Javascript  
- jQuery
- BootStrap  
<br>

`Back-end`  
- Java 8  
- Spring  
- MyBatis  
- Spring Security(BCrypt)
- Oracle 
- Apache, Tomcat 
<br>

`API`
- Naver
- Kakao
- Daum Postcode
- CKEditor
- Chart.js
<br>

## 주요 기능  
<details>  
  <summary>회원 가입</summary>  
  <br>  
  
  * ajax를 이용한 아이디 중복 확인 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/member/controller/MemberController.java#L307)  
    ```javascript
          function idCheck(){
            var idReg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,12}$/;   /* 영문,숫자 4~12자리만 가능 */
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
                    if(!idReg.test(member_id)){
                      $("#idResult").html("영문,숫자포함 4~12자리");
                      $("#idResult").css("color", "red");
                    }else{
                      $("#idResult").html("사용 가능한 아이디입니다");
                      $("#idResult").css("color", "green");
                    }
                  }
                },
                error: function(){
                  console.log("아이디 중복확인 ajax 에러");
                }
           });
      }
    ```
  * 정규식으로 아이디, 비밀번호, 이메일 유효성 검사 📌 [코드 확인]() 
  * spring security에서 제공하는 passwordEncoder의 BCrypt 방식으로 비밀번호 암호화  
    
    ```java
      @RequestMapping(value = "/signUp.do", method = RequestMethod.POST)
      public ModelAndView signUp(@ModelAttribute("membervo") MemberVO membervo, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("redirect:/");
        // membervo 객체로 만들어진 파라미터에서 뽑은 비밀번호
        String inputPW = membervo.getPw();
        // 뽑은 비밀번호를 암호화
        String encodePW = pwEncoder.encode(inputPW);
        // 암호화시킨 비밀번호를 다시 membervo 객체에 넣는다
        membervo.setPw(encodePW);
        // 이메일 인증 여부
        membervo.setVerify(1);
        int result;
        try {
          result = memberService.signUp(membervo);
          if (result > 0) {
            return mav;
          } else {
            try {
              PrintWriter out = response.getWriter();
              out.write("<script>");
              out.write("alert('회원가입 실패')");
              out.write("</script>");
            } catch (IOException e) {
              e.printStackTrace();
            }
          }
        } catch (Exception e1) {
          e1.printStackTrace();
        }
        return mav;
      }
    ```
  * 작성란 전부 입력시 회원 가입 가능 📌 [코드 확인]() 
  * SMTP를 이용한 이메일 인증 📌 [코드 확인]() 
  * 인증 번호를 입력해야만 회원 가입 가능 📌 [코드 확인]()  
  
</details>  

<details>  
  <summary>로그인</summary>
  <br>
  
  * 인터셉터 처리를 하여 임의로 관리자 페이지 접근시 로그인 페이지로 이동   
  * 세션에 저장된 값으로 로그인 여부 확인  
  * REST API를 통한 소셜 로그인 구현  
  * 입력하지 않거나 아이디 또는 비밀번호가 일치하지 않을 경우 알림창으로 경고  
  <br>
  
  * 로그인 후 마이 페이지에서 비밀번호, 이메일, 전화번호 정보 수정
</details>  

<details>  
  <summary>관리자</summary>
  <br>
  
  * chart.js를 이용한 신규 가입자, 매출액, 상품별 수요 통계 차트  
  * DB에 저장된 회원 정보 확인  
  * DB에 저장되어 있는 상품을 목록으로 확인  
  * 상품명, 카테고리(상품 대분류), 가격, 상품 구분으로 검색 가능  
  * 상품 정보(색상) 추가  
  * CKEditor를 적용해서 상품 상세 이미지와 상품 설명 첨부  
  * 썸네일 이미지는 별도로 파일 첨부  
  * 빈 입력칸이 있을 경우 알림창이 뜨고, 전부 입력해야 상품 등록 가능  
</details> 

<details>  
  <summary>상품 주문</summary>
  <br>
  
  * Daum postcode API를 사용하여 우편 번호 조회  
  * 상품 주문시 주문날짜와 .Math()로 생성한 무작위 난수 주문 번호 생성  
  * 마이 페이지에서 주문 정보 확인
</details> 

<details>  
  <summary>상품 후기</summary>
  <br>
  
  * 상품 후기 작성/수정/삭제
</details> 
