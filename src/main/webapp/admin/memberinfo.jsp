<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ page import="shop.com.bean.MemberBean"%> 
<%@ page import="java.util.ArrayList" %>
<%@ include file="top.jsp"%>    
			<div id="section">
				<h1>회원 상세 정보</h1>
				<hr/>
<%
// 링크로 넘어논 변수들 처리
int pageNum=1;
int num=0;
if(request.getParameter("pageNum")!=null)
	pageNum=Integer.parseInt(request.getParameter("pageNum"));
String search = request.getParameter("search");

if(request.getParameter("num")!=null)
	num=Integer.parseInt(request.getParameter("num"));

MemberDAO mdao = new MemberDAO();
MemberBean mbean = mdao.infoMember(num);

%>								
				<table border="1">
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>연락처</th>
						<th>주소</th>
						<th>가입일</th>
					</tr>
				<%
					//int mem_num=mbean.getNum();
					String mem_id=mbean.getId();
					String mem_name=mbean.getName();
					String mem_tel=mbean.getTel();
					String mem_addr=mbean.getAddr();
					String mem_day=mbean.getMday();
				%>
				<tr>
					<td><%=mem_id%></td>
					<td><%=mem_name%></td>
					<td><%=mem_tel%></td>
					<td><%=mem_addr%></td>
					<td><%=mem_day%></td>	
				</tr>
				</table>
				<br/>
				<br/>

			</div>
<%@ include file="bottom.jsp"%>			