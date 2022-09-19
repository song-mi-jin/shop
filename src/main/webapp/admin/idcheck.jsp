<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ page import="shop.com.bean.MemberBean"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인</title>
<script>
function idcheck() {
	
	opener.document.getElementById("pwd").focus();
	window.close();
}
</script>
</head>
<body> 
<h1>아이디 중복 확인</h1>
<hr/>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");

MemberDAO mdao = new MemberDAO();
// 아이디 중복 검사
Boolean rsid = mdao.getSearchID(id);

if(rsid == true) {
	
%>
<script>
	alert("중복되는 아이디가 있습니다. 확인 바랍니다.");
	window.close();
</script>
<%
} else {
%>
해당 아이디 : <%=id%> 는 사용가능합니다.
<input type="button" value="사용하기"  onclick="idcheck();"/>
<%
}
%>
</body>
</html>		