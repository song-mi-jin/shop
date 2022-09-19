<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ include file="top.jsp"%>    
			<div id="section">
				<h1>회원 일괄 삭제</h1>
				<hr/>
<%
String[] id = request.getParameterValues("id");
for(String mid : id) {
	out.println(mid);
	
}

MemberDAO mdao = new MemberDAO();

int rss = mdao.batchDeleteMember(id);
out.println(rss);

%>								

				<br/>
				<br/>

			</div>
<%@ include file="bottom.jsp"%>			