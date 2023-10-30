
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<jsp:useBean id="member" class="hotel.bean.MemberDTO" >
<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<% request.setCharacterEncoding("UTF-8"); %>

<%
 									//1030도준수정
    MemberDAO manager = MemberDAO.getInstance();
		String pw=request.getParameter("pw");
	 String email = request.getParameter("email");
   String addr = request.getParameter("addr");
   String pnum = request.getParameter("pnum");

%>

  
<% System.out.println(pw+","+email+","+addr+","+pnum); 
 String updateResult=MemberDAO.getInstance().updateMember2(pw,email,addr,pnum);%>
<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr> 
    <td height="39" align="center">
  </tr>
  <tr>
    <td align="center"> 
      <p>
        <% if (updateResult == null) { %>
          <script>alert("수정이 잘되었습니다");
      	window.location="../views/main.jsp";
      	</script>
              		
        <% } else { %>
          <script>alert("어딘가 잘못되었습니다");
          
          window.location="/BookStay/member/updateFirst.jsp";</script>
              			
        <% } %>
      </p>
    </td>
  </tr>
  <tr>
    <td> 
      <form>
        <input type="button" value="메인으로" onclick="window.location='../views/main.jsp'">
      </form>
    </td>
  </tr>
</table>