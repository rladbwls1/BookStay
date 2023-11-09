<%@page import="java.util.ArrayList"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@page import="hotel.bean.hotelDTO"%>
<%@page import="hotel.bean.MemberDAO"%>
<%@page import="hotel.bean.adminDTO"%>
<%@page import="hotel.bean.adminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>    
<link rel="stylesheet" href="/BookStay/resources/css/adminhotellist.css"/>      
<%@ include file="../views/main_bar.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
MemberDAO dao = MemberDAO.getInstance();
adminDAO adao = adminDAO.getInstance();
adminDTO dto1 = adao.getPreView();
int pageSize = 10; 
String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum="1";
}
int currentPage = Integer.parseInt(pageNum);
int start = (currentPage - 1) * pageSize + 1; 
int end = currentPage * pageSize; 
// 사용자 ID가 관리자 ID ("admin")와 일치하는지 확인
if (grade!=99) {
%>
<script>
    alert("관리자페이지입니다");
    window.location="/BookStay/views/main.jsp";
</script>
<%
}
int check = Integer.parseInt(request.getParameter("check"));
%>
<div id="list">
	<ul id="ul1">
	  <li><button id="bn1" type="button" onclick="window.location='/BookStay/admin/adminMain.jsp'">요약정보</button></li>
	  <li><button id="bn2" type="button" onclick="window.location='/BookStay/admin/adminlist.jsp?check=ing'">예약목록 </button></li>
	  <li><button id="bn3" type="button" onclick="window.location='/BookStay/board/notice.jsp'">공지사항 </button></li>
	  <li><button id="bn4" type="button" onclick="window.location='/BookStay/board/QnAList.jsp'">자주하는질문 </button></li>
	  <li><button id="bn5" type="button" onclick="window.location='/BookStay/board/myQuestion.jsp'">1:1문의[<%=dto1.getNoanswer() %>] </button></li>
	  <!-- 
	  <li><button id="bn6" type="button" onclick="window.location='/BookStay/hotel/hotelWriteForm.jsp'">숙박업소 글등록</button></li>
	   -->
	  <li><button id="bn6" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=2'">숙박업소 게시글 정보 </button></li>
	  <li><button id="bn7" type="button" onclick="window.location='/BookStay/admin/adminGradeList.jsp'">등급 관리/조회</button></li>
	</ul>
	<div id="f1">
	<div id="tbcal">
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link active" aria-current="page">숙박업소 게시글 정보</a>
	  </li>
	</ul>
	<div id="btn4">
	<% if(check == 2){ %>
<button id="chk" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=2'">등록완료된 숙소</button><hr />
<button class="d" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=1'">등록중인 숙소</button>
<button class="d" type="button" onclick="window.location='/BookStay/hotel/hotelWriteForm.jsp'">숙소 등록</button>
	<%}else{ %>
	<button class="d" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=2'">등록완료된 숙소</button><hr />
<button id="chk" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=1'">등록중인 숙소</button>
<button class="d" type="button" onclick="window.location='/BookStay/hotel/hotelWriteForm.jsp'">숙소 등록</button>
	<%} %>
	</div>
<table id="tb">
	<tr>
		<th>게시물번호</th><th>제목</th><th>주소</th><th>상태</th>
	</tr>
<%hotelDAO hdao = new hotelDAO();
  if(request.getParameter("check").equals("1")){
	  ArrayList<hotelDTO> list = hdao.getAdminHotelList();
	  for(hotelDTO d : list){
		%>
		<tr>
			<td><%=d.getNum()%></td>
			<td><a href="/BookStay/hotel/hotelContent.jsp?ref=<%=d.getRef()%>&room=1&adult=2&kids=0&select=1"><%=d.getTitle()%></a></td><td><%=d.getAddress() %></td>
			<td><button type="button" id="cg" class="btn" onclick="window.location='/BookStay/admin/adminStatusUpdate.jsp?ref=<%=d.getRef()%>&status=<%=d.getStatus()%>&check=true'">등록글 활성화</button>
			<button id="add" type="button" class="btn" onclick="window.location='/BookStay/hotel/hotelWriteForm.jsp?ref=<%=d.getRef()%>'">방등록</button>
			<button type="button" onclick="window.location.href='/BookStay/hotel/hotelDelete.jsp?num=<%=d.getNum()%>&re_step=<%=d.getRe_step()%>&ref=<%=d.getRef() %>'" class="btn btn-danger">삭제</button>
			</td>
		</tr>
		<%
	  }%>
		 </table>
	  <%
	  int count = hdao.count(0);
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
	 		%>	<a href="adminHotelList.jsp?check=<%=check %>&pageNum=<%=startPage-10 %>"><button class="button">이전</button></a>	
	 		<%}
	 		int p = Integer.parseInt(pageNum);
	 		for(int i = startPage; i <= endPage; i++){
	 			if(p == i){
	 		%> <a href="adminHotelList.jsp?check=<%=check %>&pageNum=<%=i %>"><button id="color" class="button"><%=i %></button></a>	
	 		<%}else{%>
	 		   <a href="adminHotelList.jsp?check=<%=check %>&pageNum=<%=i %>"><button class="button"><%=i %></button></a>
	 			<%}
	 		}
	 		if(endPage < pageCount){
	 		%>	<a href="adminHotelList.jsp?check=<%=check %>&pageNum=<%=startPage+10 %>"><button class="button">다음</button></a>	
	 		<%}
	 	}
	%>
	     </div>
<%	  
  }else if(request.getParameter("check").equals("2")){
	  ArrayList<hotelDTO> list = hdao.getClientHotelList(start, end);
	  for(hotelDTO d : list){
			%>
			<tr>
				<td><%=d.getNum()%></td><td><%=d.getTitle()%></td><td><%=d.getAddress() %></td>
<td><button type="button" class="btn btn-Secondary" onclick="window.location='/BookStay/admin/adminStatusUpdate.jsp?ref=<%=d.getNum()%>&status=<%=d.getStatus()%>&check=true'">등록글 비활성화</button>
				<button type="button" onclick="window.location.href='/BookStay/hotel/hotelDelete.jsp?num=<%=d.getNum()%>&re_step=<%=d.getRe_step()%>&ref=<%=d.getRef() %>'" class="btn btn-Warning">삭제</button></td>
			</tr>
			<%
		  }%>
	  </table>
	  <% 
	  int count = hdao.count(1);
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
	 		%>	<a href="adminHotelList.jsp?check=<%=check %>&pageNum=<%=startPage-10 %>"><button class="button">이전</button></a>	
	 		<%}
	 		int p = Integer.parseInt(pageNum);
	 		for(int i = startPage; i <= endPage; i++){
	 			if(p == i){
	 		%> <a href="adminHotelList.jsp?check=<%=check %>&pageNum=<%=i %>"><button id="color" class="button"><%=i %></button></a>	
	 		<%}else{%>
	 		   <a href="adminHotelList.jsp?check=<%=check %>&pageNum=<%=i %>"><button class="button"><%=i %></button></a>
	 			<%}
	 		}
	 		if(endPage < pageCount){
	 		%>	<a href="adminHotelList.jsp?check=<%=check %>&pageNum=<%=startPage+10 %>"><button class="button">다음</button></a>	
	 		<%}
	 	}
	 %>
	     </div>
<%  }
 
%>
</div>
</div>
</div>
