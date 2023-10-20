<%@page import="hotel.bean.testDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String checkin="2023-10-21";
String checkout="2023-10-24";
testDAO dao = new testDAO();
dao.test(checkin, checkout);

%>