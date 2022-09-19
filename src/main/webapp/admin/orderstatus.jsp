<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.OrderDAO"%>
<%@ include file="top.jsp"%>    
			<div id="section">
				<h1>주문상태 일괄처리</h1>
				<hr/>
<%
String[] order_code = request.getParameterValues("ocode");
for(String ocode : order_code) {
	out.println(ocode);
	
}

String order_status = request.getParameter("ostatus");
out.println(order_status);
OrderDAO odao = new OrderDAO();

int rss = odao.batchUpdateStatus(order_code, order_status);
out.println(rss);

%>								

				<br/>
				<br/>

			</div>
<%@ include file="bottom.jsp"%>			