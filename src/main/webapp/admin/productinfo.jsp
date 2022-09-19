<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.ProductDAO"%>
<%@ page import="shop.com.bean.ProductBean"%> 
<%@ page import="java.util.ArrayList" %>
<%@ include file="top.jsp"%>
<%
// 링크로 넘어논 변수들 처리
int pageNum=1;
int num=0;
if(request.getParameter("pageNum")!=null)
	pageNum=Integer.parseInt(request.getParameter("pageNum"));
String search = request.getParameter("search");

if(request.getParameter("num")!=null)
	num=Integer.parseInt(request.getParameter("num"));

ProductDAO pdao = new ProductDAO();


ProductBean pbean = pdao.infoProduct(num);
String pro_name=pbean.getPname();
String pro_img=pbean.getPimg();
int pro_price=pbean.getPprice();
int pro_stock=pbean.getPstock();
String pro_hot = "";
if(pbean.getPhot() !=null)
	pro_hot=pbean.getPhot();

String pro_new = "";
if(pbean.getPnew() !=null)
	pro_new=pbean.getPnew();

String pro_display = "";
if(pbean.getPdisplay() !=null)
	pro_display=pbean.getPdisplay();

String pro_desc=pbean.getPdesc();

%>    
			<div id="section">
				<h1>상품 수정</h1>
				<hr/>
				<form action="productupdateok.jsp" method="post" enctype ="multipart/form-data">
				<input type="hidden" name="menu" value="<%=menu%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				<input type="hidden" name="search" value="<%=search%>">
				<input type="hidden" name="pnum" value="<%=num%>">
				<input type="hidden" name="pimg" value="<%=pro_img%>">
				상품명 : <input type="text" name="pname" value="<%=pro_name%>"><br />
				이미지 : <input type="file" name="pimg"><br />
				가 격 : <input type="text" name="pprice" value="<%=pro_price%>"><br />
				재고수량 : <input type="text" name="pstock" value="<%=pro_stock%>"><br />
				옵션  : 인기상품 <input type="checkbox" name="phot" value="y"<% if(pro_hot.equals("y")) {%> checked="checked"<%} %>>
				신상품 <input type="checkbox" name="pnew" value="y"<% if(pro_new.equals("y")) {%> checked="checked"<%} %>>
				상품노출 <input type="checkbox" name="pdisplay" value="y"<% if(pro_display.equals("y")) {%> checked="checked"<%} %>>
				<br />
				<textarea name="pdesc" cols="100" rows="10"><%=pro_desc%></textarea><br />
				<input type="submit" value="정보 수정">
				</form>

			</div>
<%@ include file="bottom.jsp"%>			