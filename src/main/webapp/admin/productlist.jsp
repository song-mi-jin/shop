<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.ProductDAO"%>
<%@ page import="shop.com.bean.ProductBean"%> 
<%@ page import="java.util.ArrayList" %>
<%@ include file="top.jsp"%>
<script>
function del(num){

	var delmsg = confirm("정말 삭제하시겠습니까?")
	if(delmsg) {
		var URL="productdeleteok.jsp?menu=<%=menu%>&num="+num; 
		location.href=URL;
	}

}
</script>
    
			<div id="section">
				<h1>상품 리스트</h1>
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

ProductDAO pdao = new ProductDAO();

int total_record = pdao.getListCount(search);
ArrayList<ProductBean> list = pdao.allSelectProduct(pageNum,limit,search);

pagecount=(total_record-1)/limit+1; 
startpage=pageNum-((pageNum-1)%pagesize);
endpage= startpage+pagesize-1;

out.println("전체 상품수 :" +total_record);
%>								
				<table border="1">
					<tr>
						<th>상품명</th>
						<th>사진</th>
						<th>가격</th>
						<th>재고수량</th>
						<!-- <th>설명</th> -->
						<th>인기상품</th>
						<th>신상품</th>
						<th>상품출력</th>
						<th>등록일</th>
						<th>처리</th>
					</tr>
				<%
				for(ProductBean pbean : list) {
					int pro_num=pbean.getPnum();
					String pro_name=pbean.getPname();
					String pro_img=pbean.getPimg();
					int pro_price=pbean.getPprice();
					int pro_stock=pbean.getPstock();
					String pro_hot=pbean.getPhot();
					String pro_new=pbean.getPnew();
					String pro_display=pbean.getPdisplay();
					String pro_desc=pbean.getPdesc();
					String pro_day=pbean.getPday();
				%>
				<tr>
					<td><a href="productinfo.jsp?menu=<%=menu%>&pageNum=<%=pageNum%>&search=<%=search%>&num=<%=pro_num%>"><%=pro_name%></a></td>
					<td><% if(pro_img!=null) {%><a href="<%=request.getContextPath()%>/upimg/<%=pro_img%>" target="_blank"><img src="<%=request.getContextPath()%>/upimg/<%=pro_img%>" width="100"></a><%}%></td>
					<td><%=pro_price%></td>
					<td><%=pro_stock%></td>
					<!-- <td></td> -->
					<td><%=pro_hot%></td>
					<td><%=pro_new%></td>
					<td><%=pro_display%></td>			
					<td><%=pro_day%></td>
					<td><a href="#" onclick="del('<%=pro_num%>');">[삭 제]</a></td>	
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
					<a href="memberlist.jsp?menu=<%=menu%>&pageNum=<%=pageNum-1%>&search=<%=search%>">[PERV]</a>
					<%
					}
					%>
					<%
					for(int i=startpage; i<=endpage; i++){
						
					%>
					<a href="memberlist.jsp?menu=<%=menu%>&pageNum=<%=i%>&search=<%=search%>">
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
					<a href="memberlist.jsp?menu=<%=menu%>&pageNum=<%=pageNum+1%>&search=<%=search%>">[next]</a>
					<%
					}
					%>
				</div>
			</div>
<%@ include file="bottom.jsp"%>			