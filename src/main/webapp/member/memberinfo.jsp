<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />

<%
    request.setCharacterEncoding("UTF-8");

	MemberDAO mdao = MemberDAO.getInstance();
	String id = (String) session.getAttribute("sid");
	int grade= mdao.checkGrade(id);

    String userId = (String) session.getAttribute("sid"); // 사용자 아이디 가져오기

    if (userId != null) {
        MemberDTO user = dao.myInfo(userId); // 사용자 정보 조회
        String birth = user.getBirth().substring(0,11);

        if (user != null) {
            // 여기서 user 객체를 사용하여 사용자 정보에 접근할 수 있습니다.
             if ("admin".equals(userId)) {
            
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    

<html>
<head>
<style>
   
    .table-container {
        text-align: center;
    }
         table {      
            display: flex;
              margin: 0;
            border-collapse: collapse;
            border: 1px solid #ccc; /* 테이블 테두리 스타일 설정 (선택 사항) */
        }
        th, td {
            border: 1px solid #ccc; /* 셀 테두리 스타일 설정 (선택 사항) */
            padding: 8px 12px;
        }   
      td:nth-child(1){
         width:200px;
      }
      td:nth-child(2){
         width:400px;
      }
    h1 {
            text-align: center;
        }
     .button-container {
            align-items: center;   
        display: inline-block;
        left:700px;
    }

</style>

    <title>어서오세요</title>
</head>
<body>
<h2>마이페이지</h2>
<table border="1">
    <tr>
        <td>아이디</td>
        <td><%= userId %></td>
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

<input type="button" value="메인" onclick="location.href='../views/main.jsp'" class="btn btn-success">
<input type="button" value="로그아웃" onclick="location.href='logout.jsp'" class="btn btn-success">
<input type="button" value="회원정보수정" onclick="location.href='updateFirst.jsp'" class="btn btn-success">
<input type="button" value="회원탈퇴" onclick="location.href='delete.jsp'" class="btn btn-success">
<input type="button" value="관리자 예약내역 확인" onclick="location.href='/BookStay/admin/adminMain.jsp'" class="btn btn-success">

</body>

<%
            } else {
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    

<head>

<style>
  table, th, td {
    border: 1px solid #bcbcbc;
  }
  table {
  margin: auto;
  text-align:center;
  }
</style>
    <title>어서오세요</title>
</head>
<body>

<div id="header">
	<div id="login">
		<%if(grade==11) { // 세션이 없다면 수행
    String cid = null, cpw = null, cauto = null;
    Cookie[] cookies = request.getCookies();
  
    	if (cookies != null) {
       		 for (Cookie c : cookies) {
		            if (c.getName().equals("cid")) { cid = c.getValue(); }
		            if (c.getName().equals("cpw")) { cpw = c.getValue(); }
		            if (c.getName().equals("cauto")) { cauto = c.getValue(); }
   				}  
 		   	}
    	if (cid != null && cpw != null && cauto != null) {
    		response.sendRedirect("/BookStay/member/loginPro.jsp");	
    	}
    if (cid == null || cpw == null || cauto == null) { %>
		<div><a href="/BookStay/member/loginform.jsp">로그인</a></div>
		<div><a href="/BookStay/member/memberForm.jsp">회원가입</a></div>
		<%}				
		}if(grade==0 || grade==99){ %>
		<div><a href="/BookStay/member/logout.jsp">로그아웃</a></div>
		<div><a href="/BookStay/member/memberinfo.jsp">MyPage</a></div>
		<%}%>
		<div>고객센터</div>
		<%if(grade==99){ %>
		<div><a href="/BookStay/admin/adminMain.jsp">관리자페이지</a></div>
		<%} %>	
	</div>
	<div id="logo">
		<a href="main.jsp">
			BookStay
		</a>
	</div>
	</div>

</div>
<h2>마이페이지</h2> <br>
<div class="col-md-3" style="width:200px; height:150px; border:1px; float:left;">
<!-- 사이드 바 메뉴-->
  <!-- 패널 타이틀1 -->
<div class="panel panel-info">
    <div class="panel-heading">
      <h3 class="panel-title">Panel Title</h3>
    </div>
    <!-- 사이드바 메뉴목록1 -->
    <ul class="list-group">
      <li class="list-group-item"><a href="/BookStay/member/updateFirst.jsp">회원정보 수정</a></li>
      <li class="list-group-item"><a href="/BookStay/member/delete.jsp">회원 탈퇴</a></li>
      <li class="list-group-item"><a href="/BookStay/member/logout.jsp">로그아웃</a></li>
    </ul>
</div>
  <!-- 패널 타이틀2 -->
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">Panel Title</h3>
  </div>
    <!-- 사이드바 메뉴목록2 -->
      <ul class="list-group">
        <li class="list-group-item"><a href="../views/main.jsp">메인</a></li>
        <li class="list-group-item"><a href="/BookStay/member/memberlist.jsp">예약 내역 확인</a></li>
      </ul>
</div>      
  <!-- 패널 타이틀3 -->
<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Panel Title</h3>
  </div>
      <!-- 사이드바 메뉴목록3 -->
      <ul class="list-group">
        <li class="list-group-item"><a href="#">About</a></li>
        <li class="list-group-item"><a href="#">Help</a></li>
      </ul>
    </div>
</div> 
<br>

<div class="d-flex justify-content-center">
<div class="w-50 p-3">
<table class="table table-hover" border="1" >
    <tr>
        <td>아이디</td>
        <td><%= userId %></td>
    </tr>
    <tr>
        <td>비밀번호</td>
        <td><%= user.getPw() %></td>
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
        <td><%= user.getBirth() %></td>
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
</div>

<br>


</div>
</body>
</html>

        <%    
            }
    } else {
%>
<script>
    alert("사용자 정보를 가져오는 중 오류가 발생했습니다.");
    window.location = "loginform.jsp";
</script>
<%
    }
    } else {
%>
<script>
    alert("세션이 만료되었거나 로그인하지 않았습니다. 다시 로그인해주세요.");
    window.location = "loginform.jsp";
</script>
<%
    }
%>