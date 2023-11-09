<%@page import="hotel.bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "hotel.bean.reviewDTO" %>
    <%@ page import = "hotel.bean.reviewDAO" %>
    <%@page import="java.util.List"%>
    
<html>
<head>
<%request.setCharacterEncoding("UTF-8"); 
  String id = (String)session.getAttribute("sid");
%>
    <style>
.flexbox {
			
			width: 500px;
			height: 115px;
			border-radius: 25px;
			border: solid 3px #D5D5D5;
			padding: 20px; 
			display: -webkit-flex;
			display: flex;
		}
		#wrap {
			-webkit-flex-wrap: wrap;
			flex-wrap: wrap;
		}
		#wrap_reverse {
			-webkit-flex-wrap: wrap-reverse;
			flex-wrap: wrap-reverse;
		}
		.item {
			
			width: 80px;
			height: 10px;
			margin: 10px;
			font-size: 15px;
			text-align: center;
			line-height: 50px;
		}
</style>



    <%
    String ref = request.getParameter("ref");
    reviewDAO dao = new reviewDAO();
    List<reviewDTO> reviews = dao.getReviewHotel(Integer.parseInt(ref));
    int iref = Integer.parseInt(request.getParameter("ref"));
    
%>
    <h2>호텔 리뷰</h2>
        <%
        for (reviewDTO review : reviews) {
        %>
        <div id="wrap" class="flexbox">
		<div class="item"><%= review.getId() %></div> 
		<div class="item"><%= review.getJumsu() %></div>
		<div class="item"><%= review.getContent() %></div> 
		<div class="item"><%= review.getReg() %></div> 
	</div>
	<h3></h3>
        <%
        }
        %>
        <%
        if(dao.checkStayedHotel(id,iref)) {%>
        <button class="btn btn-success" onclick="window.location='../review/reviewWriteForm?ref=<%=ref%>'">글작성</button>
        <%} %>
</body>
</html>
