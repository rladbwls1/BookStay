<%@page import="hotel.bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "hotel.bean.reviewDTO" %>
    <%@ page import = "hotel.bean.reviewDAO" %>
    <%@page import="java.util.List"%>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    
<html>
<head>
<%request.setCharacterEncoding("UTF-8"); %>
    <style>
.flexbox {
			
			width: 500px;
			height: 125px;
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
			height: 15px;
			margin: 10px;
			font-size: 15px;
			text-align: center;
			line-height: 50px;
		}
</style>

    <title>호텔 리뷰 페이지</title>
</head>
<body>
<div style="margin:auto;text-align:center;">
    <h1>hotel review page</h1>

    <%
    String ref = request.getParameter("ref");
    reviewDAO dao = new reviewDAO();
    List<reviewDTO> reviews = dao.getReviewHotel(ref);
    
    
%>
    <h2>호텔 리뷰</h2>
    
            <p>평균 점수: <%= dao.getAvgJumsu(ref) %></p>    
        <%
        for (reviewDTO review : reviews) {
        %>
        
        <div id="wrap" class="flexbox" style="margin:auto;text-align:center;">
		<div class="item"><%= review.getId() %></div> 
		<div class="item"><%= review.getJumsu() %></div>
		<div class="item"><%= review.getContent() %></div> 
		<div class="item"><%= review.getReg() %></div> 
	</div>
	<h3></h3>
        <%
        }
        %>
        
        <button class="btn btn-success" onclick="window.location='/BookStay/review/reviewWriteForm.jsp?ref=<%=ref%>'">글작성</button>
        <input type="hidden" name="ref" value="<%= request.getParameter("ref") %>">
        </div>

</body>
</html>
