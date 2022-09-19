<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>    
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<jsp:useBean id="mbean" class="shop.com.bean.MemberBean"/>
<jsp:setProperty name="mbean" property="*" />	        
<%
MemberDAO mdao = new MemberDAO();
int rss = mdao.updateMember(mbean);

JSONObject informationObject = new JSONObject();
informationObject.put("id",mbean.getId());
informationObject.put("name",mbean.getName());

//여러객체를 배열로 생성할 경우
//JSONObject jsonObject = new JSONObject();
//JSONArray req_array = new JSONArray();
//req_array.add(informationObject);
//jsonObject.put("REQ_DATA", req_array);

//out.print(jsonInfo);
out.print(informationObject);
%>