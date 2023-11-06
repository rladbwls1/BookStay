<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<%@page import="hotel.bean.adminDAO"%>
<%@page import="hotel.bean.adminDTO"%>
<%@ page import="java.util.List" %> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/BookStay/resources/css/adminlist.css"/>
<%@ include file="../views/main_bar.jsp" %>
<%
	HOrderDAO dao2 = new HOrderDAO();
	int pageSize = 10; 
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum="1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1; 
	int end = currentPage * pageSize; 
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	if (grade!=99){
		 %>
		  <script>
		  	alert("관리자만 접근할수 있습니다.");
		  	window.location="../views/main.jsp";
		  </script>
	<%}else{%>
	<%
	adminDAO dao=adminDAO.getInstance();
	adminDTO dto1 = dao.getPreView();
%>
<div id="list">
	<ul id="ul1">
	  <li><button id="bn1" type="button" onclick="window.location='/BookStay/admin/adminMain.jsp'">요약정보</button></li>
	  <li><button id="bn2" type="button" onclick="window.location='/BookStay/admin/adminlist.jsp'">예약목록 </button></li>
	  <li><button id="bn3" type="button" onclick="window.location='/BookStay/board/notice.jsp'">공지사항 </button></li>
	  <li><button id="bn4" type="button" onclick="window.location='/BookStay/board/QnAList.jsp'">자주하는질문 </button></li>
	  <li><button id="bn5" type="button" onclick="window.location='/BookStay/board/myQuestion.jsp'">1:1문의[<%=dto1.getNoanswer() %>] </button></li>
	  <li><button id="bn6" type="button" onclick="window.location='/BookStay/hotel/hotelWriteForm.jsp'">숙박업소 글등록</button></li>
	</ul>
	<div id="f1">
	<div id="tbcal">
	<ul class="nav nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link active" aria-current="page">예약목록</a>
	  </li>
	</ul>
    <table id="table1">
        <tr>
            <th>예약 번호</th>
            <th>고객명</th>
            <th>투숙일</th>
            <th>접수일</th>
            <th>객실명</th>
            <th>결제수단</th>
            <th>총요금</th>
            <th>입금액</th>
            <th>잔액</th>
            <th>예약상태</th>
            <th>입금액입력</th>
            <th>예약취소</th>
            
        </tr>

        <%
            // Java 코드를 사용하여 예약 내역을 가져와서 표시
            List<HOrderDTO> reservationList = dao2.getOrdersAdmin(start, end);
            MemberDAO memberDAO = MemberDAO.getInstance(); // MemberDAO 인스턴스 생성

            for (HOrderDTO reservation : reservationList) {
            	String reg = new SimpleDateFormat("yyyy-MM-dd").format(reservation.getReg());
            	String checkin = reservation.getCheckin().substring(0,11);
            	String checkout = reservation.getCheckout().substring(0,11);
        %>
        <tr>
            <td><%= reservation.getRenum() %></td>
            <td><%= reservation.getName() %></td>
            <td><%= checkin %></td>
            <td><%= reg %></td>
            <td><%= reservation.getAdult() %></td>
            <td><%= reservation.getKid() %></td>
            <td><%= reservation.getPaytype() %></td>
            <td><%= reg %></td>
            <td><%= reservation.getKidcount() %></td>
            <td><%= reservation.getState() %></td>
            <td><button type="button" class="btn btn-secondary">입금금액</button></td>
            <td><button type="button" class="btn btn-danger">취소금액</button></td>
        </tr>
        <%
            }
        %>
    </table>
<%
int count = dao2.count();
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
		%>	<a href="adminlist.jsp?pageNum=<%=startPage-10 %>"><button class="button">이전</button></a>	
		<%}
			int p = Integer.parseInt(pageNum);
			for(int i = startPage; i <= endPage; i++){
				if(p == i){
		%> <a href="adminlist.jsp?pageNum=<%=i %>"><button id="color" class="button"><%=i %></button></a>	
		<%}else{%>
			<a href="adminlist.jsp?pageNum=<%=i %>"><button class="button"><%=i %></button></a>	
		<%}}
		if(endPage < pageCount){
		%>	<a href="adminlist.jsp?pageNum=<%=startPage+10 %>"><button class="button">다음</button></a>	
		<%}
	}
%>
    </div>
</div>
</div>
<%}%>