<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/BookStay/resources/css/payment.css"/>
<%@ include file="../views/main_bar.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userId = (String) session.getAttribute("sid"); 

    if (userId != null) {
        MemberDTO user = dao.myInfo(userId); 
        
        if (user != null) {
			String checkin = request.getParameter("checkin");

        	String checkout = request.getParameter("checkout");
        	String title = request.getParameter("title");
        	int adult = Integer.parseInt(request.getParameter("adult"));
        	int kids = Integer.parseInt(request.getParameter("kids"));
                 
%>
	<div id="list">
            <h2><%=title %> 예약</h2>
        <form id="form1" action="processOrder.jsp" class="form-horizontal" method="post">
            
          
                    <input name="id" type="hidden" value="<%=userId%>"/>
                    <input name="ref" type="hidden" value="<%=request.getParameter("ref")%>">
                    <input name="num" type="hidden" value="<%=request.getParameter("num")%>">
            
          <table id="tb">
          <tr>
	<td class="title">예약일</td>
          	<td><input type="text" name="datetimes" value="<%=checkin %> - <%=checkout %>" /></td>
          </tr>
          <tr>
          	<td class="title">성인 예약 인원</td>
          	<td><input name="adult" type="number" value="<%=adult%>"/></td>
          </tr>
          <tr>
          	<td class="title">아이 예약 인원</td>
          	<td> <input name="kid" type="number" value="<%=kids%>"/></td>
          </tr>
          <tr>
          	<td class="title">결제 방식</td>
          	<td> <select id="sel" name="paytype">
                    	<option value="card" selected>카드</option>
                    	<option value="cash">현금(계좌이체)</option>
                    </select></td>
          </tr>
            </table>
            <div class="btn8">
                    <input type="submit" id="btn" class="btn btn8 btn-primary" value="다음" />
                    <button type="button" id="btn1" class="btn btn8 btn-secondary" role="button"> 취소 </button>
            <div class="btn">
                    <input type="submit" id="btn" class="btn btn-primary" value="다음" />
                    <button type="button" id="btn1" class="btn btn-secondary" role="button"> 취소 </button>
	</div>
        </form>
                </div>
<% 	
            
    } else {
%>
<script>
    alert("사용자 정보를 가져오는 중 오류가 발생했습니다.");
    window.location = "/BookStay/member/loginform.jsp";
</script>
<%
    }
    } else {
%>
<script>
    alert("세션이 만료되었거나 로그인하지 않았습니다. 다시 로그인해주세요.");
    window.location = "/BookStay/member/loginform.jsp";
</script>
<%
    }
%>
<script src="/BookStay/resources/js/date.js"></script>
<script>
    document.getElementById('btn1').addEventListener('click', function() {
      history.back(); 
    });
 </script>
