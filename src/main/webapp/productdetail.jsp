<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.ProductDAO"%>
<%@ page import="shop.com.bean.ProductBean"%> 
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="top.jsp"%>
		<div class="container-sm">
<%
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
String pro_desc=pbean.getPdesc();
int pro_like=pbean.getPlike();
%>
<script>
function like(){
		
	$.ajax({
		url:"productlike.jsp",
		data: {
			num : <%=num%>
		},
		success:function(data){
			$("#count").html("count : "+data);
		},error:function(xhr){
            
			   alert(xhr.status);
		}

	});	
}
</script>
		<ul class="nav">
		  <li class="nav-item">
		    <a class="nav-link active" aria-current="page" href="#">카테고리 영역</a>
		  </li>
		</ul>
	    <div class="row">
	    	<div class="col">
	    		<div class="card"><% if(pro_img!=null) {%><img src="<%=request.getContextPath()%>/upimg/<%=pro_img%>" style="width:100%;"><%}%></div>
	    	</div>
	        <div class="col-5">
	            <div class="card"><% if(pro_img!=null) {%><img src="<%=request.getContextPath()%>/upimg/<%=pro_img%>" style="width:100%;"><%}%></div>
	        </div>
	        <div class="col-6">
	            <h1 class="display-6"><%=pro_name%></h1>
	            <span class="badge bg-primary">PRICE</span> <span class="h3 text-danger"><fmt:formatNumber type="currency" value="<%=pro_price%>" /></span>
	            <p><span class="badge bg-success">무료배송</span></p>
	            <p>
		            <input type="button" class="btn btn-danger btn-sm" onclick="like();" value="좋아요">
					<span id="count">count : <%=pro_like%></span>
				</p>
				
				<div class="card-body">
				<% if(pro_stock>0) {%>
	            <form action="cartok.jsp" method="post">
	            <input type="hidden" name="pro_num" value="<%=num%>">
	            <input type="number" name="amount" min="1" max="100" value="1">
	            <input type="submit" class="btn btn-warning btn-sm" value="장바구니담기">
	            </form>
	            <%}else{%>
	            <span class="h3 text-danger">품절</span>
	            <%} %>
	            </div>				
	        </div>
	        
	    </div>
	    <div style="height:10px;"></div>
	    <div class="row">
	    	<div class="col"></div>
	        <div class="col-11"><%=pro_desc%></div>
	    </div>
	    <div style="height:50px;"></div>
	    
	    </div>
<%@ include file="bottom.jsp"%>			