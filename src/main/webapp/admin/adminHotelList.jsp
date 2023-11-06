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
// 사용자 ID가 관리자 ID ("admin")와 일치하는지 확인
if (grade!=99) {
%>
<script>
    alert("관리자페이지입니다");
    window.location="/BookStay/views/main.jsp";
</script>
<%
}
%>
<div id="list">
	<ul id="ul1">
	  <li><button id="bn1" type="button" onclick="window.location='/BookStay/admin/adminMain.jsp'">요약정보</button></li>
	  <li><button id="bn2" type="button" onclick="window.location='/BookStay/admin/adminlist.jsp'">예약목록 </button></li>
	  <li><button id="bn3" type="button" onclick="window.location='/BookStay/board/notice.jsp'">공지사항 </button></li>
	  <li><button id="bn4" type="button" onclick="window.location='/BookStay/board/QnAList.jsp'">자주하는질문 </button></li>
	  <li><button id="bn5" type="button" onclick="window.location='/BookStay/board/myQuestion.jsp'">1:1문의[<%=dto1.getNoanswer() %>] </button></li>
	  <!-- 
	  <li><button id="bn6" type="button" onclick="window.location='/BookStay/hotel/hotelWriteForm.jsp'">숙박업소 글등록</button></li>
	   -->
	  <li><button id="bn6" type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=1'">숙박업소 게시글 정보 </button></li>
	  <li><button id="bn7" type="button" onclick="window.location='/BookStay/admin/adminGradeList.jsp'">등급 관리/조회</button></li>
	</ul>
	<div id="f1">
	<div id="tbcal">
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link active" aria-current="page">숙박업소 게시글 정보</a>
	  </li>
	</ul>
<button type="button" onclick="window.location='/BookStay/hotel/hotelWriteForm.jsp'">숙소 등록</button>
<button type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=1'">등록중인 숙소</button>
<button type="button" onclick="window.location='/BookStay/admin/adminHotelListPro.jsp?check=2'">등록완료된 숙소</button><hr />
<table>
	<tr>
		<td>게시물번호</td><td>제목</td><td>주소</td><td>상태</td>
	</tr>
<%hotelDAO hdao = new hotelDAO();
  if(request.getParameter("check").equals("1")){
	  ArrayList<hotelDTO> list = hdao.getAdminHotelList();
	  for(hotelDTO d : list){
		%>
		<tr>
			<td><%=d.getNum()%></td>
			<td><a href="/BookStay/hotel/hotelContent.jsp?ref=<%=d.getRef()%>"><%=d.getTitle()%></a></td><td><%=d.getAddress() %></td>
			<td><button type="button" onclick="window.location='/BookStay/admin/adminStatusUpdate.jsp?ref=<%=d.getRef()%>&status=<%=d.getStatus()%>'">등록글 활성화</button>
			<button type="button" onclick="window.location='hotelWriteForm.jsp?ref=<%=d.getRef()%>'">방등록</button>
			</td>
		</tr>
		<%
	  }
	  
	  
  }else if(request.getParameter("check").equals("2")){
	  ArrayList<hotelDTO> list = hdao.getClientHotelList();
	  for(hotelDTO d : list){
			%>
			<tr>
				<td><%=d.getNum()%></td><td><%=d.getTitle()%></td><td><%=d.getAddress() %></td>
				<td><button type="button" onclick="window.location='/BookStay/admin/adminStatusUpdate.jsp?ref=<%=d.getRef()%>&status=<%=d.getStatus()%>'">등록글 비활성화</button></td>
			</tr>
			<%
		  }
  }
 
%>
 </table>
</div>
</div>
</div>
