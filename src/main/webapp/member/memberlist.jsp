<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<%@ page import="hotel.bean.hotelDAO" %>
<%@ page import="hotel.bean.hotelDTO" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="dao" class="hotel.bean.HOrderDAO" />
<jsp:useBean id="dto" class="hotel.bean.HOrderDTO" />

<link rel="stylesheet" href="/BookStay/resources/css/notice.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<%@ include file="../views/main_bar.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    String orderId = (String) session.getAttribute("sid");
%>

<%
    int pageSize = 10; 
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    int currentPage = Integer.parseInt(pageNum);
    int start = (currentPage - 1) * pageSize + 1;
    int end = currentPage * pageSize;
    if (orderId != null) {
        List<HOrderDTO> orders = dao.getHOrders(orderId, start, end); 
        if (orders != null && !orders.isEmpty()) {
           
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>예약 내역</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<style>
    
    .table {
        width: 50%;
        margin: 0 auto;
    }
    table th, table td {
        text-align: center;
    }
    table th {
        width: 100px;
        height: 30px;
    }
    .pagination-container {
        text-align: center; /* 가운데 정렬 */
        position: relative;
        bottom: 10px; /* 원하는 위치로 조절 (10px은 예시) */
        background-color: #fff; /* 배경색 설정 */
        padding: 10px; /* 원하는 여백을 설정하세요 */
        z-index: 1; /* 다른 내용과 겹치지 않도록 함 */
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
    <div class="pagination-container">
<%
int count = dao.count(id);
if (count > 0) {
    int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
    int pageBlock = 3;  // 페이지 번호가 2개씩 넘어갑니다.

    int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
    int endPage = startPage + pageBlock - 1;

    if (endPage > pageCount) {
        endPage = pageCount;
    }

    if (startPage > 1) {
%>
<a  class="btn btn-secondary" href="memberlist.jsp?pageNum=<%=startPage-2 %>">이전</a>
<%
    }

    for (int i = startPage; i <= endPage; i++) {
%>
<a  class="btn btn-secondary" href="memberlist.jsp?pageNum=<%=i %>"><%=i %></a>
<%
    }

    if (endPage < pageCount) {
%>
<a  class="btn btn-secondary" href="memberlist.jsp?pageNum=<%=endPage+1 %>">다음</a>
<%
    }
}
%>








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