<%@page import="hotel.bean.hotelDAO"%>
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
String id = (String)session.getAttribute("sid");
if(id==null){
	%>
		<script>
			alert("로그인을 먼저 해주세요");
			window.location="../views/main.jsp";
		</script>
	<% 
}
boardDAO dao = boardDAO.getInstance();
hotelDAO check = new hotelDAO();
ArrayList<boardDTO> list = dao.getMyList(id);
SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
%>
<%@ include file="../views/menu.jsp" %>
<div>
1:1 문의 
</div>
<hr />
<%if(list.size()==0){ %>
문의사항이 없습니다.

<%}else{ %>
<%for(boardDTO dto : list){
	String title=dto.getTitle();
	String reg=df.format(dto.getReg());
	String content=dto.getContent();
	boardDTO answer = new boardDTO();
	answer=dao.getAnswer(dto.getRef());
	%>
	<%if(dto.getId().equals("admin")){}else{ %>
	<div class="board-item">
		<a href="javascript:void(0);" onclick="toggleContent('content_<%=dto.getNum()%>');"><%=title%></a>
		<%if(!check.checkNull(id)&&id.equals(dto.getId())){ %>
		<button type="button" onclick="window.location='boardDelete.jsp?category=<%=dto.getCategory()%>&num=<%=dto.getNum()%>'">삭제</button>
		<%} %>
		<%if(!check.checkNull(id)&&id.equals("admin")){ %>
		<button type="button" onclick="window.location='question.jsp?ref=<%=dto.getRef()%>'">답변작성</button>
		<%} %>
		<br>
		<%=reg%><br>
		<div id="content_<%=dto.getNum()%>" style="display: none;">
		<%=dto.getContent()%><hr>
		답변 <br>
		<%=answer.getContent()%><hr>
		</div>
		
	</div>

	<hr />
	<%} %>
	<%
}} %>
<button type="button" onclick="window.location='question.jsp'">문의글작성</button>
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