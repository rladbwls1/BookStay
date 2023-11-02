<%@page import="hotel.bean.boardDAO"%>
<%@page import="hotel.bean.boardDTO"%>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<jsp:useBean id="dto" class="hotel.bean.boardDTO"/>
<%
request.setCharacterEncoding("UTf-8");
String keyword=request.getParameter("keyword");
boardDAO dao = boardDAO.getInstance();
ArrayList<boardDTO> list = dao.getSerchList(keyword);

MemberDAO mdao = MemberDAO.getInstance();
String id = (String) session.getAttribute("sid");
int grade= mdao.checkGrade(id);

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
<div style="margin:auto;text-align:center;">
<div style="margin-bottom: 20px;">
<h2>QnA 검색결과 </h2><hr />
</div>
<form action="serchQnAList.jsp" method="post">
	<input type="text" name="keyword" value="<%=keyword%>"><button type="submit">검색</button> 
</form>

<hr /> 
</div>
<%
if(list==null){
	%>
	검색 결과가 없습니다.
	<%
}else{
	for(boardDTO d : list){%>
		<a href="javascript:void(0);" onclick="toggleContent('content_<%=d.getNum()%>')"><%=d.getTitle() %></a>
			<button onclick="window.location='boardUpdateForm.jsp?num=<%=d.getNum()%>&category=<%=d.getCategory()%>'">수정</button>
			<button onclick="window.location='boardDelete.jsp?num=<%=d.getNum()%>&category=<%=d.getCategory()%>'">삭제</button><br />
			<div id="content_<%=d.getNum()%>" style="display: none"><%=d.getContent()%></div>
		
	<%}%>
	
<%}%>
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