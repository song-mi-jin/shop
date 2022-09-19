<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.CartDAO"%>
<%@ page import="shop.com.bean.CartBean"%>    
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
	int cart_num=0;
	int amount=0;
	if(request.getParameter("cart_num")!=null)
		cart_num=Integer.parseInt(request.getParameter("cart_num"));
	if(request.getParameter("amount")!=null)
		amount=Integer.parseInt(request.getParameter("amount"));
	
	CartDAO cdao = new CartDAO();
	int rss = cdao.modCart(cart_num, amount);
	
	out.println(rss);
	response.sendRedirect("cartlist.jsp");
}
%>
<%@ include file="bottom.jsp"%>			