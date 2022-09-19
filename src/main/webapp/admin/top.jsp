<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자영역</title>
<style>

	body { 
		width:90%;
		/*margin: 0 auto;*/
	}

	#header {
		height:100px;
		/*text-align:center;*/
	}

	#header img {
		width:1000px;
		height:100px;
	}
	#navigation {
		height:60px;
		background-color:#FFCC33;
	}

	#navigation #topmenu {
		height:40px;
		width:500px;
		margin:10px 10px 0px 0px;
		background-color:#FFFFFF;
		text-align:center;
		float:right;
	}
	#wrap {
		/*height:400px;*/
		height:100%;
	}

	#contents {
		/*background-color:#CCFFCC;*/
		width:100%;
		height:100%;
		float:left;
	}

	#aside {
		border:1px solid #000000;
		width:17%;
		height:500px;
		position:relative;
		float:left;
	}

	#section {
		/*background-color:#00CC00;*/
		width:80%;
		float:right;
	}

	#footer {
		height:50px;
		clear:both;
		background-color:#0000CC;
	}

	#footer #bottom {
		padding:10px 0 10px 0;
		text-align:center;
		color:#FFFFFF;
	}
	
	table, td, th {
  		border: 1px solid black;
  		padding:5px;
	}
	
	td.f1 { color:red; }
	td.f2 { color:blue; }
	td.f3 { color:orange; }
	td.f4 { color:green; }
	td.f5 { color:gray; }
	
	table {
  		border-collapse: collapse;
	}
	input { height:25px; }
	input[type="submit"] { background-color: #04AA6D; }
	
	span.linka { color:green; font-weight:bold; }
	span.linkb { color:blue; }
    </style>
</head>
<body>
    <div id="header">관리자 영역<!--<img src="<%--request.getContextPath()--%>/img/logo.jpg" />--></div>
	<div id="navigation">
		<div id="topmenu">
		<span><a href="admin.jsp">홈으로</a></span>
		<span><a href="memberlist.jsp?menu=1">회원관리</a></span>
		<span><a href="productlist.jsp?menu=2">상품관리</a></span>
		<span><a href="cartlist.jsp?menu=3">장바구니관리</a></span>
		<span><a href="orderlist.jsp?menu=4">주문관리</a></span>
		</div>
	</div>
    <div id="wrap">
        <div id="contents">		
			<div id="aside">
<%
request.setCharacterEncoding("utf-8");

int menu = 0;
if(request.getParameter("menu") != null) {
	menu = Integer.parseInt(request.getParameter("menu"));
	String mlink = "menu"+menu+".jsp";

%>  			
				<jsp:include page="<%=mlink%>" />
<%
}else{
	out.println("관리자 페이지 메인");
}
%>
			</div>