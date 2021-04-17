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

## 주요 기능 (눌러서 내용 펼치기) 
<details>  
  <summary>회원 가입</summary>  
  <br>  
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/114997168-8799e100-9eda-11eb-9ea5-4446a834d30b.gif">
  </p>
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
  * 정규식으로 아이디, 비밀번호, 이메일 유효성 검사 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/webapp/WEB-INF/views/member/signUpForm.jsp#L20) 
  * spring security에서 제공하는 passwordEncoder의 BCrypt 방식으로 비밀번호 암호화  
  
    ![암호화](https://user-images.githubusercontent.com/74228420/114732469-7edfc880-9d7d-11eb-944c-dba830e9a503.PNG)
    
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
  * SMTP를 이용한 이메일 인증  
  
    <img src="https://user-images.githubusercontent.com/74228420/114733270-29f08200-9d7e-11eb-82e2-4efe5ec2867b.PNG" width="400" height="250"><br>  
    
    ```java
      @RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
      @ResponseBody
      public String mailAuthkey(String email) throws Exception {

        // 뷰페이지에서 넘어온 데이터
        logger.info("이메일: " + email);

        // 인증번호를 위한 난수 생성
        Random random = new Random();
        int authkey = random.nextInt(589641) + 111111;
        logger.info("생성된 인증번호: " + authkey);

        // 이메일 보내기
        String setFrom = "";                                               // 이메일 계정
        String toMail = email; 				                                  // 뷰에서 받은 이메일 주소
        String title = "회원가입 인증번호"; 		                           // 이메일 제목
        String content = "THEBAG 회원가입을 위한 인증번호입니다." + "<br>" // 이메일 내용
            + "<h2>인증번호: [ " + authkey + " ]</h2> <br>";

        try {
          MimeMessage message = mailSender.createMimeMessage();
          MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
          helper.setFrom(setFrom, "THEBAG(더백)");
          helper.setTo(toMail);
          helper.setSubject(title);
          helper.setText(content, true);
          mailSender.send(message);

        } catch (Exception e) {
          e.printStackTrace();
        }

        // ajax를 통한 요청을 뷰페이지로 반환, 반환 데이터 타입은 String만 가능하므로 형변환 후 반환
        String num = Integer.toString(authkey);

        return num;
      }
    ``` 
</details>  

<details>  
  <summary>로그인</summary> 
  <br>
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/115019837-af963e00-9ef4-11eb-9b43-ec6048f66672.gif">
  </p>
  <br>
  
  * 인터셉터 처리를 하여 임의로 관리자 페이지 접근시 로그인 페이지로 이동 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/common/AdminInterceptor.java#L14)  
  * 세션에 저장된 값으로 로그인 여부 확인 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/member/controller/MemberController.java#L124) 
  * 네이버/카카오 로그인 API를 통한 소셜 로그인 구현 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/member/controller/MemberController.java#L189)
  * 로그인 후 마이 페이지에서 비밀번호, 이메일, 전화번호 정보 수정 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/member/controller/MemberController.java#L386)
</details>  

<details>  
  <summary>관리자</summary>
  <br>
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/115033143-0b68c300-9f05-11eb-8940-770206e28fe1.gif">
  </p>
  <br>
  
  * chart.js를 이용한 신규 가입자, 매출액, 상품별 수요 통계 차트 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/main/AdminMainController.java#L41)  
  * DB에 저장된 회원 정보 확인  
    
    ```java
      @RequestMapping(value = "/memberList.do", method = { RequestMethod.GET, RequestMethod.POST })
        private ModelAndView memberList(HttpServletRequest request, HttpServletResponse response) {
          String viewName = (String) request.getAttribute("viewName");
          ModelAndView mav = new ModelAndView(viewName);
          List<MemberVO> list = adminService.memberList();
          mav.addObject("list", list);
          return mav;
        }
    ```
  * DB에 저장되어 있는 상품을 목록으로 확인, 상품명, 카테고리(상품 대분류), 가격, 상품 구분으로 검색 가능 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/product/controller/AdminProductContoller.java#L224) 
  * 상품 정보(색상) 추가 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/product/controller/AdminProductContoller.java#L285) 
  * CKEditor를 적용해서 상품 상세 이미지와 상품 설명 첨부 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/product/controller/AdminProductContoller.java#L134)  
  * 썸네일 이미지는 별도로 파일 첨부 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/product/controller/AdminProductContoller.java#L63)   
</details> 

<details>  
  <summary>상품 주문</summary>
  <br>
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/115035953-06594300-9f08-11eb-9451-53144f146d31.gif">
  </p>
  <br>
  
  * Daum postcode API를 사용하여 우편 번호 조회 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/webapp/WEB-INF/views/order/orderMain.jsp#L18) 
  * 상품 주문시 주문날짜와 .Math()로 생성한 무작위 난수 주문 번호 생성 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/order/controller/OrderController.java#L71)
    
    ```java
      // 년/월/일과 랜덤숫자를 이용해 주문 번호 만들기
      Calendar cal = Calendar.getInstance();
      int year = cal.get(Calendar.YEAR);
      String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
      String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
      String subNum = "";

      // 무작위 6자리 숫자 생성
      for (int i = 1; i <= 6; i++) {
        subNum += (int) (Math.random() * 10);
      }

      // 주문번호 = "날짜-랜덤숫자"
      String order_no = ymd + "-" + subNum;
    ```
  * 마이 페이지에서 주문 정보 확인  
    
    ```java
    @RequestMapping(value="/orderView.do", method = RequestMethod.GET)
    public ModelAndView orderView(@RequestParam("n") String order_no, HttpServletRequest request) {
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);

      HttpSession session = request.getSession();
      String member_id = (String) session.getAttribute("member");
      OrderVO orderVO = new OrderVO();
      orderVO.setOrder_no(order_no);
      orderVO.setMember_id(member_id);

      try {
        List<OrderListVO> orderView = orderService.orderView(orderVO);
        logger.info(orderView.toString());
        mav.addObject("orderView", orderView);
      } catch (Exception e) {
        e.printStackTrace();
      }


      return mav;
    }
    ```
</details> 

<details>  
  <summary>상품 후기</summary>
  <br>
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/115040000-edeb2780-9f0b-11eb-899e-1a0233d30aa4.gif">
  </p>
  <br>
  
  * 상품 후기 작성/수정/삭제 📌 [코드 확인](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/review/controller/ReviewController.java#L52)
</details> 
