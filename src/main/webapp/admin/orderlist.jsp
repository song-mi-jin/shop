<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.OrderDAO"%>
<%@ page import="shop.com.bean.OrderListBean"%> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="shop.com.util.OrderUtil"%>
<%@ include file="top.jsp"%>
<script>
function del(num){

	var delmsg = confirm("정말 삭제하시겠습니까?")
	if(delmsg) {
		var URL="productdeleteok.jsp?menu=<%=menu%>&num="+num; 
		location.href=URL;
	}

}
</script>
    
			<div id="section">
				<h1>주문 리스트</h1>
				<form action="orderlist.jsp">
				<input type="hidden" name="menu" value="<%=menu%>">
				날짜 검색 : 
				<select name="sy">
				<option value="">년도선택</option>
				<option value="2022">2022</option>
				</select>
				<select name="sm">
				<option value="">월선택</option>
				<%
				for(int ct=1; ct<=12; ct++){
				%>
				<option value="<%=ct%>"><%=ct%></option>
				<%
				}
				%>
				</select>
				이름 검색 <input type="text" name="sw">
				주문상태 
				<select name="ss">
				<option value="">주문상태선택</option>
				<%
				String[] ostatus = OrderUtil.getOrderStatus();
				for(String ot : ostatus) {
				%>
				<option value="<%=ot%>"><%=ot%></option>
				<%
				}
				%>
				</select>
				<input type="submit" value="검 색">
				</form>
				<hr/>
<%
int pageNum=1; // 페이지 번호
int limit=10; // 1페지에 출력될 레코드 갯수
int pagesize=10; // 출력될 페이지 갯수 [1][2]
int startpage=1; //시작페이지 
int endpage=1;  //끝페이지
int pagecount=0; //총 페이지 갯수

if(request.getParameter("pageNum")!=null)
	pageNum=Integer.parseInt(request.getParameter("pageNum"));

String sdate = null;
if(request.getParameter("sy")!=null && request.getParameter("sm")!=null && request.getParameter("sy")!="" && request.getParameter("sm")!="")
	sdate = request.getParameter("sy")+"-"+request.getParameter("sm");
//else sdate = "";


String sw = null;
if(request.getParameter("sw")!=null)
	sw=request.getParameter("sw");
else sw = "";


String ss = null;
if(request.getParameter("ss")!=null && request.getParameter("ss")!="")
	ss=request.getParameter("ss");
else ss = "";

out.println(request.getParameter("ss"));
OrderDAO odao = new OrderDAO();

int total_record = odao.getListCount(sdate, sw, ss);
ArrayList<OrderListBean> list = odao.allSelectOrderList(pageNum, limit, sdate, sw, ss);

pagecount=(total_record-1)/limit+1; 
startpage=pageNum-((pageNum-1)%pagesize);
endpage= startpage+pagesize-1;

out.println("전체 주문 수 :" +total_record);
%>				<form method="post" action="orderstatus.jsp">				
				<table border="1">
					<tr>
						<th>주문코드</th>
						<th>회원 아이디</th>
						<th>회원명</th>
						<th>배송자명</th>
						<th>배송 연락처</th>
						<th>배송 주소</th>
						<th>주문 상태</th>
						<th>택배사</th>
						<th>송장번호</th>
						<th>주문일</th>
					</tr>
				<%
				for(OrderListBean olbean : list) {
					String order_code=olbean.getOcode();
					int mem_num = olbean.getMnum();
					String mem_id=olbean.getMid();
					String mem_name=olbean.getMname();
					String order_name = olbean.getOname();
					String order_tel=olbean.getOtel();
					String order_addr=olbean.getOaddr();
					String order_status=olbean.getOstatus();
					String order_date=olbean.getOdate();
					String delivery=olbean.getDelivery();
					String delivery_no=olbean.getDelivery_no();
					
					String color="";
					switch(order_status) {
						case "결제완료":
							color ="f1";
							break;
						case "배송중":
							color ="f2";
							break;							
						case "배송완료":
							color ="f3";
							break;
						case "주문취소":
							color ="f4";
							break;
						case "환불완료":
							color ="f5";
							break;	
						
					}
				%>
				<tr>
					<td><input type="checkbox" name="ocode" value="<%=order_code%>"> <%=order_code%></td>
					<td><%=mem_id%></td>
					<td><%=mem_name%></td>
					<td><%=order_name%></td>
					<td><%=order_tel%></td>
					<td><%=order_addr%></td>
					<td class="<%=color%>"><%=order_status%></td>
					<td><%=delivery%></td>
					<td><%=delivery_no%></td>
					<td><%=order_date%></td>
				</tr>
				<%
				}
				%>
				</table>
				<br/>
				
				<select name="ostatus">
				<%
				for(String ot : ostatus) {
				%>
				<option value="<%=ot%>"><%=ot%></option>
				<%
				}
				%>
				</select>
				<input type="submit" value="일괄 변경">
				</form>
				<br/>
				<div>
					<%
					if(startpage-pagesize>0){  
					%>
					<a href="orderlist.jsp?menu=<%=menu%>&pageNum=<%=pageNum-1%>&sdate=<%=sdate%>&sw=<%=sw%>&ss=<%=ss%>">[PERV]</a>
					<%
					}
					%>
					<%
					for(int i=startpage; i<=endpage; i++){
						
					%>
					<a href="orderlist.jsp?menu=<%=menu%>&pageNum=<%=i%>&sdate=<%=sdate%>&sw=<%=sw%>&ss=<%=ss%>">
					<%
						if(pageNum == i) {
					%>
						<span class="linka">[<%=i%>]</span></a>
					<%
						}else{
					%>
						<span class="linkb">[<%=i%>]</span></a>
					
					<%
						}
						if(i==pagecount) break;
					}
					%>
					<%
					if(startpage+pagesize<=pagecount){
					%>
					<a href="orderlist.jsp?menu=<%=menu%>&pageNum=<%=pageNum+1%>&sdate=<%=sdate%>&sw=<%=sw%>&ss=<%=ss%>">[next]</a>
					<%
					}
					%>
				</div>
			</div>
<%@ include file="bottom.jsp"%>			