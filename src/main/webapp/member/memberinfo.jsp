<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />
<%@ include file="../views/main_bar.jsp" %>
<%	
    request.setCharacterEncoding("UTF-8");
    String sid = (String) session.getAttribute("sid"); // 사용자 아이디 가져오기

    // 사용자 정보 조회
    MemberDTO user = dao.myInfo(sid);
    String birth = user.getBirth().substring(0, 11);
%>
<style>
/*모달 생성*/
#myModal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius: 10px;
    height: 50%; 
}
.modal-content {
    width: auto;
    height: auto;
    overflow: hidden;
    border: 2px solid gray;
    position: relative;
    border-radius: 10px; background-color: white;

}

.close {
    position: absolute;
    top: -4px;
    right: 2px;
    cursor: pointer;
    color: #198754;
    font-size: 22px;
    text-align: center;
    font-weight: bold;
}
.close:hover {
    font-weight: bold;
}/*   모달 생성*/

	  /*  화원정보수정 모달 영역     */
      .modal-content{
            font-family: Arial, sans-serif;
            background-color: #F2F2F2;
            
            padding: 0;}
            
     .modalTable  td {  
    text-align: center;
    font-family: Arial, sans-serif;
    
    font-size: 14px;
}   
	  .modalTable {
	  border:none;
	 border: white;
    width: 100%; /* 수정: 테이블 폭을 80%로 조정 */
    margin: 0 auto; /* 테이블을 가운데 정렬 */
    border-collapse: collapse;
    background-color: white;
    text-decoration: none;
    font-size: 14px;
    color: black;
    border-radius: 15px;
}

.modalHiddenshow{
	display: none;
}


.mainment{
	font-weight: bold;
	font-size: x-large;
}
.subment{
		font-size: large;
}
.modalsumitinput:hover {
    background-color: #157347;
}
.modalInputText{
	left:0;
	margin-left:0px;
    width: 50%;
    height: 40px;
    border-radius: 8px;
    margin-top: 2px;
}

.modalSumitinput {
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
.modlalButton_a {
    font-size: 14px;
    text-decoration: none;
    color:black;
}

.modlalButton_a:hover {
    font-weight: bolder;
}
      
	/* 회원 정보수정 모달 영역끝*/
</style>
<script>



// 모달 열기
function openModal(modalType) {
    var modal = document.getElementById("myModal");
    modal.style.display = "block";

}
// 모달 닫기
function closeModal() {
    var modal = document.getElementById("myModal");
    modal.style.display = "none";
}
// 모달 닫기 및 부모 페이지로 이동
function closeModalAndRedirect() {
    var modal = document.getElementById("myModal");
    modal.style.display = "none";
    // 부모 페이지로 이동
    window.location.href = "updateFirstPro.jsp"; // 수정 후 이동할 페이지로 변경
}
//모달창 비밀번호 유효성           
            // 비밀번호 유효성 검사 및 비밀번호 모자이크 제어 함수
             function CV_checkPasswordPattern(str) {
        var pwField = document.getElementById("pw");
        var pwError = document.getElementById("pwError");

        if (str.length < 1) {
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
        var pw = document.getElementById("pw").value;
        var pwValid = CV_checkPasswordPattern(pw);

        if (!pwValid) {
            return false;
        }
        // 서버로 데이터 전송
        return true;
    }
            
            // a태그 새창띄우기
       function openCenteredWindow(event) {
  event.preventDefault(); // 기본 동작(링크 이동)을 막습니다.

  // 창의 가로 및 세로 크기를 정의합니다.
  var width = 400;
  var height = 500;

  // 화면의 가로 및 세로 크기를 가져옵니다.
  var screenWidth = window.screen.availWidth;
  var screenHeight = window.screen.availHeight;

  // 창을 화면 가운데에 위치시키기 위한 left와 top 값을 계산합니다.
  var left =2500;
  var top = 14000;

  // 새 창을 열고 크기 및 위치를 지정합니다.
  var newWindow = window.open("/BookStay/member/FindPw.jsp", "centeredWindow", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);
}

</script>
            

<html>
<head>
    <title>마이페이지</title>
    <style>
    @charset "UTF-8";

    body {
            font-family: Arial, sans-serif;
            background-color: #F2F2F2;
            margin: 0;
            padding: 0;
        }

    .UjinsHypboy{
            box-sizing: border-box;
            width: 100%;
            height: 80px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            top: 0;
            left: 0;
            padding: 0 20px;
        }

 .info {
    cursor: pointer;
    font-size: 16px;
    
}

#logo {
    width: 200px;
    height: 60px;
    font-weight: 800;
    padding: 10px;
    z-index: 150;
    text-align: left;
}

        #logo > a {
            width: 133px;
            height: 40px;
            font-size: 30px;
            text-decoration: none;
            color: black;
        }

        .table-container {
            text-align: center;
            margin: 150px auto;
            width: 80%;
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
            width: 22%;
            height:5%;
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
        
        .mainbody{
        	width: 50%;
        	padding:auto;
        	margin:auto;
        	
        }
        .mainTable{
        	color:#787878;
        	 
        }
    
    </style>
    <link rel="stylesheet" href="/resources/css/memberinfo.css" type="text/css">
</head>
<body class="mainbody">
    
    <div class="table-container" >
        <h2>마이페이지</h2>
        <table border="1"  class="mainTable">
            <tr>
                <td>아이디</td>
                <td><%= sid %></td>
            </tr>
            <tr>
                <td>이름</td>
                <td><%= user.getName() %></td>
            </tr>
            <tr>
                <td>이메일</td>
                <td><%= user.getEmail() %></td>
            </tr>
            <tr>
                <td>생일</td>
                <td><%= birth %></td>
            </tr>
            <tr>
                <td>주소</td>
                <td><%= user.getAddr() %></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td><%= user.getPnum() %></td>
            </tr>
        </table>
       <div class="button-container">
            <input type="button" value="로그아웃" onclick="location.href='/BookStay/member/logout.jsp'" id="button-container_b" class="button_sub">
            <input type="button" value="회원정보수정" onclick="openModal('updateFirst')" id="button-container_c" class="button_sub">
            <input type="button" value="회원탈퇴"  onclick="location.href='/BookStay/member/deleteSelect.jsp'" id="button-container_d" class="button_sub">
            <input type="button" value="예약확인 "  onclick="location.href='/BookStay/member/memberlist.jsp'" id="button-container_d" class="button_sub">
        </div>
    </div>
	</body>
	</html>
   <!--   myModal :updateFirst  회원정보수정영역 시작  -->
  <div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>     
  	    <form action="updateFirstPro.jsp" method="post"  onsubmit="return validateForm();">
  	  <table class="modalTable" style="border:none;">
      
          	  <tr  style="border:none;">
                <td class="modalHiddenshow">
                </td>
                <td  style="border:none;">
                <br/>
                    <div class="modalMent" >
                    	 <div class="mainment"> 회원정보 수정</div><br/>
                        <div class="subment">회원정보 확인을 위해 비밀번호를 입력해주세요</div>
                    </div>
                </td>
            </tr>
            <tr  style="border:none;">
                <td class="modalHiddenshow"><label for="pw">비밀번호</label></td>
                <td  style="border:none;">
                    <input type="password" id="pw" name="pw" class="modalInputText" placeholder="비밀번호를 입력하세요" size="15" onblur="validatePassword(this, 'pwError')"> <br/>
                    <span id="pwError" style="color: red;" class=" error-message">  </span>
                </td>
            </tr>
            <tr  style="border:none;">
                <td class="modalHiddenshow">
                </td>
                <td  style="border:none;">
                    <button type="submit"  onclick="combineAndSubmit()" name="confirm" class="modalSumitinput">입력</button><br/>
                   <a href="/BookStay/member/FindPw.jsp" class="modlalButton_a"  onclick="openCenteredWindow(event)">비밀번호 찾기</a>

                </td>
            </tr>
            <input type="hidden" name="id" value="<%= sid %>">
    
    </table>
        </form>
    </div>
</div>