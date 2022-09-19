<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.ProductDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="top.jsp"%>    
			<div id="section">
				<h1>상품 삭제</h1>
				<hr/>					
<%
int num=0;
if(request.getParameter("num")!=null)
	num=Integer.parseInt(request.getParameter("num"));

ProductDAO pdao = new ProductDAO();

String pimg = pdao.getProductImg(num);

ServletContext context = getServletContext();
String realFolder = context.getRealPath("\\upimg");

if(pimg !=null) {
	
	String uploadedFileName =  realFolder+"\\" + pimg;
	File realFile = new File(uploadedFileName);  //파일객체 생성
	boolean isDel = false;
	isDel = realFile.delete(); //boolean type 리턴

	out.println(uploadedFileName);

}

int rss = pdao.deleteProduct(num);
out.println(rss+ "개의 상품이 정상적으로 삭제되었습니다.");
%>


			</div>
<%@ include file="bottom.jsp"%>			