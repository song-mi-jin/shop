<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<jsp:useBean id="mbean" class="shop.com.bean.MemberBean"/>
<jsp:setProperty name="mbean" property="*" />

<%
//String id = request.getParameter("Mid");
//mbean.setMpw(request.getParameter("Mpw"));
//mbean.setMname(request.getParameter("Mname"));
//mbean.setMtel(request.getParameter("Mtel"));
//mbean.setMaddr(request.getParameter("Maddr"));
out.println(mbean.getId());
//int rss = mdao.Update(mbean,id);
%>
<a href="admin.jsp?menu=2&sub=1">돌아가기</a>
</body>
</html>