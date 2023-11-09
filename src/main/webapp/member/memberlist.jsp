<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<%@ page import="hotel.bean.hotelDAO" %>
<%@ page import="hotel.bean.hotelDTO" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="dao" class="hotel.bean.HOrderDAO" />
<jsp:useBean id="dto" class="hotel.bean.HOrderDTO" />
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
<style>
body {
   padding-top: 20px; /* 페이지의 상단 여백을 늘립니다. */
}
.b-example-divider{
  position: fixed;
  top: 250; /* 원하는 위치 설정 */
  left: 0; /* 원하는 위치 설정 */
  height: 100%; /* 화면 높이만큼 설정 */
}
.table{
position: fixed;
}
</style>

<div class="col-md-3" style="width:200px; height:150px; border:100px; float:left; margin-left: 300px;">
<!-- 사이드 바 메뉴-->
  <!-- 패널 타이틀1 -->


</div>
 </div>
<div class="mx-auto p-2" style="width: 800px;">
<div class="w-200 p-1">
</div>
<div class="position-absolute top-50 start-50 translate-middle" style="width:800px; height:200px;">
<table class="table">
<div class="h4 pb-2 mb-8 text-dark border-bottom border-dark">
            <h2>예약 내역</h2>



            

  <thead>

    <tr>

      

      <th scope="col">예약 번호</th>

      <th scope="col">체크인 날짜</th>

      <th scope="col">체크아웃 날짜</th>

      <th scope="col">어른</th>

      <th scope="col">아이</th>

      <th scope="col">결제수단</th>

      <th scope="col">진행상태</th>

      <th scope="col">비고</th>

      <th scope="col">호텔 이름</th>

      <th scope="col">가격</th>

      

    </tr>

  </thead>



    <tr>

<%

            hotelDAO hotelDAO = new hotelDAO(); // 호텔 정보를 가져올 DAO 클래스의 인스턴스 생성

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

                String checkout = order.getCheckout();

                

                int ref = order.getRef();

                hotelDTO hotelInfo = hotelDAO.getContentMain(ref);

                String Title = hotelInfo.getTitle();

                int price = hotelInfo.getPrice();

%>

                <tr>

                    <td><%= order.getRenum() %></td>

                    <td><%= checkin %></td>

                    <td><%= checkout %></td>

                    <td><%= order.getKid() %>명</td>

                    <td><%= order.getAdult() %>명</td>

                    <td><%= order.getPaytype() %></td>

                    <td><%= status %></td>

                    <td><%= etc %></td>

                    <td><%= Title %></td> <!-- 호텔 이름 표시 -->

                    <td><%= price %>원 </td> <!-- 호텔 가격 표시 -->

                </tr>

<%

            }

%>

            </table>

            <input type="button" value="뒤로가기" onclick="location.href='memberinfo.jsp'">

            <a href="logout.jsp">로그아웃</a>

            </body>

<input type="button" class="btn btn-success" value="뒤로가기" onclick="location.href='memberinfo.jsp'">
<input type="button" class="btn btn-success" value="로그아웃" onclick="location.href='logout.jsp'">

</div>
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