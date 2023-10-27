<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<%@ page import="java.util.List" %> 

<%
	request.setCharacterEncoding("UTF-8");
    // 세션에서 사용자 ID 가져오기
    String id = (String) session.getAttribute("sid");
    
    // 사용자 ID가 관리자 ID ("admin")와 일치하는지 확인
    if (id == null || !id.equals("admin")) {
%>
    <script>
        alert("관리자페이지입니다");
        window.location="/BookStay/views/main.jsp";
    </script>
<%
    }
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
            <th>사용자 ID</th>
            <th>체크인</th>
            <th>체크아웃</th>
            <th>성인</th>
            <th>아이</th>
            <th>결제수단</th>
            <th>예약날짜</th>
        </tr>

        <%
            // Java 코드를 사용하여 예약 내역을 가져와서 표시
            List<HOrderDTO> reservationList = new HOrderDAO().getOrdersAdmin();
            MemberDAO memberDAO = MemberDAO.getInstance(); // MemberDAO 인스턴스 생성

            for (HOrderDTO reservation : reservationList) {
        %>
        <tr>
            <td><%= reservation.getRenum() %></td>
            <td><%= reservation.getId() %></td>
            <td><%= reservation.getCheckin() %></td>
            <td><%= reservation.getCheckout() %></td>
            <td><%= reservation.getAdult() %></td>
            <td><%= reservation.getKid() %></td>
            <td><%= reservation.getPaytype() %></td>
            <td><%= reservation.getReg() %></td>
        </tr>
        <%
            }
        %>
    </table>
    <input type="button" value="뒤로가기" onclick="location.href='../memeber/memberinfo.jsp'">
</body>
</html>