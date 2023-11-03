<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%response.setStatus(HttpServletResponse.SC_OK) ;%>
<style>

.page_404{ padding:40px 0; background:#fff; font-family: 'Arvo', serif;
}

.page_404  img{ width:100%;}

.four_zero_four_bg{
 
 background-image: url(https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif);
    height: 400px;
    background-position: center;
 }
 
 
 .four_zero_four_bg h1{
 font-size:80px;
 }
 
  .four_zero_four_bg h3{
			 font-size:80px;
			 }
			 
			 .link_404{			 
	color: #fff!important;
    padding: 10px 20px;
    background: #39ac31;
    margin: 20px 0;
    display: inline-block;}
	.contant_box_404{ margin-top:-50px;}
</style>
<head>
 
  
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css'>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Arvo'>
  
</head>

<body>

  <section class="page_404">
	<div class="container">
		<div class="row">	
		<div class="col-sm-12 ">
		<div class="col-sm-10 col-sm-offset-1  text-center">
		<div class="four_zero_four_bg">
			<h1 class="text-center ">404</h1>
		
		
		</div>
		
		<div class="contant_box_404">
		<h3 class="h2">
		죄송합니다. 해당 페이지를 찾을 수 없습니다.  
		</h3>
		
		<p>항상 더나은 서비스를 제공하기 위하여 최선을 다하겠습니다.</p>
		
		<a href="/BookStay/views/main.jsp" class="link_404">BookStay</a>
	</div>
		</div>
		</div>
		</div>
	</div>
</section>

