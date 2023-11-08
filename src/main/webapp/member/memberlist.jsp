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



<html>



    <meta charset="UTF-8">

    <title>예약 내역</title>

    <head>

     <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<style>

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

<body>



<div class="b-example-divider">



<div class="d-flex flex-column flex-md-row p-4 gap-4 py-md-5 align-items-center">

  <div class="dropdown-menu d-block position-static pt-0 mx-0 rounded-3 shadow overflow-hidden w-280px" data-bs-theme="light">

    <form class="p-2 mb-2 bg-body-tertiary border-bottom">

      <input type="search" class="form-control" autocomplete="false" placeholder="Type to filter...">

    </form>

    <ul class="list-unstyled mb-0">

      <li><a class="dropdown-item d-flex align-items-center gap-2 py-2" href="#">

        <span class="d-inline-block bg-success rounded-circle p-1"></span>

        Action

      </a></li>

      <li><a class="dropdown-item d-flex align-items-center gap-2 py-2" href="#">

        <span class="d-inline-block bg-primary rounded-circle p-1"></span>

        Another action

      </a></li>

      <li><a class="dropdown-item d-flex align-items-center gap-2 py-2" href="#">

        <span class="d-inline-block bg-danger rounded-circle p-1"></span>

        Something else here

      </a></li>

      <li><a class="dropdown-item d-flex align-items-center gap-2 py-2" href="#">

        <span class="d-inline-block bg-info rounded-circle p-1"></span>

        Separated link

      </a></li>

    </ul>

  </div>

</div>

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

      <th scope="col">예약 인원</th>

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

                String checkin = order.getCheckin().substring(0, 11);

                String checkout = order.getCheckout().substring(0, 11);

                

                int ref = order.getRef();

                hotelDTO hotelInfo = hotelDAO.getContentMain(ref);

                String Title = hotelInfo.getTitle();

                double price = hotelInfo.getPrice();

%>

                <tr>

                    <td><%= order.getRenum() %></td>

                    <td><%= checkin %></td>

                    <td><%= checkout %></td>

                    <td>어른 : <%= order.getKid() %> </td>

                    <td> 아이 : <%= order.getAdult() %></td>

                    <td><%= order.getPaytype() %></td>

                    <td><%= status %></td>

                    <td><%= etc %></td>

                    <td><%= Title %></td> <!-- 호텔 이름 표시 -->

                    <td><%= price %></td> <!-- 호텔 가격 표시 -->

                </tr>

<%

            }

%>

            </table>

            <input type="button" value="뒤로가기" onclick="location.href='memberinfo.jsp'">

            <a href="logout.jsp">로그아웃</a>

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