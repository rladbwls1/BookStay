<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />
<%@ include file="../views/main_bar.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<jsp:setProperty property="*" name="dto" />
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Recovery</title>
    <style>
        /* 본문에 제공된 CSS 스타일 추가 */
      /* 2023.11.07  그냥  내부 css 로  변경 */



  /*modal 공통 */
 #modaltable td {    
    text-align: center;
    font-family: Arial, sans-serif;
    font-size: 14px;
    border-color: white;
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

        .table-container {
        
   			
            font-family: Arial, sans-serif;
            background-color: #F2F2F2;
            margin: 0;
            padding: 0;
            text-align: center;
            margin: 150px auto;
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top:100px;
            width:30%;
            
        }
        .mainTable{
             margin-top:50px;
        
        }

        h2 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
        }

        th {
            background-color: #333;
            color: #fff;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        

        input[type="button"] {
            width:30%;
            height:40px;
            background-color: #198754;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            margin: 0 6px;
            cursor: pointer;
        }

        input[type="button"]:hover {
            background-color: #157347;
        }
      
    
        	
        } 
        /* .mainTable{
        	color:#787878;
        	 
        }
            */
    
    
    
    
    
    
     /* 2023.11.07  그냥  내부 css 로  변경 */
        /*모달*/
           /*modal 공통 */
 #modaltable td {    
 border:none;
    text-align: center;
    font-family: Arial, sans-serif;
    font-size: 14px;
    border:none;
}
#modaltable tr a {
    text-decoration: none;
    border:none;
}   
#modaltable {
	border:none;
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
border:none;
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

.modalsumitinput a{
color:black;
text-decoration: none;
}
.modalsumitinput a:hover{
font-weight: bold;

} 
.modalsumitinput:hover {
    background-color: #157347;
}
         <!--  비밀번호 찾기 모달 -->
        .modal2{
            display: none;
            position: fixed;
            transform: translate(-50%, -50%);
            border-radius: 10px;
            	    background-color: white;
            	     border:none;
        } 
        
        .modal-content2 {
       
	    border: 2px solid gray;
	    position: relative;
	    border-radius: 10px;
	    background-color: white;
	    height: 500px; /* 원하는 높이로 설정 */
	    width: 400px; /* 원하는 너비로 설정 */
	 	 top:-500px;
	    left:300px;
	    
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
  function openModal2(modalType) {
            var modal2 = document.getElementById("myModal2");
            modal2.style.display = "block";

       
        }

        function closeModal2() {
            var modal2 = document.getElementById("myModal2");
            modal2.style.display = "none";
        }
   
    </script>
</head>
<body  class="margin-top">
    <div class="table-container">
        <table border="1" class="mainTable">
            <tr>
                <td>
                    
     <div id="memberMessage">
                        회원님의 아이디는 <%= request.getParameter("id") %> 입니다
                    </div>
                
                </td>
            </tr>
        </table>
        <div class="button-container" class="modalsumitinput">
               <a	href="/BookStay/member/loginform.jsp" id="button-container_d" class="button_sub">로그인</a>&nbsp&nbsp&nbsp|&nbsp&nbsp
               <a  href="javascript:void(0);" class="button_b" onclick="openModal2('FindPw')">비밀번호 찾기</a>
        </div>
    </div>
    
     <!-- 모달 창  수정 HTML -->
    <div id="myModal2" class="modal2"  style="display: none;">
        <div class="modal-content2">
            <span class="close2" onclick="closeModal2()" style=" cursor:pointer; accent-color: #198754; ">&times;</span>

            <!-- 및 비밀번호 찾기 페이지의 URL을 설정하세요 -->
            
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
