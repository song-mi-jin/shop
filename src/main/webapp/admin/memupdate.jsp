<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
<h1>회원정보 수정 페이지</h1>

<form action="memupdateok.jsp" method="post">
<fieldset>
  <legend>필수 입력 항목</legend>
 
    아이디:<input type=text name=mid value=<%=request.getParameter("Mid") %> readonly="readonly"><br> 
    비일번호:<input type=text name=Mpw><br>
    이름:<input type=text name=Mname ><br>
    전화번호:<input type=text name=Mtel ><br>
    주소:<input type=text name=Maddr>
</fieldset>
<input type=submit value=정보수정>
</form>
<a href="admin.jsp?menu=1&search=">돌아가기</a>

</body>
</html>