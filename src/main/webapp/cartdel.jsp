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
	
	String[] id = request.getParameterValues("cnum");
	int[] cart_num = new int[id.length];
	int ct = 0;
	for(String cid : id) {
		cart_num[ct] = Integer.parseInt(cid);	
		out.println(cart_num[ct]);
		ct++;
		
	}

	CartDAO cdao = new CartDAO();

	int rss = cdao.batchDeleteCart(cart_num);
	
	out.println(rss);
	response.sendRedirect("cartlist.jsp");
}
%>
<%@ include file="bottom.jsp"%>			