<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.hotelDTO" %>
<%@ page import="hotel.bean.hotelDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="list_menu.jsp" %>
<style>
	.sel{
		display:none;
	}
</style>
<div>
	<p>숙소 유형</p>
	<input type="checkbox" id="checkAll" value="all" checked/>전체
	<input type="checkbox" class="chk" name="chk"  value="1" />호텔
	<input type="checkbox" class="chk" name="chk" value="2" />리조트
	<input type="checkbox" class="chk" name="chk" value="3" />모텔
	<input type="checkbox" class="chk" name="chk" value="4" />기타숙소
</div>
<%
	request.setCharacterEncoding("UTF-8");
	String title1 = request.getParameter("title");
	String checkin1 = request.getParameter("checkin");
	String checkout1 = request.getParameter("checkout");
	int adult1 = Integer.parseInt(request.getParameter("adult"));
	int kid1 = Integer.parseInt(request.getParameter("kids"));
	//int category= 0;  
	hotelDAO dao = new hotelDAO();
	ArrayList<hotelDTO> list = dao.hotelList(0 ,"hotel", title1, checkin1, checkout1, adult1, kid1); 
	ArrayList<hotelDTO> list1 = dao.hotelList(1 ,"resort", title1, checkin1, checkout1, adult1, kid1); 
	ArrayList<hotelDTO> list2 = dao.hotelList(2 ,"motel", title1, checkin1, checkout1, adult1, kid1); 
	ArrayList<hotelDTO> list3 = dao.hotelList(3 ,"resort", title1, checkin1, checkout1, adult1, kid1); 
	ArrayList<hotelDTO> list4 = dao.hotelList(4 ,"other", title1, checkin1, checkout1, adult1, kid1); 
	
	int count = dao.count(title1, checkin1, checkout1, adult1, kid1);
%>
<div>
<b>총 <%= count %> 개</b>
</div>
<div id="sel1" class="sel" style="display:block;"> 
<%
	for(hotelDTO dto : list){
%>	 
	<div>
    	<img src="/Hotel/upload/<%= dto.getImg() %>" style="width:100px;"/>
    	<%= dto.getTitle() %>
    	<%= dto.getAddress() %>
    	<%= dto.getAprice() %>
    	<%= dto.getKprice() %>
    	<div><button>예약</button></div>
	</div>
<%}%>
</div>
<div id="sel2" class="sel">
<%
	for(hotelDTO dto : list1){
%>	 
	<div>
    	<img src="/Hotel/upload/<%= dto.getImg() %>" style="width:100px;"/>
    	<%= dto.getTitle() %>
    	<%= dto.getAddress() %>
    	<%= dto.getAprice() %>
    	<%= dto.getKprice() %>
    	<div><button>예약</button></div>
	</div>
<%}%>
</div>
<div id="sel3" class="sel">
<%
	for(hotelDTO dto : list2){
%>	 
	<div>
    	<img src="/Hotel/upload/<%= dto.getImg() %>" style="width:100px;"/>
    	<%= dto.getTitle() %>
    	<%= dto.getAddress() %>
    	<%= dto.getAprice() %>
    	<%= dto.getKprice() %>
    	<div><button>예약</button></div>
	</div>
<%}%>
</div>
<div id="sel4" class="sel">
<%
	for(hotelDTO dto : list3){
%>	 
	<div>
    	<img src="/Hotel/upload/<%= dto.getImg() %>" style="width:100px;"/>
    	<%= dto.getTitle() %>
    	<%= dto.getAddress() %>
    	<%= dto.getAprice() %>
    	<%= dto.getKprice() %>
    	<div><button>예약</button></div>
	</div>
<%}%>
</div>
<div id="sel5" class="sel">
<%
	for(hotelDTO dto : list4){
%>	 
	<div>
    	<img src="/Hotel/upload/<%= dto.getImg() %>" style="width:100px;"/>
    	<%= dto.getTitle() %>
    	<%= dto.getAddress() %>
    	<%= dto.getAprice() %>
    	<%= dto.getKprice() %>
    	<div><button>예약</button></div>
	</div>
<%}%>
</div>
<script src="/Hotel/resources/js/checkbox.js"></script>
<script>
	const select1 = document.getElementById("hselect");
	var sel = document.querySelectorAll(".sel");

	select1.addEventListener("change", function() {
	      const selectedOption = select1.value;
	      sel.forEach(content => {
	        content.style.display = "none";
	      });
	      document.getElementById(selectedOption).style.display = "block";
	    });
</script>
 