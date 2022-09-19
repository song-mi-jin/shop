<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.ProductDAO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
int num=0;

if(request.getParameter("num")!=null)
	num=Integer.parseInt(request.getParameter("num"));

ProductDAO pdao = new ProductDAO();
int pro_like=pdao.likeProduct(num);
out.println(pro_like);
%>
