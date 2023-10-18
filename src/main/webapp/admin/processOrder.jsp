<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="hotel.bean.HOrderDTO" %>
<%@ page import="hotel.bean.HOrderDAO" %>
<!DOCTYPE html>
<html> 
<head>
    <title>예약 처리 페이지</title>
</head>
<body>
    <%
        // 예약 정보 가져오기
        String id = request.getParameter("id");
        
        String checkin = request.getParameter("checkin");
        String checkout = request.getParameter("checkout");
        int adult = 0;
        int kid = 0;
        int state = 0;
        String paytype = request.getParameter("paytype");
        int adultCount = 0;
        
        
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
            
            if (request.getParameter("state") != null && !request.getParameter("state").isEmpty()) {
                state = Integer.parseInt(request.getParameter("state"));
            } else {
                
                throw new Exception("상태(state) 값이 누락되었습니다.");
            }
            
            if (request.getParameter("adultcount") != null && !request.getParameter("adultcount").isEmpty()) {
                adultCount = Integer.parseInt(request.getParameter("adultcount"));
            } else {
                
                throw new Exception("성인 수(adultcount)가 누락되었습니다.");
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

        // 예약 정보 객체 생성
        HOrderDTO order = new HOrderDTO();
        order.setId(id);
       
        order.setCheckin(checkin);
        order.setCheckout(checkout);
        order.setAdult(adult);
        order.setKid(kid);
        order.setState(state);
        order.setPaytype(paytype);
        order.setAdultCount(adultCount);

        HOrderDAO dao = new HOrderDAO();

        try {
            // 예약 정보 저장
            dao.insertOrder(order);
    %>
            <h1>예약이 완료되었습니다!</h1>
    <%
        } catch (Exception e) {
    %>
            <h1>예약 처리 중 오류가 발생했습니다.</h1>
    <%
            e.printStackTrace();
        }
    %>
</body>
</html>
