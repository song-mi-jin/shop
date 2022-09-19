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
	int pro_num=0;
	int amount=0;
	if(request.getParameter("pro_num")!=null)
		pro_num=Integer.parseInt(request.getParameter("pro_num"));
	if(request.getParameter("amount")!=null)
		amount=Integer.parseInt(request.getParameter("amount"));
	
	CartBean cbean = new CartBean();
	cbean.setMnum(user_num);
	cbean.setPnum(pro_num);
	cbean.setCamount(amount);
	
	out.println(cbean.getMnum());
	out.println(cbean.getPnum());
	out.println(cbean.getCamount());
	
	CartDAO cdao = new CartDAO();
	int rss = cdao.addCart(cbean);
	
	out.println(rss);
	response.sendRedirect("cartlist.jsp");
}
%>
<%@ include file="bottom.jsp"%>			