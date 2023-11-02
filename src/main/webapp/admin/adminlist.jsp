<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<%@ page import="java.util.List" %> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	
%>
<!DOCTYPE html>
<html>
<body>
<div id="block2">
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
    <input type="button" value="뒤로가기" onclick="location.href='../memeber/memberinfo.jsp'">
</div>
</body>
</html>