<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="hotel.bean.hotelDTO" %>
<%@ page import="hotel.bean.hotelDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="list_menu.jsp" %>
<%
	String id = (String)session.getAttribute("sid");
	request.setCharacterEncoding("UTF-8");
	String title1 = request.getParameter("title");
	String checkin1 = request.getParameter("checkin");
	String checkout1 = request.getParameter("checkout");
	int adult1 = Integer.parseInt(request.getParameter("adult"));
	int kid1 = Integer.parseInt(request.getParameter("kids"));
	int sel1 = Integer.parseInt(request.getParameter("select"));
	int room1 = Integer.parseInt(request.getParameter("room"));
	String check1 = request.getParameter("check");
	
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	int cPage = Integer.parseInt(pageNum);
	int start = (cPage - 1) * pageSize + 1;
	int end = cPage * pageSize;
	
	String url = "&title=" + title1 + "&checkin=" + checkin1 + "&checkout=" + checkout1 + "&adult=" + adult1 + "&kids=" + kid1 + 
			 "&room=" + room1 + "&select=" + sel1 + "&check=" + check1;
	//int category= 0;  
	hotelDAO dao = new hotelDAO();
	ArrayList<hotelDTO> list = dao.hotelList(sel1, check1, title1, checkin1, checkout1, adult1, kid1, start, end); 
	int cnt = dao.count(title1);
	int count = dao.count(title1, check1, checkin1, checkout1, adult1, kid1);
	
	ArrayList<hotelDTO> block = dao.HotelBlock(checkin1, checkout1); 
	StringBuilder block1 = new StringBuilder();
	int size = block.size(); // block의 크기를 미리 계산
	
	for (int i = 0; i < size; i++) {
	    hotelDTO dto = block.get(i);
	    block1.append(String.valueOf(dto.getRef()));
	    if (i < size - 1) {
	        block1.append(",");
	    }
	}
	String block2 = block1.toString();
%>
<form id="option" method="post">
	<div>
	<input type="hidden" name="title1" value="<%= title1%>">
	<input type="hidden" name="checkin1" value="<%= checkin1%>">
	<input type="hidden" name="checkout1" value="<%= checkout1%>">
	<input type="hidden" name="adult1" value="<%= adult1%>">
	<input type="hidden" name="kid1" value="<%= kid1%>">
	<input type="hidden" name="sel1" value="<%= sel1%>">
	<input type="hidden" name="c1" value="<%= check1 %>">
		<select id="hselect">
			<option value="1">최신순</option>
			<option value="2">인기순</option>
			<option value="3">가격높은순</option>
			<option value="4">가격낮은순</option>
			<option value="5">평점순</option>
		</select>
	</div>
	<div>
		<p>숙소 유형</p>
		<input type="checkbox" id="checkAll" value="0" checked/>전체
		<input type="checkbox" class="chk" name="chk"  value="1" />호텔
		<input type="checkbox" class="chk" name="chk" value="2" />리조트
		<input type="checkbox" class="chk" name="chk" value="3" />모텔
		<input type="checkbox" class="chk" name="chk" value="4" />기타숙소
	</div>
</form>
<div>
<div><%=cnt%>개 중 예약 가능 <b><%=count%></b> 개</div>
</div>
<div id="sel1" class="sel"> 
<%boolean result = false;
	for(hotelDTO dto : list){
		if(block2==null){
		result=	dao.checkRoom(block2,room1,dto.getNum());
		
%>	 
	<div>
	<a href="../hotel/hotelContent.jsp?title=<%=dto.getTitle()%>&ref=<%=dto.getRef()%>&block=<%=block2%>">
		<div>
		result : 
    	<img src="/Hotel/upload/<%= dto.getImg() %>" style="width:100px;"/>
    	<%= dto.getTitle() %>
    	<%= dto.getAddress() %>
    	<%= dto.getAprice() %>
    	<%= dto.getKprice() %>
    	<div><button type="button" class="btn btn-warning" onclick="window.location='../hotel/hotelContent.jsp?ref=<%=dto.getRef()%>&block=<%=block2%>'">예약</button></div>
		</div>
	</a>
    	<%
    	if(id.equals("admin")){
    	%>	
    		<button type="button" onclick="window.location.href='../hotel/hotelDelete.jsp?num=<%=dto.getNum()%>&re_step=<%=dto.getRe_step()%>'" class="btn btn-danger">삭제</button>
    	<%	
    	}
		}
    	%>
	</div>
<%//}
		}%>
</div>
<%
	if(count > 0){
		int pageCnt = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (int)(cPage / 10)* 10 + 1;
		int pageB = 10;
		int endPage = startPage + pageB - 1;
		if(endPage > pageCnt){
			endPage = pageCnt;
		}
		%>
		<div id="page">
		<%if(startPage > 10){%>
			<a href="hlist.jsp?pageNum=<%=startPage-10%><%=url%>"><button class="button">이전</button></a>
		<%}
		for(int i = startPage; i <= endPage; i++){
		%> <a href="hlist.jsp?pageNum=<%=i %><%=url%>"><button class="button"><%=i %></button></a>	
		<%}
		if(endPage < pageCnt){
		%>	<a href="hlist.jsp?pageNum=<%=startPage+10 %><%=url%>"><button class="button">다음</button></a>	
		<%}
	}
%>
		</div>
<script>
	var sel1Input = document.querySelector('input[name="sel1"]');
	var hselect = document.getElementById("hselect");
	
	var sel1Value = sel1Input.value;
	
	for (var i = 0; i < hselect.options.length; i++) {
	 if (hselect.options[i].value === sel1Value) {
	     hselect.options[i].selected = true;
	     break;
	 }
	}
</script>
<script>
var ot = document.getElementById("option");
var hselect = document.getElementById("hselect");
var tInput = ot.querySelector('input[name="title1"]')
var ciInput = ot.querySelector('input[name="checkin1"]')
var coInput = ot.querySelector('input[name="checkout1"]')
var aInput = ot.querySelector('input[name="adult1"]')
var kInput = ot.querySelector('input[name="kid1"]')
var checkAll = document.getElementById("checkAll");
var checkboxes = document.querySelectorAll(".chk");
var c1Input = document.querySelector('input[name="c1"]');

var c1Value = c1Input.value.split(','); // c1의 value를 쉼표로 분리
checkboxes.forEach(function(checkbox) {
    if (c1Value.includes(checkbox.value)) { // 일치하는 경우에만 checked
        checkbox.checked = true;
    }
});

checkAll.addEventListener("click", function() {
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = checkAll.checked;
    });
});

checkboxes.forEach(function(checkbox) {
    checkbox.addEventListener("click", function() {
        var selectedCheckboxes = Array.from(checkboxes).filter(function(checkbox) {
            return checkbox.checked;
        });
        var selectedValues = selectedCheckboxes.map(function(checkbox) {
            return checkbox.value;
        });
        var tvalue = tInput.value;
		var civalue = ciInput.value;
		var covalue = coInput.value;
		var avalue = aInput.value;
		var kvalue = kInput.value;
        //alert("선택한 항목: " + selectedValues.join(", "));
        var sel = "<%=sel1%>";
        var room = "<%=room1%>";
        ot.action = 'hlist.jsp?title=' + tvalue + '&checkin=' + civalue + '&checkout=' + covalue
  	  	+ '&adult=' + avalue + '&kids=' + kvalue + '&room=' + room + '&select=' + sel + '&check=' + selectedValues; 
        ot.submit();
    });
});
</script>
<!--<script src="/Hotel/resources/js/checkbox.js"></script> -->
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
<script>
	var ot = document.getElementById("option");
	var hselect = document.getElementById("hselect");
	var tInput = ot.querySelector('input[name="title1"]')
	var ciInput = ot.querySelector('input[name="checkin1"]')
	var coInput = ot.querySelector('input[name="checkout1"]')
	var aInput = ot.querySelector('input[name="adult1"]')
	var kInput = ot.querySelector('input[name="kid1"]')
	
	hselect.addEventListener("change", function(){
		var tvalue = tInput.value;
		var civalue = ciInput.value;
		var covalue = coInput.value;
		var avalue = aInput.value;
		var kvalue = kInput.value;
		var cvalue = "<%=check1%>";
		var selectedValue = hselect.value;
        ot.action = 'hlist.jsp?title=' + tvalue + '&checkin=' + civalue + '&checkout=' + covalue
  	  + '&adult=' + avalue + '&kids=' + kvalue + '&select=' + selectedValue + '&check=' + cvalue; 
        ot.submit();
	});
		var options = hselect.options;
		for (var i = 0; i < options.length; i++) {
		    if (options[i].value === selectedValue) {
		        options[i].selected = true;
		        break; // 선택 후 반복 종료
		    }
		}
</script>
 