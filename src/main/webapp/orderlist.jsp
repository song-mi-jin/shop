<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.OrderDAO"%>
<%@ page import="shop.com.bean.OrderListBean"%>
<%@ page import="shop.com.bean.OrderItemBean"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ include file="top.jsp"%>
<%
if(user_num == 0 && user_name ==null) {
%>
<script>
	alert("로그인이 필요합니다.");
	location.href="login.jsp";
</script>
<%
}else {
	OrderDAO odao = new OrderDAO();
	ArrayList<OrderListBean> olist = odao.memberSelectOrderList(user_num);
%>
		<p><%=user_name%>님의 주문목록입니다.</p>
		<%
		for(OrderListBean obean : olist) {
			int order_num=obean.getOnum();
			String order_code=obean.getOcode();
			String order_name=obean.getOname();
			String order_tel=obean.getOtel();
			String order_addr=obean.getOaddr();
			String order_date=obean.getOdate();
			String order_status=obean.getOstatus();
			String delivery=obean.getDelivery();
			String delivery_no=obean.getDelivery_no();

		%>
		<div class="alert alert-primary" role="alert">
			<div class="row">
				<div class="col-10"><h5>주문번호 <%=order_code%></h5></div>
				<div class="col-2 col align-self-center"><h6><a href="orderdetail.jsp?ocode=<%=order_code%>" class="alert-link">주문서 상세보기</a></h6></div>
			</div>
		</div>

		<div class="card ">
			<div class="card-header"><%=order_status%></div>
			<div class="card-body">
				
				<div class="row">
					<div class="col-8">
						<%
						ArrayList<OrderItemBean> oilist = odao.memberSelectOrderItem(order_code);
						for(OrderItemBean oibean : oilist) {
							int pro_num=oibean.getPnum();
							String pro_name=oibean.getPname();
							String pro_img=oibean.getPimg();
							int item_price=oibean.getIprice();
							int item_amount=oibean.getIamount();
						%>	
						<div class="card mb-3" style="max-width: 650px;">
							<div class="row g-0">
								<div class="col-md-4 col align-self-center"><a href=""><img src="<%=request.getContextPath()%>/upimg/<%=pro_img%>" class="mx-auto d-block" width="100" height="80"></a></div>
								<div class="col-md-8">
									<div class="card-body">
									<h5 class="card-title"><%=pro_name%></h5>
									<p class="card-text"><h5><small class="text-muted"><fmt:formatNumber type="currency" value="<%=item_price%>" /> / <%=item_amount%></small></h5></p>
									</div>
								</div>
						  </div>
						</div>
						<%
						}
						%>
					</div>
					<div class="col-4 col align-self-center">
						<div class="d-grid gap-2 col-7 mx-auto">
						<% if(order_status.equals("배송중") || order_status.equals("배송완료")) {%><a href="" class="btn btn-outline-primary btn-lg">배송조회</a><%}%><br/><br/>
						<% if(order_status.equals("주문완료") || order_status.equals("결제완료") || order_status.equals("배송완료")) {%><a href="" class="btn btn-outline-dark btn-lg">주문취소</a><%}%>
						</div>
					</div>				
				</div>
					
			</div>
		</div>
	
<%
		}
}
%>
<div style="padding:20px;"></div>
<%@ include file="bottom.jsp"%>			