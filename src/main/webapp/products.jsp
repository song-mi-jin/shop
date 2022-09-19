<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.ProductDAO"%>
<%@ page import="shop.com.bean.ProductBean"%> 
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="top.jsp"%>
		<form action="">
		상품 검색 : <input type="text" name="search"> <input type="submit" class="btn btn-success btn-sm" value="검색">
		</form>
		<hr/>
<%
int pageNum=1; // 페이지 번호
int limit=10; // 1페지에 출력될 레코드 갯수
int pagesize=10; // 출력될 페이지 갯수 [1][2]
int startpage=1; //시작페이지 
int endpage=1;  //끝페이지
int pagecount=0; //총 페이지 갯수

if(request.getParameter("pageNum")!=null)
	pageNum=Integer.parseInt(request.getParameter("pageNum"));

String search = "";
if(request.getParameter("search")!=null)
	search = request.getParameter("search");

ProductDAO pdao = new ProductDAO();

int total_record = pdao.getListCount(search);
ArrayList<ProductBean> list = pdao.allSelectProduct(pageNum,limit,search);

pagecount=(total_record-1)/limit+1; 
startpage=pageNum-((pageNum-1)%pagesize);
endpage= startpage+pagesize-1;

out.println("전체 상품수 :" +total_record);
%>								
		<div class="row">
		<%
		for(ProductBean pbean : list) {
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
				<a href="productdetail.jsp?pageNum=<%=pageNum%>&search=<%=search%>&num=<%=pro_num%>"><%=pro_name%></a><br />
				<fmt:formatNumber type="currency" value="<%=pro_price%>" />
				</div>
			</div>
		<%
		}
		%>
		</div>
		<nav aria-label="...">
		<ul class="pagination">
		<%
		if(startpage-pagesize>0){  
		%>
		    <li class="page-item">
				<a class="page-link" href="products.jsp?pageNum=<%=pageNum-1%>&search=<%=search%>">Prev</a>
			</li>
		<%
		}
		%>
		<%
		for(int i=startpage; i<=endpage; i++){
			if(pageNum == i) {
		%>
		    <li class="page-item active" aria-current="page">
				<a class="page-link" href="#"><%=i%></a>
		    </li>
		<%
			}else{
		%>
			<li class="page-item">
				<a class="page-link" href="products.jsp?pageNum=<%=i%>&search=<%=search%>"><%=i%></a>
			</li>
		<%
			}
			if(i==pagecount) break;
		}
		
		if(startpage+pagesize<=pagecount){
		%>   
		    <li class="page-item">
			<a class="page-link" href="products.jsp?pageNum=<%=pageNum+1%>&search=<%=search%>">Next</a>
		    </li>
		<%
		}
		%>
		</ul>
		</nav>
<%@ include file="bottom.jsp"%>			