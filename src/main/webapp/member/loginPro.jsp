<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@page import="hotel.bean.MemberDTO"%> 
<%@page import="hotel.bean.MemberDAO"%>
    <jsp:useBean id="dao" class="hotel.bean.MemberDAO"/>
    <jsp:useBean id="dto" class="hotel.bean.MemberDTO"/>

    <jsp:setProperty property="*" name="dto"/>

<%
	String sid=(String)session.getAttribute("sid");
	request.setCharacterEncoding("UTF-8");
	
	Cookie [] cookies = request.getCookies();
	
	

	for(Cookie c : cookies){
	if(c.getName().equals("cid")){dto.setId(c.getValue());}
	if(c.getName().equals("cpw")){dto.setPw(c.getValue());}
	if(c.getName().equals("cauto")){dto.setCauto(c.getValue());}
	
	
}
	boolean result= dao.loginCheck(dto);
    
    
    	if(result==true){
    		if (request.getParameter("cauto") == null) {
    		    // 로그인 정보를 세션에 저장
    		    session.setAttribute("sid", dto.getId());
    		} else {
    		    // 로그인 정보를 쿠키에 저장
    		    Cookie c1 = new Cookie("cid", dto.getId());
    		    Cookie c2 = new Cookie("cpw", dto.getPw());
    		    Cookie c3 = new Cookie("cauto", dto.getCauto());
    		    c1.setMaxAge(60 * 60 * 24 * 2);
    		    c2.setMaxAge(60 * 60 * 24 * 2);
    		    c3.setMaxAge(60 * 60 * 24 * 2);
    		    response.addCookie(c1);
    		    response.addCookie(c2);
    		    response.addCookie(c3);
    		}
    			session.setAttribute("sid", dto.getId());
    			MemberDAO mdao = new MemberDAO();
    			int grade=mdao.checkGrade(dto.getId());
    			if(grade==81){
    			%>
    			<script>
    				if(confirm("휴먼계정입니다. 비밀번호를 변경하여 휴먼해제 하시겠습니까?")){
    					window.location="/BookStay/member/updateFirst.jsp";
    				}else{
    					window.location="/BookStay/member/logout.jsp";
    				}
    			      </script>
    			      <%
    			              } else {
    			                  response.sendRedirect("/BookStay/views/main.jsp");
    			              }
    			          } else {
    			              // 로그인 실패
    			              request.setAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다. 다시 확인하세요.");
    			              RequestDispatcher dispatcher = request.getRequestDispatcher("loginform.jsp");
    			              //잘모르지만  RequestDispatcher이건 주로 서블릿사용할떄 자주 사용한다고한다 .그리고 현재 요청(request)의
    			              //getRequestDispatcher 메서드를 호출하여 loginform2.jsp라는 JSP 페이지로의 RequestDispatcher 객체를 가져옵니다. 
    			              //이것은 지정된 JSP 페이지로의 포워딩(forwarding)을 위한 RequestDispatcher를 얻는 것을 의미합니다.
    			              //포워딩은...또 무엇이냐 요청해서 전달하거나 리다이렉션하는것말한다고한다 
    			              //익숙한  Redirection 이있고 , 위에서 사용하는 RequestDispatcher 의   서블릿 포워딩 (Servlet Forwarding)라는방식이있다고한다 
    			              dispatcher.forward(request, response);
    			          }
    			      %>