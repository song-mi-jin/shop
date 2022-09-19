<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ page import="shop.com.bean.MemberBean"%>        
<%
request.setCharacterEncoding("utf-8");
int user_num = Integer.parseInt(request.getParameter("user_num"));
MemberDAO mdao = new MemberDAO();
MemberBean mbean = mdao.infoMember(user_num);

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