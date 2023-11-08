<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hotel.bean.MemberDTO" %>
<%@ page import="hotel.bean.MemberDAO" %>

<jsp:useBean id="dao" class="hotel.bean.MemberDAO" />
<jsp:useBean id="dto" class="hotel.bean.MemberDTO" />
<%@ include file="../views/main_bar.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<jsp:setProperty property="*" name="dto" />
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Recovery</title>
    <style>
        /* 본문에 제공된 CSS 스타일 추가 */
      /* 2023.11.07  그냥  내부 css 로  변경 */


        .table-container {
        
   			
            font-family: Arial, sans-serif;
            background-color: #F2F2F2;
            margin: 0;
            padding: 0;
            text-align: center;
            margin: 150px auto;
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top:100px;
            width:30%;
            
        }
        .mainTable{
             margin-top:50px;
        
        }

        h2 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
        }

        th {
            background-color: #333;
            color: #fff;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        

        input[type="button"] {
            width:30%;
            height:40px;
            background-color: #198754;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            margin: 0 6px;
            cursor: pointer;
        }

        input[type="button"]:hover {
            background-color: #157347;
        }
      
    
        	
        } 
        /* .mainTable{
        	color:#787878;
        	 
        }
            */
    
    
    
     /* 2023.11.07  그냥  내부 css 로  변경 */
        /*모달*/
        
         <!--  아이디찾기 모달 -->
        .modal {
            display: none;
            border-radius: 10px;
            position: absolute;     
            height: 100%;   
           
        }
			     .modal-content {
			    border: 2px solid gray;
			    position: relative;
			    border-radius: 10px;
			    background-color: white;
			    height: 400px; /* 원하는 높이로 설정 */
			    width: 400px; /* 원하는 너비로 설정 */
			       top:-600px;
			    left:100px;
			}
        .close {
            position: absolute;
            top: -10px;
            right: 0;
            cursor: pointer;
            color: #198754;
            font-size: 25px;
            text-align: center;
        }

        .close:hover {
            font-weight: bold;
        }
      .modalsumitinput {
	margin-top:10px;
margin-bottom:10px;
    width:30%;
    background-color: #198754;
    height: 40px;
    border-radius: 8px;
    color: white;
    border: none;
    cursor: pointer;
}    
.modalsumitinput:hover {
    background-color: #157347;
}
         <!--  비밀번호 찾기 모달 -->
        .modal2{
            display: none;
            position: fixed;
            transform: translate(-50%, -50%);
            border-radius: 10px;
        } 
        
        .modal-content2 {
	    border: 2px solid gray;
	    position: relative;
	    border-radius: 10px;
	    background-color: white;
	    height: 500px; /* 원하는 높이로 설정 */
	    width: 400px; /* 원하는 너비로 설정 */
	  top:-600px;
	    left:100px;
	}
        .close2 {
            position: absolute;
            top: -10px;
            right: 0;
            cursor: pointer;
            color: #198754;
            font-size: 25px;
            text-align: center;
        }
        .close2:hover {
            font-weight: bold;
        }
    </style>
  
</head>
<body  class="margin-top">
    <div class="table-container">
        <table border="1" class="mainTable">
            <tr>
                <td>
                    
     <div id="memberMessage">
                        회원님의 아이디는 <%= request.getParameter("id") %> 입니다
                    </div>
                
                </td>
            </tr>
        </table>
        <div class="button-container" class="modalsumitinput">
            <input type="button" value="로그인" onclick="location.href='/BookStay/member/loginform.jsp'" id="button-container_d" class="button_sub">
            <input type="button" value="비밀번호찾기" onclick="location.href='/BookStay/member/FindPw.jsp'" id="button-container_d" class="button_sub">
        </div>
    </div>
</body>
</html>
