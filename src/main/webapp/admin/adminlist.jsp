<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<%@ page import="hotel.bean.MemberDTO" %> 
<%@ page import="hotel.bean.MemberDAO" %>
<%@ page import="java.util.List" %> 

<%
	request.setCharacterEncoding("UTF-8");
    // 세션에서 사용자 ID 가져오기
    MemberDAO dao = MemberDAO.getInstance();
    String sid = (String) session.getAttribute("sid");
    int id= dao.checkGrade(sid);
    // 사용자 ID가 관리자 ID ("admin")와 일치하는지 확인
    if (id!=99) {
%>
    <script>
        alert("관리자페이지입니다");
        window.location="/BookStay/views/main.jsp";
    </script>
<%
    }
%>
<%

SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	
%>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 예약 확인</title>
</head>
<body>

    <h1>관리자 예약 내역 확인</h1>
    <table>
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
            List<HOrderDTO> reservationList = new HOrderDAO().getOrdersAdmin();
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
        </tr>
        <%
            }
        %>
    </table>
    <input type="button" value="뒤로가기" onclick="location.href='../admin/adminMain.jsp'">
</body>
</html>