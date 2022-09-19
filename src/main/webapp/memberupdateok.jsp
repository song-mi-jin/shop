<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ include file="top.jsp"%>    
<jsp:useBean id="mbean" class="shop.com.bean.MemberBean"/>
<jsp:setProperty name="mbean" property="*" />								
<%
MemberDAO mdao = new MemberDAO();
int rss = mdao.updateMember(mbean);

JSONObject informationObject = new JSONObject();
informationObject.put("id",mbean.getId());
informationObject.put("pwd",mbean.getPwd());
informationObject.put("name",mbean.getName());

out.print(informationObject);
%>
<%@ include file="bottom.jsp"%>			