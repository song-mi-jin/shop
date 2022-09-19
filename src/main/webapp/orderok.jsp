<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.OrderDAO"%>
<%@ page import="shop.com.bean.OrderListBean"%>
<%@ page import="shop.com.util.OrderUtil"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ include file="top.jsp"%>
<%
if(user_num == 0 && user_name ==null) {
%>
<script>
	alert("로그인이 필요합니다.");
	location.href="login.jsp";
</script>
<%
}else {
	// 주문번호 생성
	String order_code = OrderUtil.getOrderCode();
	String order_name = request.getParameter("oname");
	String order_tel = request.getParameter("otel");
	String order_addr = request.getParameter("oaddr");
	
	OrderDAO odao = new OrderDAO();
	OrderListBean obean = new OrderListBean();
	obean.setOcode(order_code);
	obean.setMnum(user_num);
	obean.setOname(order_name);
	obean.setOtel(order_tel);
	obean.setOaddr(order_addr);
	
	out.println(obean.getOcode());
	//out.println(obean.getMnum());
	//out.println(obean.getOname());
	//out.println(obean.getOtel());
	//out.println(obean.getOaddr());
	int rss = odao.addOrder(obean);
	
	int rss2 = 0;
	
	if(rss>0) {
		
		rss2 = odao.addOrderItem(user_num, order_code);
		
	}
	
	out.println("주문아이템 등록 수"+rss2);
	
}
%>

<%@ include file="bottom.jsp"%>			