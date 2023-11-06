<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<%@ page import = "hotel.bean.reviewDTO" %>
<%@ page import = "hotel.bean.reviewDAO" %>
<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />

<%
    request.setCharacterEncoding("UTF-8");

MemberDAO mdao = MemberDAO.getInstance();
String id = (String) session.getAttribute("sid");
int grade= mdao.checkGrade(id);

    String userId = (String) session.getAttribute("sid"); 

    if (userId != null) {
        MemberDTO user = dao.myInfo(userId); 
        
        if (user != null) {
                 
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>호텔 리뷰 작성</title>
    <link rel="stylesheet" href="/BookStay/resources/css/list_menu.css"/>
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
		<a href="../views/main.jsp">
			BookStay
		</a>
	</div>
	</div>
	<style>
	
body {
   padding-top: 20px; /* 페이지의 상단 여백을 늘립니다. */
}

#header {
    margin-bottom: 100px; /* 헤더 아래에 여백을 추가합니다. */
}

h1.display-3 {
    margin-top: 50px; /* h1 요소를 아래로 이동시킵니다. */
}

#content {
    margin-top: 50px; /* 컨텐츠 영역을 아래로 이동시킵니다. */
}

#content textarea {
    margin-top: 100px; /* textarea를 아래로 이동시킵니다. */
}
	
	</style>
<div style="margin:auto;text-align:center;">
    <h1>호텔 리뷰 작성</h1>
<br>
    <form action="reviewWritePro.jsp" method="post">
        
        <input type="hidden" id="id" name="id" value="<%=userId %>">
   

        <div class="form-check" style="text-align: center;">
    <div style="margin: 0 auto; text-align: left; width: 200px;">
        <img id="img" src="../resources/img/heart0.jpeg" height="35" width="180"><br>
        </div>
        <label class="form-check-label" for="flexRadioDefault1">
    
  </label>
</div>
<script>
function changeImg(num){
	if(num==1){
		document.getElementById("img").src="../resources/img/heart1.jpeg";
	}else if(num==2){
		document.getElementById("img").src="../resources/img/heart2.jpeg";
	}else if(num==3){
		document.getElementById("img").src="../resources/img/heart3.jpeg";
	}else if(num==4){
		document.getElementById("img").src="../resources/img/heart4.jpeg";
	}else if(num==5){
		document.getElementById("img").src="../resources/img/heart5.jpeg";
	}
}
</script>
		<div class="container">
        1<input class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" value="1" onclick="changeImg(1)">
        2<input class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" value="2" onclick="changeImg(2)">
        3<input class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" value="3" onclick="changeImg(3)">
        4<input class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" value="4" onclick="changeImg(4)">
        5<input class="form-check-input" id="flexRadioDefault1" type="radio" name="jumsu" value="5" onclick="changeImg(5)">
        </div>
        <br>

        <label for="content">리뷰 내용</label> <br>
        <textarea id="content" name="content" style="width: 35%;" rows="13" cols="40" required></textarea><br>

        <input type="hidden" name="ref" value="<%= request.getParameter("ref") %>">
        <br>
        <input type="submit" class="btn btn-primary" value="작성">
        <button class="btn btn-primary" onclick="window.location='/BookStay/views/main.jsp'">취소</button>
    </form>
</div>

</body>
</html>


<% 	
            
    } else {
%>
<script>
    alert("사용자 정보를 가져오는 중 오류가 발생했습니다.");
    window.location = "/BookStay/member/loginform.jsp";
</script>
<%
    }
    } else {
%>
<script>
    alert("세션이 만료되었거나 로그인하지 않았습니다. 다시 로그인해주세요.");
    window.location = "/BookStay/member/loginform.jsp";
</script>
<%
    }
%>