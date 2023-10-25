<%@page import="hotel.bean.boardDAO"%>
<%@page import="hotel.bean.boardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="hotel.bean.boardDTO"/>
<%
request.setCharacterEncoding("UTf-8");
String keyword=request.getParameter("keyword");
boardDAO dao = boardDAO.getInstance();
ArrayList<boardDTO> list = dao.getSerchList(keyword);

%>

<h2>QnA 검색결과 </h2><hr />
<form action="serchQnAList.jsp" method="post">
	<input type="text" name="keyword" value="<%=keyword%>"><button type="submit">검색</button> 
</form>
<hr /> 
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