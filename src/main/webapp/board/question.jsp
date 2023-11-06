<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.boardDAO"%>
<%@page import="hotel.bean.boardDTO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%request.setCharacterEncoding("UTF-8");
MemberDAO mdao = MemberDAO.getInstance();
String id = (String) session.getAttribute("sid");
int grade= mdao.checkGrade(id);

 if(grade==11){
	 %>
	 <script>
	 	alert("로그인을 먼저해주세요");
	 	window.location="/BookStay/views/main.jsp";
	 </script>
	 <%
 }
%>
<link rel="stylesheet" href="/BookStay/resources/css/list_menu.css"/>
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
	<style>
.form-container {
    background-color: #f5f5f5; /* 폼의 배경색을 설정합니다 */
    border: 1px solid #ddd; /* 폼의 테두리 스타일 및 색상을 설정합니다 */
    padding: 10px;
    margin: 500px;
    margin-top: 50px; /* 폼을 아래로 이동시킬 수 있는 여백을 설정합니다 */
}

/* 나머지 스타일은 그대로 유지합니다 */
body {
    padding-top: 20px;
}

#header {
    margin-bottom: 100px;
}

#content {
    margin-top: 10px;
}

#content textarea {
    margin-top: 5px;
}
</style>

<%String ref=request.getParameter("ref");
hotelDAO hdao = new hotelDAO();
boardDAO bdao=boardDAO.getInstance();
boardDTO dto = new boardDTO();
if(hdao.checkNull(ref)){
	ref="0";
}else{
	dto=bdao.getContent(Integer.parseInt(ref));
}
%>
 
 <div style="text-align: center; margin-top: 150px;">
 <h1>질문 내용 작성</h1>
<form name="form" class="form-container"  action="writePro.jsp" method="post">

<input type="hidden" name="id">
<input type="hidden" name="category" value="30">
<input type="hidden" name="ref" value="<%=ref%>">

<%if(ref.equals("0")){ %>
<div class="form-group">

</div>
<div class="form-floating mb-3">
<input type="text" class="form-control" id="floatingInput" name="title" required>
<label for="floatingInput">제목</label>
</div>
<br/>

<div class="form-floating">
<textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea" name="content" style="height: 300px ;" required></textarea>
<input type="hidden" name="re_step" value="0">
<label for="floatingTextarea">내용</label>
</div>
<%}else{ %>
제목<input type="text" id="title "name="title" value="[답변]<%=dto.getTitle()%>" readonly><br/>
내용<br/>
문의내용 : <textarea style="width: 35%;" rows="6" cols="30" readonly><%=dto.getContent() %></textarea><br>
답변글<textarea rows="6" cols="30" id="content" name="content" required></textarea><br>
<input type="hidden" name="re_step" value="1">

<%} %>

<br>
 <div style="margin-top: 20px;">
<button class="btn btn-primary" type="submit">작성</button>
</div>
</form>
</div>

