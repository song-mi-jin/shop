<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.CartDAO"%>
<%@ page import="shop.com.bean.CartBean"%> 
<%@ page import="java.util.ArrayList" %>
<%@ include file="top.jsp"%>
    
			<div id="section">
				<h1>장바구니 리스트</h1>
				<form action="productlist.jsp">
				<input type="hidden" name="menu" value="<%=menu%>">
				이름 검색 : <input type="text" name="search"> <input type="submit" value="검 색">
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
String search = request.getParameter("search");

CartDAO cdao = new CartDAO();

int total_record = cdao.getListCount();
ArrayList<CartBean> list = cdao.allSelectCart(pageNum,limit);

pagecount=(total_record-1)/limit+1; 
startpage=pageNum-((pageNum-1)%pagesize);
endpage= startpage+pagesize-1;

out.println("전체 장바구니수 :" +total_record);
%>								
				<table border="1">
					<tr>
						<th>회원명</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>장바구니 등록일</th>
					</tr>
				<%
				for(CartBean cbean : list) {
					int cart_num=cbean.getCnum();
					int mem_num = cbean.getMnum();
					String mem_name=cbean.getMname();
					int pro_num = cbean.getPnum();
					String pro_name=cbean.getPname();
					int pro_price=cbean.getPprice();
					int cart_amount=cbean.getCamount();
					String cart_date=cbean.getCdate();
				%>
				<tr>
					<td><%=mem_name%></td>
					<td><%=pro_name%></td>
					<td><%=pro_price%></td>
					<td><%=cart_amount%></td>
					<td><%=cart_date%></td>
				</tr>
				<%
				}
				%>
				</table>
				<br/>
				<br/>
				
				<div>
					<%
					if(startpage-pagesize>0){  
					%>
					<a href="cartlist.jsp?menu=<%=menu%>&pageNum=<%=pageNum-1%>&search=<%=search%>">[PERV]</a>
					<%
					}
					%>
					<%
					for(int i=startpage; i<=endpage; i++){
						
					%>
					<a href="cartlist.jsp?menu=<%=menu%>&pageNum=<%=i%>&search=<%=search%>">
					<%
						if(pageNum == i) {
					%>
						<span class="linka">[<%=i%>]</span></a>
					<%
						}else{
					%>
						<span class="linkb">[<%=i%>]</span></a>
					
					<%
						}
						if(i==pagecount) break;
					}
					%>
					<%
					if(startpage+pagesize<=pagecount){
					%>
					<a href="cartlist.jsp?menu=<%=menu%>&pageNum=<%=pageNum+1%>&search=<%=search%>">[next]</a>
					<%
					}
					%>
				</div>
			</div>
<%@ include file="bottom.jsp"%>			