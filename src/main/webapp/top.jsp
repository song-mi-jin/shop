<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰메인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>

	body { 
		width:87%;
		margin: 0 auto;
	}

	#header {
		height:200px;
		text-align:center;
	}

	#header img {
		width:1000px;
		height:200px;
	}
	#navigation {
		height:60px;
	}

	#wrap {
		/*height:400px;*/
		height:100%;
	}

	#contents {
		/*background-color:#CCFFCC;*/
		padding-left:20px;
		width:95%;
		height:100%;
	}

	#footer {
		height:50px;
		width:100%;
		background-color:#0000CC;
	}

	#footer #bottom {
		padding:10px 0 10px 0;
		text-align:center;
		color:#FFFFFF;
	}

	a {text-decoration:none;}
	
	th,td {
		text-align:center;
	}
	
	th.num, td.num {
		text-align:right;
	}
    </style>
</head>
<body>
    <div id="header"><img src="<%=request.getContextPath()%>/header.jpg" /></div>
	<div id="navigation">
		<!-- <div class="container"> -->
<%
request.setCharacterEncoding("utf-8");
//로그인 정보 확인
int user_num = 0;
if(session.getAttribute("userNUM") != null) 
	user_num = (Integer) session.getAttribute("userNUM");
String user_name = (String) session.getAttribute("userNAME");

//out.println("회원이름 "+user_num);
%>		
			<header class="header clearfix">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">		
				<ul class="nav" style="width:20%;padding-left:20px;">
					<li class="nav-item">
			        <% if(user_name !=null) {%><%=user_name%>님 환영합니다.
			        <%} %>
			      </li>
				</ul>
			    <ul class="nav justify-content-end" style='width:80%;'>
			      <li class="nav-item">
			        <a class="nav-link" href="index.jsp">Home</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="products.jsp">상품리스트</a>
			      </li>
			      <%
			      if(user_num == 0 && user_name ==null) {
			      %>
			      <li class="nav-item">
			        <a class="nav-link" href="memberjoin.jsp">회원가입</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="login.jsp">로그인</a>
			      </li>
			      <%
			      } else {
			      %>
			      <li class="nav-item">
			        <a class="nav-link" href="memberinfo.jsp">회원정보수정</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="cartlist.jsp">장바구니</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="orderlist.jsp">주문조회</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="logout.jsp">로그아웃</a>
			      </li>
			      <%
			      }
			      %>
			    </ul>
			  </nav>
			</header>
		<!-- </div> -->
	</div>
    <div id="wrap">
    	<div id="contents">		
