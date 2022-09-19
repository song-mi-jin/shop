<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ page import="shop.com.bean.MemberBean"%> 
<%@ page import="java.util.ArrayList" %>
<%@ include file="top.jsp"%>    
			<div id="section">
				<h1>상품 등록</h1>
				<hr/>
				<form action="productinputok.jsp" method="post" enctype ="multipart/form-data">
				<input type="hidden" name="menu" value="<%=menu%>">
				상품명 : <input type="text" name="pname"><br />
				이미지 : <input type="file" name="pimg"><br />
				가 격 : <input type="text" name="pprice"><br />
				재고수량 : <input type="text" name="pstock"><br />
				옵션  : 인기상품 <input type="checkbox" name="phot" value="y">
				신상품 <input type="checkbox" name="pnew" value="y">
				상품노출 <input type="checkbox" name="pdisplay" value="y" checked="checked">
				<br />
				<textarea name="pdesc" cols="100" rows="10"></textarea><br />
				<input type="submit" value="정보등록">
				</form>

			</div>
<%@ include file="bottom.jsp"%>			