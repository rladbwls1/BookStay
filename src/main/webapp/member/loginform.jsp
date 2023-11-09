<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />
<%@ include file="../views/main_bar.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<jsp:setProperty property="*" name="dto" />
<!DOCTYPE html>
<html>
<head>

<%     
request.setCharacterEncoding("UTF-8");
String sid =request.getParameter("id");
String name = request.getParameter("name");
String email = request.getParameter("email");
String pnum = request.getParameter("pnum"); %>
    <link rel="stylesheet" href="/BookStay/resources/css/loginform.css" type="text/css">
    <style>
    /*modal 공통 */
 #modaltable td {    
    text-align: center;
    font-family: Arial, sans-serif;
    font-size: 14px;
}
#modaltable tr a {
    text-decoration: none;
}   
#modaltable {
    width: 100%; /* 수정: 테이블 폭을 80%로 조정 */
    margin: 0 auto; /* 테이블을 가운데 정렬 */
    border-collapse: collapse;
    background-color: white ;
      text-decoration: none;
    font-size: 14px;
    color: black;
    border-radius: 15px;
    margin-bottom:10px;
   margin-top:10px;
}
    
#modalfontment{
   margin-bottom:10px;
   font-size: x-large;
}
  .box {
    width: 32%;
    height: 38px;
    color: black;
    font-size: 14px;
    border-radius: 5px;
    font-weight: bold;
}
  
   
#email{
   width: 42%;
}  
#email2{
   width: 42%;
}  
 .modalinputText {
   left:0;
   margin-left:0px;
    width: 75%;
    height: 40px;
    border-radius: 8px;
    margin-top: 2px;
}
.modalinputText:first-child{
   margin-top:10px;
}   

    .hiddenshow{
   display: none;
}
    <!--  아이디찾기 모달 -->
        .modal {
            display: none;
            border-radius: 10px;
            position: absolute;     
            height: 100%;   
           
        }
              .modal-content {
             position: absolute;
             border-radius: 10px;
             background-color: white;
             height: 400px; /* 원하는 높이로 설정 */
             width: 400px; /* 원하는 너비로 설정 */
     top:190px;
       left:500px;
         }
        .close {
            position: absolute;
            top: -10px;
            right: 0;
            cursor: pointer;
            color: #198754;
            font-size: 25px;
            text-align: center;
        }

        .close:hover {
            font-weight: bold;
        }
        
        
      .modalsumitinput {
   margin-top:10px;
margin-bottom:10px;
    width:30%;
    background-color: #198754;
    height: 40px;
    border-radius: 8px;
    color: white;
    border: none;
    cursor: pointer;
}    
.modalsumitinput:hover {
    background-color: #157347;
}
         <!--  모달비밀 번호 찾기 모달 -->
        .modal2{
            display: none;
            position: fixed;
            transform: translate(-50%, -50%);
            border-radius: 10px;
        } 
        
        .modal-content2 {
       border: 2px solid gray;
       position: relative;
       border-radius: 10px;
       background-color: white;
       height: 500px; /* 원하는 높이로 설정 */
       width: 400px; /* 원하는 너비로 설정 */
     top:50px;
       left:500px;
   }
        .close2 {
            position: absolute;
            top: -10px;
            right: 0;
            cursor: pointer;
            color: #198754;
            font-size: 25px;
            text-align: center;
        }
        .close2:hover {
            font-weight: bold;
        }
    </style>
    
   <script>
   
   function CV_checkIdPattern(str) {
       var idField = document.getElementById("id");
       var idError = document.getElementById("idError");

       if (str.length == 0) {
           idField.classList.add("error-border");
           idError.textContent = "아이디를 입력해주세요.";
           return false;
       } else {
           idField.classList.remove("error-border");
           idError.textContent = "";
           return true;
       }
   }

   function CV_checkPasswordPattern(str) {
       var pwField = document.getElementById("pw");
       var pwError = document.getElementById("pwError");

       if (str.length == 0) {
           pwField.classList.add("error-border");
           pwError.textContent = "비밀번호를 입력해주세요.";
           return false;
       } else {
           pwField.classList.remove("error-border");
           pwError.textContent = "";
           return true;
       }
   }
   function validateForm() {
       var id = document.getElementById("id").value;
       var pw = document.getElementById("pw").value;
       var idValid = CV_checkIdPattern(id);
       var pwValid = CV_checkPasswordPattern(pw);

       if (!idValid || !pwValid) {
           return false;
       }

   }
   
   


   // 휴대폰번호 유효성 검사
   function formatPhoneNumber(input) {
       // 휴대폰 번호에서 숫자만 남기고 다른 문자 제거
       var phoneNumber = input.value.replace(/\D/g, '');

       // 휴대폰 번호에 하이픈 추가
       if (phoneNumber.length >= 3 && phoneNumber.length <= 6) {
           phoneNumber = phoneNumber.replace(/(\d{3})(\d{0,4})/, '$1-$2');
       } else if (phoneNumber.length >= 7) {
           phoneNumber = phoneNumber.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3');
       }

       input.value = phoneNumber;
   }

   
   
   function updateEmail() {
      const emaillist = document.getElementById('emaillist');
      const emailInput = document.getElementById('email');

      if (emaillist.value === 'type') {
          // 사용자가 이메일을 수동으로 입력하도록 선택한 경우
          const emailtxt = document.getElementById('emailtxt').value;
          const combinedEmail = emailInput.value + "@" + emailtxt;
          emailInput.value = combinedEmail;
      } else if (emaillist.value !== 'type') {
          // 스크롤에서 선택한 경우
          const selectedDomain = emaillist.value;
          emailInput.value = emailInput.value.split('@')[0] + selectedDomain;
      }
   }
   
   function updateEmail2() {
      const emaillist = document.getElementById('emaillist2');
      const emailInput = document.getElementById('email2');

      if (emaillist.value === 'type') {
          // 사용자가 이메일을 수동으로 입력하도록 선택한 경우
          const emailtxt = document.getElementById('emailtxt').value;
          const combinedEmail = emailInput.value + "@" + emailtxt;
          emailInput.value = combinedEmail;
      } else if (emaillist.value !== 'type') {
          // 스크롤에서 선택한 경우
          const selectedDomain = emaillist.value;
          emailInput.value = emailInput.value.split('@')[0] + selectedDomain;
      }
   }



    /*  모달 관련*/
     
        function openModal(modalType) {
            var modal = document.getElementById("myModal");
            modal.style.display = "block";

    
        }

        function closeModal() {
            var modal = document.getElementById("myModal");
            modal.style.display = "none";
        }

        function openModal2(modalType) {
            var modal2 = document.getElementById("myModal2");
            modal2.style.display = "block";

       
        }

        function closeModal2() {
            var modal2 = document.getElementById("myModal2");
            modal2.style.display = "none";
        }
        
     
  
  
  <!-- 모달아  -->



        
       
    </script>
</head>
<body>
    <div class="loginbox">
        <div class="loginbox_a">
                  <form method="post"  action="loginPro.jsp" onsubmit="return validateForm();">
                    <table class="loginbox_b" >
                        <tr>
                            <td class="tableline">
                                <div class="bookment">
                                    <a>
                                        BookStay에 온 걸<br/> 환영해요  :)
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="id" id="id" placeholder="아이디를 입력하세요" style="width:384px; height:45px; border-radius: 8px; margin-top:10px;"><br/>
                                 <span id="idError" class="error-message"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요" style="width:384px; height:45px; border-radius: 8px; margin-top:10px;"><br/>
                             <span id="pwError" class="error-message"></span>
                            </td>
                        </tr>
                        <tr>
            <td>
                <!-- 여기에 추가된 부분 -->   
                              <div id="loginError" class="error-message">
        <% String loginError = (String)request.getAttribute("loginError");
           if (loginError != null) { out.println(loginError); } %>
    </div>
                              
                              
                        <div>
                    <input type="checkbox" name="auto" value="1" class="autologin" id="autologin-checkbox">
                    <a class="autotext" >자동로그인</a>
                    <input type="submit" value="Login" class="logininput" onclick="combineAndSubmit()">
                </div>
            </td>
        </tr>
 <tr>
                            <td>
                      <div class="button">
                <a href="javascript:void(0);" class="button_a" onclick="openModal('FindId')">아이디 찾기</a>&nbsp|
                <a href="javascript:void(0);" class="button_b" onclick="openModal2('FindPw')">비밀번호 찾기</a>&nbsp|
                <a href="memberForm.jsp" class="button_c">회원가입</a>&nbsp|<a href="/BookStay/views/main.jsp" class="button_d"> 홈으로 가기</a>
            </div>
            </td>
        </tr>


        
                    </table>
                </form>

        </div>
    </div>
    <!-- 모달 창  수정 HTML -->
    <div id="myModal" class="modal"   style="display: none;     position:absolute;">
        <div class="modal-content">
            <span class="close" onclick="closeModal()" style=" cursor:pointer; accent-color: #198754; ">&times;</span>
            <!-- 아이디 찾기 및 비밀번호 찾기 페이지의 URL을 설정하세요 -->
       <!--   Findid modalform 시작  -->
           
<form action="FindIdPro.jsp" method="post" id="registrationForm" name="userinput">
    <table  id="modaltable" >
        <tr>
            <td class="hiddenshow"></td>
            <td height="39" align="center" id="modalfontment">
              <h1 id="modalfontment" >아이디를 찾기위해서<br/>필요한 정보를<br/> 입력해주세요</h1>
            </td>
            <td></td>
        </tr>

        <tr>
            <td width="200" class="hiddenshow">
                <label for="name">이름</label>
            </td>
            <td width="400">
                <input type="text" placeholder="이름을 입력하세요" name="name" size="15" class="modalinputText" maxlength="12" >
            </td>
            <td></td>
        </tr>

        <tr>
            <td width="400" class="hiddenshow">
                <label for="email">이메일</label>
            </td>
            <td width="400">
                <input type="text" id="email" name="email" size="14" placeholder="이메일을 입력하세요" class="modalinputText"  />
                <select class="box" id="emaillist" name="emaillist"   onchange="updateEmail('email', 'emaillist')">
                    <option value="type">직접 입력</option>
                    <option value="@naver.com">@naver.com</option>
                    <option value="@google.com">@google.com</option>
                    <option value="@hanmail.net">@hanmail.net</option>
                    <option value="@nate.com">@nate.com</option>
                    <option value="@kakao.com">@kakao.com</option>
                </select>
            </td>
            <td></td>
        </tr>

        <tr>
            <td width="200" class="hiddenshow">
                <label for="pnum">휴대폰번호</label>
            </td>
            <td width="400">
                <input type="text" name="pnum" placeholder="휴대폰번호를 입력하세요" size="15" required class="modalinputText" maxlength="13" oninput="formatPhoneNumber(this);">
            </td>
            <td></td>
        </tr>

        <tr>
            <td class="hiddenshow"></td>
            <td>
                <!-- <input type="submit" name="confirm" value="아이디찾기" class="modalsumitinput" onclick="openCenteredWindow(event)" />-->            
<input type="submit" name="confirm" value="아이디찾기" class="modalsumitinput">



            <td></td>
        </tr>
    </table>
</form>

       
       <!--  findid modal form종료 -->
       
        </div>
    </div>
    
    
    <!-- 모달 창  수정 HTML -->
    <div id="myModal2" class="modal2"  style="display: none;">
        <div class="modal-content2">
            <span class="close2" onclick="closeModal2()" style=" cursor:pointer; accent-color: #198754; ">&times;</span>

            <!-- 아이디 찾기 및 비밀번호 찾기 페이지의 URL을 설정하세요 -->
            
<!--  form 시작 -->

<form action="FindPwPro.jsp" method="post" id="registrationForm" name="userinput">
<table id="modaltable">

<tr>
<td class="hiddenshow"></td>
<td><br/>
  <h1 id="modalfontment" >비밀번호 찾기위해서<br/>필요한 정보를<br/> 입력해주세요</h1>
</td>
<td></td>
</tr>
            <tr>
                <td width="200" align="center" class="hiddenshow">
                    <label>아이디</label>
                </td>
                <td width="400">
                    <input type="text"   class="modalinputText"  name="id" size="10" maxlength="12" placeholder="아이디를 입력하세요"  required>          
                </td>
                <td></td>
            </tr>
         
     
             <tr>
       
                <td width="200" align="center" class="hiddenshow">
                    <label for="name">이름</label>
                </td>
             
                <td width="400">
                    <input type="text"  placeholder="이름을 입력하세요"   name="name" size="15"  class="modalinputText"   maxlength="12" required>
 
                </td>
                <td></td>
                
                
            </tr>
            
            
           <tr>
                <td width="400"  class="hiddenshow">
                    <label for="email">이메일</label>
                </td>
                   <td width="400">
                <input type="text" id="email2" name="email" size="14" placeholder="이메일을 입력하세요" class="modalinputText"  />
                <select class="box" id="emaillist2" name="emaillist" onchange="updateEmail2('email2', 'emaillist2')">
                    <option value="type">직접 입력</option>
                    <option value="@naver.com">@naver.com</option>
                    <option value="@google.com">@google.com</option>
                    <option value="@hanmail.net">@hanmail.net</option>
                    <option value="@nate.com">@nate.com</option>
                    <option value="@kakao.com">@kakao.com</option>
                </select>
            </td>
                   
                         <td></td>
                
            </tr>
       
         
            <tr>
                <td   class="hiddenshow">
                    <label for="pnum">휴대폰번호</label>
                </td>
                <td width="400">
                     <input type="text" name="pnum" placeholder="휴대폰번호를 입력하세요" size="15" required class="modalinputText" maxlength="13" oninput="formatPhoneNumber(this);">
            </td>
              
                
                <td>
                </td>
            </tr>
          
          
            <tr>          
            <td class="hiddenshow"></td>
            <td>  <input type="submit" name="confirm" value="비밀번호 찾기"   class="modalsumitinput" onclick="openCenteredWindow2(event);"/></td>
            <td></td>
            </tr>
        
   
  
</table>                        
   
</form>



<!--  form 끝 -->
        </div>
    </div>
    
    

</body>
</html>