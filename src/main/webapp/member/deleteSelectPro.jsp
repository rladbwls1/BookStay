<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.MemberDAO" %> 
<%@ page import="hotel.bean.MemberDTO" %> 
   
<jsp:useBean id="Qdto" class="hotel.bean.QuitMemberDTO"/>
<jsp:useBean id="dto" class="hotel.bean.MemberDTO"/>

<jsp:useBean id="dao" class="hotel.bean.MemberDAO"/>
		<jsp:setProperty property="*" name="dto"/>
		
<% request.setCharacterEncoding("UTF-8"); %>

<%
 									//1030도준수정
    MemberDAO manager = MemberDAO.getInstance();

		String id=request.getParameter("id");
		String pw=request.getParameter("pw");
%>


<%System.out.println(id+pw);

int delete=MemberDAO.getInstance().delete(id,pw);%>
<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr> 
    <td height="39" align="center">
  </tr>
  <tr>
    <td align="center"> 
      <p>
        <% if (delete == 0) { %>
          <script>alert("탈퇴완료");
      	window.location="../views/main.jsp";
      	</script>
              		
        <% } else { %>
          <script>alert("어딘가 잘못되었습니다");
          
          window.location="/BookStay/member/deleteAndInsert.jsp";</script>
              			
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