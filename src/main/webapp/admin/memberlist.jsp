<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.MemberDAO"%>
<%@ page import="shop.com.bean.MemberBean"%>
<%@ page import="shop.com.dao.CartDAO"%>
<%@ page import="shop.com.dao.OrderDAO"%>  
<%@ page import="java.util.ArrayList" %>
<%@ include file="top.jsp"%>
<script>
function del(num){

	var delmsg = confirm("정말 삭제하시겠습니까?")
	if(delmsg) {
		var URL="memberdel.jsp?menu=<%=menu%>&num="+num; 
		location.href=URL;
	}

}
</script>
<script> 
  function submit2(frm) { 
    frm.action="memberalldel.jsp"; 
    frm.submit(); 
    return true; 
  } 
</script>
    
			<div id="section">
				<h1>회원 리스트</h1>
				<form action="memberlist.jsp">
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

MemberDAO mdao = new MemberDAO();

int total_record = mdao.getListCount(search);
ArrayList<MemberBean> list = mdao.allSelectMember(pageNum,limit,search);

pagecount=(total_record-1)/limit+1; 
startpage=pageNum-((pageNum-1)%pagesize);
endpage= startpage+pagesize-1;

out.println("전체 회원수 :" +total_record);
%>							
				<form action="memberalldel.jsp" method="post">
				
				<table border="1">
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>연락처</th>
						<th>우편번호</th>
						<th>주소</th>
						<th>장바구니 갯수</th>
						<th>주문 수</th>
						<th>가입일</th>
						<th>처리</th>
					</tr>
				<%
				for(MemberBean mbean : list) {
					int mem_num=mbean.getNum();
					String mem_id=mbean.getId();
					String mem_name=mbean.getName();
					String mem_tel=mbean.getTel();
					String mem_zipcode=mbean.getZipcode();
					String mem_addr=mbean.getAddr();
					String mem_day=mbean.getMday();
					
					CartDAO cdao = new CartDAO();
					int cnt = cdao.getCartMember(mem_num);
					
					OrderDAO odao = new OrderDAO();
					int ont = odao.getOrderMember(mem_num);
				%>
				<tr>
					<td><input type="checkbox" name="id" value="<%=mem_id%>"> <a href="memberinfo.jsp?menu=<%=menu%>&pageNum=<%=pageNum%>&search=<%=search%>&num=<%=mem_num%>"><%=mem_id%></a></td>
					<td><%=mem_name%></td>
					<td><%=mem_tel%></td>
					<td><%=mem_zipcode%></td>
					<td><%=mem_addr%></td>
					<td><%=cnt%></td>
					<td><%=ont%></td>
					<td><%=mem_day%></td>
					<td><a href="#" onclick="del('<%=mem_num%>');">[삭 제]</a></td>	
				</tr>
				<%
				}
				%>
				</table>
				<input type="submit" value="일괄삭제">	
				</form>
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