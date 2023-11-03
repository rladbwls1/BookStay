<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.boardDAO"%>
<%@page import="hotel.bean.boardDTO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/BookStay/resources/css/question.css"/>
<%@ include file="../views/main_bar.jsp" %>
<%request.setCharacterEncoding("UTF-8");
 if(grade==11){
	 %>
	 <script>
	 	alert("로그인을 먼저해주세요");
	 	window.location="BookStay/views/main.jsp";
	 </script>
	 <%
 }
%>
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
<%if(ref.equals("0")){ %>
<div id="list">
<h2>문의글 작성</h2>
<form id="form1" name="form" action="writePro.jsp" method="post">
<input type="hidden" name="id">
<input type="hidden" name="category" value="30">
<input type="hidden" name="ref" value="<%=ref%>">
<table id="tb">
<tr>
	<td class="title">제목</td>
	<td><input type="text" id="title "name="title" required></td>
</tr>	
<tr>
	<td class="title">내용</td>
	<td><textarea rows="6" cols="30" id="content" name="content" required></textarea></td>
</tr>
</table>
<button id="btn" type="submit">작성</button>
</form>
</div>
<input type="hidden" name="re_step" value="0">
<%}else{ %>
<div id="list">
<h2>문의글 답변 작성</h2>
<form id="form2" name="form" action="writePro.jsp" method="post">
<input type="hidden" name="id">
<input type="hidden" name="category" value="30">
<input type="hidden" name="ref" value="<%=ref%>">
<table id="tb">
	<tr>
		<td class="title">제목</td>
		<td><input type="text" id="title "name="title" value="[답변]<%=dto.getTitle()%>" readonly></td>
	</tr>
	<tr>
		<td class="title">문의내용</td>
		<td><textarea rows="6" cols="30" readonly><%=dto.getContent() %></textarea></td>
	</tr>
	<tr>
		<td class="title">답변</td>
		<td><textarea rows="6" cols="30" id="content" name="content" required></textarea></td>
	</tr>
<input type="hidden" name="re_step" value="1"/>
</table>
<button id="btn" type="submit">작성</button>
</form>
</div>
<%} %>

