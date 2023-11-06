<%@page import="hotel.bean.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="hotel.bean.boardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hotel.bean.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%
request.setCharacterEncoding("UTF-8");
MemberDAO mdao = MemberDAO.getInstance();
String sid = (String) session.getAttribute("sid");
int grade= mdao.checkGrade(sid);


boardDAO dao = boardDAO.getInstance();
ArrayList<boardDTO> list = dao.getList(10);
SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
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
	<div class="col-md-3" style="width:200px; height:150px; border:100px; float:left; margin-left: 300px;">
<!-- 사이드 바 메뉴-->
  <!-- 패널 타이틀1 -->
<div  class="panel panel-info">
    <div  class="panel-heading">
      <h3  class="panel-title">고객센터</h3>
    </div>
    <!-- 사이드바 메뉴목록1 -->
    <ul  class="list-group">
      <li class="list-group-item"><a href="/BookStay/board/notice.jsp">공지사항</a></li>
      <li  class="list-group-item"><a href="/BookStay/board/QnAList.jsp">자주 묻는 질문</a></li>
      <li  class="list-group-item"><a href="/BookStay/member/logout.jsp">로그아웃</a></li>
      
    </ul>
</div>
 </div>
	<style>

#header {
    margin-bottom: 150px;
}

</style>

<div class="h4 pb-2 mb-4 text-dark border-bottom border-dark">
  공지사항
</div>

<%for(boardDTO dto : list){
	String title=dto.getTitle();
	String reg=df.format(dto.getReg());
	String content=dto.getContent();
	%>
	
	
	<div style="margin:auto;text-align:center;" >
	<div  class="d-flex justify-content-center">
		<a href="javascript:void(0);" onclick="toggleContent('content_<%=dto.getNum()%>');"><h5><%=title%></h5></a>
		<%if(grade==99){ %>
		<button onclick="window.location='boardUpdateForm.jsp?num=<%=dto.getNum()%>&category=<%=dto.getCategory()%>'">수정</button>
		<button onclick="window.location='boardDelete.jsp?num=<%=dto.getNum()%>&category=<%=dto.getCategory()%>'">삭제</button>
		<%} %>
		<br>
		<%=reg%><br>
		<div id="content_<%=dto.getNum()%>" style="display: none;"><%=dto.getContent()%></div>
	</div>
	
	<%
} %>
<%
if(grade==99){
	%>
	<button type="button" onclick="window.location='writeForm.jsp'">공지글 작성</button>
	<%
}
%>
</div>
<script>
function toggleContent(contentId) {
    var contentDiv = document.getElementById(contentId);
    if (contentDiv.style.display === "none") {
        contentDiv.style.display = "block";
    } else {
        contentDiv.style.display = "none";
    }
}
</script>