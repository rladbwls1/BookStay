<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<%@ page import="hotel.bean.hotelDAO" %>
<%@ page import="hotel.bean.hotelDTO" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="dao" class="hotel.bean.HOrderDAO" />
<jsp:useBean id="dto" class="hotel.bean.HOrderDTO" />

<!-- Import Bootstrap CSS and JavaScript -->
<link rel="stylesheet" href="/BookStay/resources/css/notice.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<%@ include file="../views/main_bar.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    String orderId = (String) session.getAttribute("sid");
    if (orderId != null) {
        List<HOrderDTO> orders = dao.getOrders(orderId);
        if (orders != null && !orders.isEmpty()) {
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 내역</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<style>
    .b-example-divider {
        position: fixed;
        top: 250;
        left: 0;
        height: 100%;
    }
    .table {
        width: 50%;
        height: 30%;
        margin: 0 auto;
    }
    table th, table td {
        text-align: center;
    }
    table th {
        width: 100px;
        height: 30px;
    }
    .table-container {
        display: flex;
        height: 0vh;
    }
</style>
<body>
    <div class="mx-auto p-2" style="width: 1000px;">
        <div style="left: 200;">
            <div class="h4 pb-2 mb-8 text-dark border-bottom border-dark">
                <h2>예약 내역</h2>
            </div>
        </div>
    </div>
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">예약 번호</th>
                    <th scope="col">체크인 날짜</th>
                    <th scope="col">체크아웃 날짜</th>
                    <th scope="col">예약 인원</th>
                    <th scope="col">아이</th>
                    <th scope="col">결제수단</th>
                    <th scope="col">호텔 이름</th>
                    <th scope="col">가격</th>
                    <th scope="col">진행상태</th>
                    <th scope="col">비고</th>
                </tr>
            </thead>
            <%
                hotelDAO hotelDAO = new hotelDAO();
                for (HOrderDTO order : orders) {
                    String etc = "";
                    if (order.getEtc() != null) {
                        etc = order.getEtc();
                    }
                    String status = "";
                    if (order.getState() == 0) {
                        status = "입금중";
                    } else if (order.getState() == 1) {
                        status = "입금완료";
                    } else if (order.getState() == 2) {
                        status = "예약취소";
                    }
                    String reg = new SimpleDateFormat("yyyy-MM-dd").format(order.getReg());
                    String checkin = order.getCheckin();
                    if (checkin.length() >= 11) {
                        checkin = checkin.substring(0, 11);
                    }
                    String checkout = order.getCheckout();
                    if (checkout.length() >= 11) {
                        checkout = checkout.substring(0, 11);
                    }
                    int ref = order.getRef();
                    hotelDTO hotelInfo = hotelDAO.getContentMain(ref);
                    String Title = hotelInfo.getTitle();
                    int price = hotelInfo.getPrice();
            %>
            <tr>
                <td><%= order.getRenum() %></td>
                <td><%= checkin %></td>
                <td><%= checkout %></td>
                <td>어른 : <%= order.getAdult() %> </td>
                <td> 아이 : <%= order.getKid() %></td>
                <td><%= order.getPaytype() %></td>
                <td><%= Title %></td>
                <td><%= price %></td>
                <td><%= status %></td>
                <td><%= etc %></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>
<%
        } else {
%>
<script>
    alert("예약 내역이 존재하지 않습니다.");
    window.location = "memberinfo.jsp";
</script>
<%
        }
    } else {
%>
<script>
    alert("세션이 만료되었거나 로그인하지 않았습니다. 다시 로그인해주세요.");
    window.location = "loginform.jsp";
</script>
<%
    }
%>