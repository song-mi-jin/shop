<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ page import="shop.com.bean.MemberBean"%>
<%@ page import="java.util.ArrayList" %>
<%@ include file="top.jsp"%>    
			<div id="section">
				<h1>1. 신규회원 리스트</h1>
<%
MemberDAO mdao = new MemberDAO();

ArrayList<MemberBean> list = mdao.todaySelectMember();
%>
				<table border="1">
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>연락처</th>
						<th>우편번호</th>
						<th>주소</th>
						<th>가입일</th>
					</tr>
				<%
				for(MemberBean mbean : list) {
					int mem_num=mbean.getNum();
					String mem_id=mbean.getId();
					String mem_name=mbean.getName();
					String mem_tel=mbean.getTel();
					String mem_zipcode=mbean.getZipcode();
					String mem_addr=mbean.getAddr();
					String mem_day=mbean.getMday();

				%>
				<tr>
					<td><a href="memberinfo.jsp?menu=1&num=<%=mem_num%>"><%=mem_id%></a></td>
					<td><%=mem_name%></td>
					<td><%=mem_tel%></td>
					<td><%=mem_zipcode%></td>
					<td><%=mem_addr%></td>
					<td><%=mem_day%></td>
				</tr>
				<%
				}
				%>
				</table>
				<hr/>				
				<h1>2. 신규주문 리스트</h1>
				
<%

%>
			</div>
<%@ include file="bottom.jsp"%>			