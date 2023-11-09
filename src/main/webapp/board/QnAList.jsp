<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.boardDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hotel.bean.boardDAO"%>
<%@page import="hotel.bean.adminDAO"%>
<%@page import="hotel.bean.adminDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<jsp:useBean id="dto" class="hotel.bean.boardDTO"/>
<link rel="stylesheet" href="/BookStay/resources/css/qnalist.css"/>
<%
request.setCharacterEncoding("UTF-8");
boardDAO dao = boardDAO.getInstance();
int category = 20;	
if(request.getParameter("category")!=null){
	category = Integer.parseInt(request.getParameter("category"));
}
int pageSize = 10; 
String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum="1";
}
int currentPage = Integer.parseInt(pageNum);
int start = (currentPage - 1) * pageSize + 1; 
int end = currentPage * pageSize; 
ArrayList<boardDTO> list = dao.getList(category, start, end);
adminDAO dao1=adminDAO.getInstance();
adminDTO dto1 = dao1.getPreView();
%>
<%@ include file="../views/main_bar.jsp" %>
<div id="list">
	<ul id="ul1">
	  <%if(grade==99){ %>
	  <li><button id="bn1" type="button" onclick="window.location='/BookStay/admin/adminMain.jsp'">요약정보</button></li>
	  <li><button id="bn2" type="button" onclick="window.location='/BookStay/admin/adminlist.jsp?check=ing'">예약목록 </button></li>
	  <li><button id="bn3" type="button" onclick="window.location='/BookStay/board/notice.jsp'">공지사항 </button></li>
	  <li><button id="bn4" type="button" onclick="window.location='/BookStay/board/QnAList.jsp'">자주하는질문 </button></li>
	  <li><button id="bn5" type="button" onclick="window.location='/BookStay/board/myQuestion.jsp'">1:1문의[<%=dto1.getNoanswer() %>] </button></li>
	  <li><button id="bn6" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=2'">숙박업소 게시글 정보 </button></li>
	  <li><button id="bn7" type="button" onclick="window.location='/BookStay/admin/adminGradeList.jsp'">등급 관리/조회</button></li>
	<%}else if(grade==11 || grade==0){ %>
	 <li><button id="bn3" type="button" onclick="window.location='/BookStay/board/notice.jsp'">공지사항 </button></li>
	  <li><button id="bn4" type="button" onclick="window.location='/BookStay/board/QnAList.jsp'">자주하는질문 </button></li>
	<%} %>
	</ul>
	<div id="f1">
	<div id="tbcal">
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link active" aria-current="page">자주하는질문</a>
	  </li>
	</ul>
<form id="form" action="serchQnAList.jsp" method="post">
	<input id="text" type="text" name="keyword"><button id="sBtn" type="submit">검색</button> 
</form>

<div id="all">
	<div id="cateBtn">
	<a id="c1" href="QnAPro.jsp?category=20" >전체</a>
	<a id="c2" href="QnAPro.jsp?category=21" >예약</a>
	<a id="c3" href="QnAPro.jsp?category=22" >체크인</a>
	<a id="c4" href="QnAPro.jsp?category=23" >검색</a>
	<a id="c5" href="QnAPro.jsp?category=24" >계정</a>
	<a id="c6" href="QnAPro.jsp?category=25" >기타</a>
	</div>
		<%for(boardDTO d : list){	%>
		<div class="board-item">
			<div class="board">
			<a class="c3" href="javascript:void(0);" onclick="toggleContent('content_<%=d.getNum()%>')"><%=d.getTitle() %></a>
			<%if(grade==99){ %>
			<button class="c1" onclick="window.location='boardUpdateForm.jsp?num=<%=d.getNum()%>&category=<%=d.getCategory()%>'">수정</button>
			<button class="c2" onclick="window.location='boardDelete.jsp?num=<%=d.getNum()%>&category=<%=d.getCategory()%>'">삭제</button><br />
			<%} %>
			</div>
			<div class="content" id="content_<%=d.getNum()%>" style="display: none"><%=d.getContent()%></div>
		</div>
		<%} %>
		<br>
		<% 
if(grade==99){
	%>
	<button id="c8" type="button" onclick="window.location='writeForm.jsp'">QnA글 작성</button>
	<%
}%>
 <% 
 if(category == 20){
 int count = dao.count();
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (int)(currentPage/10)*10+1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		%>
		<div id="page">
		<%
		if(startPage > 10){
		%>	<a href="QnAList.jsp?&pageNum=<%=startPage-10%>"><button class="button">이전</button></a>	
		<%}
		int p = Integer.parseInt(pageNum);
		for(int i = startPage; i <= endPage; i++){
			if(p == i){
		%> <a href="QnAList.jsp?&pageNum=<%=i %>"><button id="color" class="button"><%=i %></button></a>	
		<%}else{%>
		   <a href="QnAList.jsp?&pageNum=<%=i %>"><button class="button"><%=i %></button></a>
			<%}
		}
		if(endPage < pageCount){
		%>	<a href="QnAList.jsp?&pageNum=<%=startPage+10 %>"><button class="button">다음</button></a>	
		<%}
	}
 }
%>
</div>
</div>
</div>
</div>
</div>	
<script>
function toggleContent(contentId) {
    var contentDiv = document.getElementById(contentId);
    contentDiv.classList.add('con');
    var contents =document.getElementsByClassName("content");
    if (contentDiv.style.display === "none") {
    	for(var i=0; i<contents.length;i++){
        	var content = contents.item(i);
        	content.style.display="none";	
    	}
    	contentDiv.style.display="block";
    }else{
    	for(var i=0; i<contents.length;i++){
        	var content = contents.item(i);
        	content.style.display="none";	
    }
    }
}
    
</script>
<script>
var num = <%=category%>;
var c1 = document.getElementById("c1");
var c2 = document.getElementById("c2");
var c3 = document.getElementById("c3");
var c4 = document.getElementById("c4");
var c5 = document.getElementById("c5");
var c6 = document.getElementById("c6");
if (num == 20) {
    c1.classList.add("on");
} else {
    c1.classList.remove("on");
}
if (num == 21) {
    c2.classList.add("on");
} else {
    c2.classList.remove("on");
}
if (num == 22) {
    c3.classList.add("on");
} else {
    c3.classList.remove("on");
}
if (num == 23) {
    c4.classList.add("on");
} else {
    c4.classList.remove("on");
}
if (num == 24) {
    c5.classList.add("on");
} else {
    c5.classList.remove("on");
}
if (num == 25) {
    c6.classList.add("on");
} else {
    c6.classList.remove("on");
}
</script>




