<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
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
	 border: white;
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
			    border: 2px solid gray;
			    position: relative;
			    border-radius: 10px;
			    background-color: white;
			    height: 400px; /* 원하는 높이로 설정 */
			    width: 400px; /* 원하는 너비로 설정 */
			       top:-600px;
			    left:100px;
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
         <!--  비밀번호 찾기 모달 -->
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
	  top:-600px;
	    left:100px;
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
   <!-- 로그인이 이미 되어잇을경우 시작 -->
   function checkLoginStatus() {
	    // 사용자가 로그인되었는지 확인합니다 (세션 속성 "loggedIn"이 있다고 가정)
	    var isLoggedIn = <%= session.getAttribute("loggedIn") != null ? session.getAttribute("loggedIn") : false %>;

	    if (isLoggedIn) {
	        alert("로그인이 이미 되어 있습니다.");
	        // 메인 페이지로 리디렉션합니다
	        window.location.href = "/BookStay/views/main.jsp";
	    }
	}
   <!-- 로그인이 이미 되어잇을경우 종료  -->
   
   
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

        // 이 부분에서 서버로 아이디와 비밀번호를 비교하여 일치 여부를 확인하고,
        // 일치하지 않으면 메시지를 표시하거나 다시 확인하도록 안내할 수 있습니다.
        // 아래 예시는 간단한 메시지를 표시하는 것을 보여줍니다.
   
        // 아이디와 비밀번호가 일치하는 경우에 실행할 코드를 여기에 추가합니다.
        // 서버로 데이터 전송 등의 작업을 수행할 수 있습니다.
    }
    
    function updateEmail() {
        const emaillist = document.getElementById('emaillist');
        const emailInput = document.getElementById('email');
        if (emaillist.value !== 'type') {
            const selectedDomain = emaillist.value;
            emailInput.value = emailInput.value.split('@')[0] + selectedDomain;
        }

    }



 
    /*  모달 관련*/
     
        function openModal(modalType) {
            var modal = document.getElementById("myModal");
            modal.style.display = "block";

            var iframe = modal.querySelector("iframe");
            if (modalType === "FindId") {
                iframe.src = "FindId.jsp";
            } else if (modalType === "FindPw") {
                iframe.src = "FindPw.jsp";
            }
        }

        function closeModal() {
            var modal = document.getElementById("myModal");
            modal.style.display = "none";
        }

        function openModal2(modalType) {
            var modal2 = document.getElementById("myModal2");
            modal2.style.display = "block";

            var iframe2 = modal2.querySelector("iframe");
            if (modalType === "FindId") {
                iframe2.src = "FindId.jsp";
            } else if (modalType === "FindPw") {
                iframe2.src = "FindPw.jsp";
            }
        }

        function closeModal2() {
            var modal2 = document.getElementById("myModal2");
            modal2.style.display = "none";
        }
        
        /* 아이디찾기 눌럿을때 생기는 새창 크기 조정*/      
   function openCenteredWindow1(event) {
  event.preventDefault(); // 기본 동작(링크 이동)을 막습니다.
  // 창의 가로 및 세로 크기를 정의합니다.
  var width = 330;
  var height = 100;
  // 화면의 가로 및 세로 크기를 가져옵니다.
  var screenWidth = window.screen.availWidth;
  var screenHeight = window.screen.availHeight;
  // 창을 화면 가운데에 위치시키기 위한 left와 top 값을 계산합니다.
  var left =2300;
  var top = 160;
  // 새 창을 열고 크기 및 위치를 지정합니다.
  var newWindow = window.open("/BookStay/member/FindIdPro.jsp", "centeredWindow", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
}
        
  /* 비밀번호찾기 눌럿을때 생기는 새창 크기 조정*/
   function openCenteredWindow2(event) {
  event.preventDefault(); // 기본 동작(링크 이동)을 막습니다.
  // 창의 가로 및 세로 크기를 정의합니다.
  var width = 330;
  var height = 100;
  // 화면의 가로 및 세로 크기를 가져옵니다.
  var screenWidth = window.screen.availWidth;
  var screenHeight = window.screen.availHeight;
  // 창을 화면 가운데에 위치시키기 위한 left와 top 값을 계산합니다.
  var left =2300;
  var top = 160;
  // 새 창을 열고 크기 및 위치를 지정합니다.
  var newWindow = window.open("/BookStay/member/FindPwPro.jsp", "centeredWindow", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
}

        
        
    </script>
</head>
<body>
    <div class="loginbox">
        <div class="loginbox_a">
                  <form method="post" action="dsPro.jsp" onsubmit="return validateForm();">
                    <table class="loginbox_b" >
                        <tr>
                            <td class="tableline">
                                <div class="bookment">
                                    <a>
                                        BookStay을 정말로 <br/> 떠나시나요 !
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
                    <input type="submit" value="회원 탈퇴" class="logininput" onclick="combineAndSubmit()">
                </div>
            </td>
        </tr>
                    </table>
                </form>

            <div class="button">
                <a href="javascript:void(0);" class="button_a" onclick="openModal('FindId')">아이디 찾기</a>&nbsp|
                <a href="javascript:void(0);" class="button_b" onclick="openModal2('FindPw')">비밀번호 찾기</a>&nbsp|
                <a href="memberForm.jsp" class="button_c">회원가입</a>&nbsp|<a href="/BookStay/views/main.jsp" class="button_d"> 홈으로 가기</a>
            </div>
        </div>
    </div>
    <!-- 모달 창  수정 HTML -->
    <div id="myModal" class="modal"   style="display: none;     position:absolute;">
        <div class="modal-content">
            <span class="close" onclick="closeModal()" style=" cursor:pointer; accent-color: #198754; ">&times;</span>
            <!-- 아이디 찾기 및 비밀번호 찾기 페이지의 URL을 설정하세요 -->
       <!--   indid modalform 시작  -->
       
       
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
                <input type="text" placeholder="이름을 입력하세요" name="name" size="15" class="modalinputText" maxlength="12" required>
            </td>
            <td></td>
        </tr>

        <tr>
            <td width="400" class="hiddenshow">
                <label for="email">이메일</label>
            </td>
            <td width="400">
                <input type="text" id="email" name="email" size="14" placeholder="이메일을 입력하세요" class="modalinputText" required />
                <select class="box" id="emaillist" name="emaillist" onchange="updateEmail()">
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
                <input type="submit" name="confirm" value="아이디찾기" class="modalsumitinput" onclick="openCenteredWindow1(event)" />
            </td>
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
                    <input type="text"     class="modalinputText"  name="id" size="10" maxlength="12" placeholder="아이디를 입력하세요"  required>          
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
			    <input type="text" id="email" name="email" size="14"   placeholder="이메일을 입력하세요"  class="modalinputText"     required />			
			    <select class="box" id="emaillist" name="emaillist" onchange="updateEmail()">
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
                    <input type="text" name="pnum"   class="modalinputText" placeholder="휴대폰번호를 입력하세요"    size="15" required maxlength="13" oninput="formatPhoneNumber(this);">
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
    
    
    
    <div class="UjinsHypboy">
        <div id="logo">
            <a href="/BookStay/views/main.jsp">
                BookStay
            </a>
        </div>
        <div class="info">고객센터</div>
    </div>
    <script>
    checkLoginStatus();
</script>
</body>
</html>
