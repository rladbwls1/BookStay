<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDAO" %>
<%@ page import="hotel.bean.MemberDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.QuitMemberDTO" %>
<body>
    <!-- 다른 페이지 내용 -->
    
    <%
    // form.jsp 페이지에서 전달된 아이디와 비밀번호
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    MemberDAO memberDAO = new MemberDAO();

    // 위에서 작성한 메서드 호출
    boolean result = memberDAO.transferMemberData(id, pw);

    if (result) {
       %>
          <script>
             alert("지금까지 BookStay 를 사랑해주셔서 감사합니다");
             window.location="/BookStay/views/main.jsp";
          </script>
          
       <%
        /* out.println("회원 정보를 조회하고 다른 테이블에 성공적으로 인서트했으며, 원래 테이블에서 회원 정보를 삭제했습니다.");   예시 */
    } else {
             /*  out.println("회원 정보 조회, 인서트, 또는 삭제 중에 문제가 발생했습니다."); 예시 2*/
             
          %>   <script>
          alert("회원탈퇴실패했습니다 확인하고 다시부탁드립니다 ");
        window.location="/BookStay/member/deleteSelect.jsp";
          </script>
          
          <% 
    }
    %>
</body>
</html>