<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ page import="shop.com.bean.MemberBean"%>
<%@ page import="shop.com.dao.ProductDAO"%>
<%@ page import="shop.com.bean.ProductBean"%> 
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="top.jsp"%>    
		<button type="button" class="btn btn-info btn-sm">인기상품 </button>
		
<%
ProductDAO pdao = new ProductDAO();

ArrayList<ProductBean> list = pdao.hotSelectProduct();
%>
		<div class="row">
		<%
		for(ProductBean pbean : list) {
			int pro_num=pbean.getPnum();
			String pro_name=pbean.getPname();
			String pro_img=pbean.getPimg();
			int pro_price=pbean.getPprice();
			int pro_like=pbean.getPlike();
		%>
			<div class="col-3">
				<div class="card">
				<% if(pro_img!=null) {%><img class="cart-img-top" src="<%=request.getContextPath()%>/upimg/<%=pro_img%>" style="width:100%;"><%}%>
				</div>
				<div class="card-body">
				<a href="productdetail.jsp?num=<%=pro_num%>"><%=pro_name%></a><br />
				<fmt:formatNumber type="currency" value="<%=pro_price%>" />
				<button type="button" class="btn-sm btn-success position-relative">Like
				<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"><%=pro_like%>+</span>
				</button>
				</div>
			</div>
		<%
		}
		%>
		</div>
		<hr/>				
		<button type="button" class="btn btn-danger btn-sm">신규상품 </button>
<%
ArrayList<ProductBean> nlist = pdao.newSelectProduct();
%>
		<div class="row">
		<%
		for(ProductBean pbean : nlist) {
			int pro_num=pbean.getPnum();
			String pro_name=pbean.getPname();
			String pro_img=pbean.getPimg();
			int pro_price=pbean.getPprice();
		%>
			<div class="col-3">
				<div class="card">
				<% if(pro_img!=null) {%><img class="cart-img-top" src="<%=request.getContextPath()%>/upimg/<%=pro_img%>" style="width:100%;"><%}%>
				</div>
				<div class="card-body">
				<a href="productdetail.jsp?num=<%=pro_num%>"><%=pro_name%></a><br />
				<fmt:formatNumber type="currency" value="<%=pro_price%>" />
				</div>
			</div>
		<%
		}
		%>
		</div>
<%@ include file="bottom.jsp"%>			