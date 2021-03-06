# ð THEBAG
> ê°ë°© ì¼íëª° ì¹ì¬ì´í¸  
> [ì¬ì´í¸ ë°ë¡ê°ê¸° ìë²ë´ë¦¼](http://localhost:8080/shoppingMall) 


> íì¤í¸ ê³ì  (ID / PW)  
> íì : chl1 / chl1!  
<br>

## ì¬ì© ê¸°ì 
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

## ì£¼ì ê¸°ë¥ (ëë¬ì ë´ì© í¼ì¹ê¸°) 
<details>  
  <summary>íì ê°ì</summary>  
  <br>  
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/114997168-8799e100-9eda-11eb-9ea5-4446a834d30b.gif">
  </p>
  <br> 
  
  * ajaxë¥¼ ì´ì©í ìì´ë ì¤ë³µ íì¸ ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/member/controller/MemberController.java#L307)  
    ```javascript
          function idCheck(){
            var idReg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,12}$/;   /* ìë¬¸,ì«ì 4~12ìë¦¬ë§ ê°ë¥ */
            var member_id = $("#member_id").val();
            $.ajax({
                url: "${pageContext.request.contextPath}/member/idCheck.do",		
                type:"post", 
                data: {"member_id" : member_id},
                success:function(data){
                  if($.trim(data) == 1){
                    $("#idResult").html("ì´ë¯¸ ì¬ì© ì¤ì¸ ìì´ëìëë¤");
                    $("#idResult").css("color", "red");
                  }else if($.trim(data) == 0){
                    if(!idReg.test(member_id)){
                      $("#idResult").html("ìë¬¸,ì«ìí¬í¨ 4~12ìë¦¬");
                      $("#idResult").css("color", "red");
                    }else{
                      $("#idResult").html("ì¬ì© ê°ë¥í ìì´ëìëë¤");
                      $("#idResult").css("color", "green");
                    }
                  }
                },
                error: function(){
                  console.log("ìì´ë ì¤ë³µíì¸ ajax ìë¬");
                }
           });
      }
    ```
  * ì ê·ìì¼ë¡ ìì´ë, ë¹ë°ë²í¸, ì´ë©ì¼ ì í¨ì± ê²ì¬ ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/webapp/WEB-INF/views/member/signUpForm.jsp#L20) 
  * spring securityìì ì ê³µíë passwordEncoderì BCrypt ë°©ìì¼ë¡Â ë¹ë°ë²í¸ ìí¸í  
  
    ![ìí¸í](https://user-images.githubusercontent.com/74228420/114732469-7edfc880-9d7d-11eb-944c-dba830e9a503.PNG)
    
    ```java
      @RequestMapping(value = "/signUp.do", method = RequestMethod.POST)
      public ModelAndView signUp(@ModelAttribute("membervo") MemberVO membervo, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("redirect:/");
        // membervo ê°ì²´ë¡ ë§ë¤ì´ì§ íë¼ë¯¸í°ìì ë½ì ë¹ë°ë²í¸
        String inputPW = membervo.getPw();
        // ë½ì ë¹ë°ë²í¸ë¥¼ ìí¸í
        String encodePW = pwEncoder.encode(inputPW);
        // ìí¸íìí¨ ë¹ë°ë²í¸ë¥¼ ë¤ì membervo ê°ì²´ì ë£ëë¤
        membervo.setPw(encodePW);
        // ì´ë©ì¼ ì¸ì¦ ì¬ë¶
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
              out.write("alert('íìê°ì ì¤í¨')");
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
  * SMTPë¥¼ ì´ì©í ì´ë©ì¼ ì¸ì¦  
  
    <img src="https://user-images.githubusercontent.com/74228420/114733270-29f08200-9d7e-11eb-82e2-4efe5ec2867b.PNG" width="400" height="250"><br>  
    
    ```java
      @RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
      @ResponseBody
      public String mailAuthkey(String email) throws Exception {

        // ë·°íì´ì§ìì ëì´ì¨ ë°ì´í°
        logger.info("ì´ë©ì¼: " + email);

        // ì¸ì¦ë²í¸ë¥¼ ìí ëì ìì±
        Random random = new Random();
        int authkey = random.nextInt(589641) + 111111;
        logger.info("ìì±ë ì¸ì¦ë²í¸: " + authkey);

        // ì´ë©ì¼ ë³´ë´ê¸°
        String setFrom = "";                                               // ì´ë©ì¼ ê³ì 
        String toMail = email; 				                                  // ë·°ìì ë°ì ì´ë©ì¼ ì£¼ì
        String title = "íìê°ì ì¸ì¦ë²í¸"; 		                           // ì´ë©ì¼ ì ëª©
        String content = "THEBAG íìê°ìì ìí ì¸ì¦ë²í¸ìëë¤." + "<br>" // ì´ë©ì¼ ë´ì©
            + "<h2>ì¸ì¦ë²í¸: [ " + authkey + " ]</h2> <br>";

        try {
          MimeMessage message = mailSender.createMimeMessage();
          MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
          helper.setFrom(setFrom, "THEBAG(ëë°±)");
          helper.setTo(toMail);
          helper.setSubject(title);
          helper.setText(content, true);
          mailSender.send(message);

        } catch (Exception e) {
          e.printStackTrace();
        }

        // ajaxë¥¼ íµí ìì²­ì ë·°íì´ì§ë¡ ë°í, ë°í ë°ì´í° íìì Stringë§ ê°ë¥íë¯ë¡ íë³í í ë°í
        String num = Integer.toString(authkey);

        return num;
      }
    ``` 
</details>  

<details>  
  <summary>ë¡ê·¸ì¸</summary> 
  <br>
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/115019837-af963e00-9ef4-11eb-9b43-ec6048f66672.gif">
  </p>
  <br>
  
  * ì¸í°ìí° ì²ë¦¬ë¥¼ íì¬ ììë¡ ê´ë¦¬ì íì´ì§ ì ê·¼ì ë¡ê·¸ì¸ íì´ì§ë¡ ì´ë ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/common/AdminInterceptor.java#L14)  
  * ì¸ìì ì ì¥ë ê°ì¼ë¡ ë¡ê·¸ì¸ ì¬ë¶ íì¸ ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/member/controller/MemberController.java#L124) 
  * ë¤ì´ë²/ì¹´ì¹´ì¤ ë¡ê·¸ì¸ APIë¥¼ íµí ìì ë¡ê·¸ì¸ êµ¬í ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/member/controller/MemberController.java#L189)
  * ë¡ê·¸ì¸ í ë§ì´ íì´ì§ìì ë¹ë°ë²í¸, ì´ë©ì¼, ì íë²í¸ ì ë³´ ìì  ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/member/controller/MemberController.java#L386)
</details>  

<details>  
  <summary>ê´ë¦¬ì</summary>
  <br>
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/115033143-0b68c300-9f05-11eb-8940-770206e28fe1.gif">
  </p>
  <br>
  
  * chart.jsë¥¼ ì´ì©í ì ê· ê°ìì, ë§¤ì¶ì¡, ìíë³ ìì íµê³ ì°¨í¸ ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/main/AdminMainController.java#L41)  
  * DBì ì ì¥ë íì ì ë³´ íì¸  
    
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
  * DBì ì ì¥ëì´ ìë ìíì ëª©ë¡ì¼ë¡ íì¸, ìíëª, ì¹´íê³ ë¦¬(ìí ëë¶ë¥), ê°ê²©, ìí êµ¬ë¶ì¼ë¡ ê²ì ê°ë¥ ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/product/controller/AdminProductContoller.java#L224) 
  * ìí ì ë³´(ìì) ì¶ê° ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/product/controller/AdminProductContoller.java#L285) 
  * CKEditorë¥¼ ì ì©í´ì ìí ìì¸ ì´ë¯¸ì§ì ìí ì¤ëª ì²¨ë¶ ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/product/controller/AdminProductContoller.java#L134)  
  * ì¸ë¤ì¼ ì´ë¯¸ì§ë ë³ëë¡ íì¼ ì²¨ë¶ ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/admin/product/controller/AdminProductContoller.java#L63)   
</details> 

<details>  
  <summary>ìí ì£¼ë¬¸</summary>
  <br>
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/115035953-06594300-9f08-11eb-9451-53144f146d31.gif">
  </p>
  <br>
  
  * Daum postcode APIë¥¼ ì¬ì©íì¬ ì°í¸ ë²í¸ ì¡°í ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/webapp/WEB-INF/views/order/orderMain.jsp#L18) 
  * ìí ì£¼ë¬¸ì ì£¼ë¬¸ë ì§ì .Math()ë¡ ìì±í ë¬´ìì ëì ì£¼ë¬¸ ë²í¸ ìì± ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/order/controller/OrderController.java#L71)
    
    ```java
      // ë/ì/ì¼ê³¼ ëë¤ì«ìë¥¼ ì´ì©í´ ì£¼ë¬¸ ë²í¸ ë§ë¤ê¸°
      Calendar cal = Calendar.getInstance();
      int year = cal.get(Calendar.YEAR);
      String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
      String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
      String subNum = "";

      // ë¬´ìì 6ìë¦¬ ì«ì ìì±
      for (int i = 1; i <= 6; i++) {
        subNum += (int) (Math.random() * 10);
      }

      // ì£¼ë¬¸ë²í¸ = "ë ì§-ëë¤ì«ì"
      String order_no = ymd + "-" + subNum;
    ```
  * ë§ì´ íì´ì§ìì ì£¼ë¬¸ ì ë³´ íì¸  
    
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
  <summary>ìí íê¸°</summary>
  <br>
  
  <p align="center">
  <img src="https://user-images.githubusercontent.com/74228420/115040000-edeb2780-9f0b-11eb-899e-1a0233d30aa4.gif">
  </p>
  <br>
  
  * ìí íê¸° ìì±/ìì /ì­ì  ð [ì½ë íì¸](https://github.com/dev123542/shoppingMall/blob/main/src/main/java/com/shoppingMall/review/controller/ReviewController.java#L52)
</details> 
