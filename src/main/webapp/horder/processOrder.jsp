<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="org.apache.catalina.tribes.group.InterceptorPayload"%>
<%@page import="hotel.bean.MemberDTO"%>
<%@page import="hotel.bean.hotelDAO"%>
<%@page import="hotel.bean.hotelDTO"%>
<%@page import="hotel.bean.MemberDAO"%>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<%@page import="java.sql.Timestamp"%>
<link rel="stylesheet" href="/BookStay/resources/css/processorder.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<%@ include file="../views/main_bar.jsp" %>
    <%
        // 예약 정보 가져오기
 if(grade==11){
    %>
    <script>
       alert("로그인을 먼저해주세요");
       window.location="BookStay/views/main.jsp";
    </script>
    <%
 }

        String datetimes = request.getParameter("datetimes");
        System.out.println(datetimes);
        String checkin=datetimes.substring(0,10);
        String checkout=datetimes.substring(13);
        String checkinY=datetimes.substring(0,4);
        String checkinM=datetimes.substring(6,7);
        String checkinD=datetimes.substring(9,10);
        String checkoutY=datetimes.substring(13,17);
        String checkoutM=datetimes.substring(19,20);
        String checkoutD=datetimes.substring(22,23);
        System.out.println(checkin);
        System.out.println(checkout);
        int adult = 0;
        int kid = 0;
        int state = 0;
        String paytype = request.getParameter("paytype");
      
        
        
        try {
            if (request.getParameter("adult") != null && !request.getParameter("adult").isEmpty()) {
                adult = Integer.parseInt(request.getParameter("adult"));
            } else {
                
                throw new Exception("성인(adult) 수가 누락되었습니다.");
            }
            
            if (request.getParameter("kid") != null && !request.getParameter("kid").isEmpty()) {
                kid = Integer.parseInt(request.getParameter("kid"));
            } else {
                
                throw new Exception("어린이(kid) 수가 누락되었습니다.");
            }
            
            
        } catch (NumberFormatException e) {
            // 숫자로 변환할 수 없는 경우
            out.println("<h1>숫자 형식으로 입력해야 하는 항목이 올바르지 않습니다.</h1>");
            e.printStackTrace();
        } catch (Exception e) {
            // 누락된 항목이 있는 경우
            out.println("<h1>" + e.getMessage() + "</h1>");
            e.printStackTrace();
        }
        HOrderDTO order = new HOrderDTO();
        HOrderDAO dao = new HOrderDAO();
          MemberDTO mdto = mdao.myInfo(id);
        
        hotelDAO hdao = new hotelDAO();
        hotelDTO dto = hdao.getContentMain(Integer.parseInt(request.getParameter("ref")));
        hotelDTO hdto = hdao.getContentMain(Integer.parseInt(request.getParameter("num")));
        String item_name=dto.getTitle()+"("+hdto.getRoomtype()+")";
        String name = mdto.getName();
        order.setId(id);
        order.setRef(Integer.parseInt(request.getParameter("num")));
        order.setCheckin(checkin);
        order.setCheckout(checkout);
        order.setAdult(adult);
        order.setKid(kid);
        order.setPaytype(paytype);
        order.setName(name);
        // 예약 정보 객체 생성
        if(dao.insertOrder(order)==0){ 
%>
        	<script>
        		alert("예약이 정상적으로 처리되지않았습니다. 다시한번 확인해주세요");
        		window.location="/BookStay/views/main.jsp";
        	</script>
        	<%
        }else{
        int renum = dao.getRecentOrder(id);
        
        %>
        <div id="list">
        <h2>카드 결제</h2>
        <form id="form" action="cardProcess.jsp" method="post">
        <input type="hidden" name="partner_order_id" value="<%=renum%>">
        <input type="hidden" name="partner_user_id" value="<%=id%>">
        <input type="hidden" name="item_name" value="<%=item_name%>">
        <input type="hidden" name="total_amount" value="<%=hdto.getPrice()%>">
        <input type="hidden" name="paytype" value="<%=paytype%>">
       <table id="tb">
             <tr>
                <td class="title">호텔명</td>
                <td class="an"><%=item_name%></td>
             </tr>
             <tr>
                <td class="title">예약일</td>
                <td class="an"><%=checkinY%>년 <%=checkinM%>월 <%=checkinD%>일 ~ <%=checkoutY%>년 <%=checkoutM%>월 <%=checkoutD%>일</td>
             </tr>
             <tr>
                <td class="title">고객명</td>
                <td class="an"><%=mdto.getName()%></td>
             </tr>
             <tr>
                <td class="title">연락처</td>
                <td class="an"><%=mdto.getPnum()%></td>
             </tr>
             <tr>
                <td class="title">인원수</td>
                <td class="an">어른 : <%=adult %>명 아이 : <%=kid %>명</td>
             </tr>
             <tr>
                <td class="title">총 금액</td>
                <td class="an"><%=hdto.getPrice()%>원</td>
             </tr>
       </table>
       <div class="btn8">
       <button id="btn" type="button" onclick="history.go(-1)">뒤로가기</button>
       <button id="btn2" type="button" onclick="location.href='/BookStay/views/main.jsp'">홈화면</button>
       <%if(paytype.equals("cash")){  %>
       <button id="btn1" type="button" onclick="location.href='accountNum.jsp?renum=<%=renum%>'">현금(계좌이체) 결제</button>
        <%}else if(paytype.equals("card")) {%>
       <button id="btn1" type="submit">카드 결제</button>
       </div>
       <%} %>
       </form>
       <%} %>
       </div>
