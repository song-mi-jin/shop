<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ page import="shop.com.bean.MemberBean"%> 
<%@ include file="top.jsp"%>

<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberDAO mdao = new MemberDAO();

MemberBean mbean = mdao.loginMember(id, pwd);

if(mbean.getNum() == 0) {
%>
<script>
	alert("일치하는 정보가 없습니다. 확인 바랍니다.");
	history.go(-1);
</script>
<%			
}else{
	session.setAttribute("userNUM", mbean.getNum());
	session.setAttribute("userNAME", mbean.getName());
%>
<script>
	alert("정상적으로 로그인 되었습니다.");
	location.href="index.jsp";
</script>
<%
}
%>
<div style="height:50px;"></div> 								
<%@ include file="bottom.jsp"%>			