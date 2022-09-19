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
	String order_code = request.getParameter("ocode");
	OrderDAO odao = new OrderDAO();
	OrderListBean obean = odao.getOrderInfo(order_code);
	
	String order_name=obean.getOname();
	String order_tel=obean.getOtel();
	String order_addr=obean.getOaddr();
	String order_date=obean.getOdate();
	String order_status=obean.getOstatus();
	String delivery=obean.getDelivery();
	String delivery_no=obean.getDelivery_no();
%>
		<p><%=user_name%>님의 주문 상세현황 입니다.</p>
		<div class="alert alert-primary" role="alert">
			<div class="row">
				<div class="col-10"><h6>주문일 <%=order_date%></h6></div>
				<div class="col-2 col align-self-center"><h6></h6></div>
			</div>
		</div>
		
		<div class="card ">
			
			<div class="card-body">
				<div class="row">
					<div class="col-8">	
					
						<%
						ArrayList<OrderItemBean> oilist = odao.memberSelectOrderItem(order_code);
						int order_total=0;
						for(OrderItemBean oibean : oilist) {
							int pro_num=oibean.getPnum();
							String pro_name=oibean.getPname();
							String pro_img=oibean.getPimg();
							int item_price=oibean.getIprice();
							int item_amount=oibean.getIamount();
							int order_sum = item_amount*item_price;
							order_total += order_sum;
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
						<a href="" class="btn btn-outline-primary btn-lg">배송조회</a><br/><br/>
						<a href="" class="btn btn-outline-dark btn-lg">주문취소</a>
						</div>
					</div>	
				</div>
			
						
			</div>
			
			<div class="card-header">
				<div class="row">
					<div class="col-9"><h4><%=order_status%></div>
					<div class="col-3 col align-self-center"><span class="btn btn-primary">합계금액</span> :  <span class="h3 text-danger"><fmt:formatNumber type="currency" value="<%=order_total%>" /></span></div>
				</div>
			</div>
					
		</div>
		
		<div style="padding:10px;">
		</div>
		
		<div class="card ">
			<div class="card-header"><h4>배송지 정보</h4></div>
			<div class="card-body">
				<div class="row">
					<div class="col-md-2">배송자명</div>
					<div class="col-md-10"><%=order_name%></div>
					<div class="col-md-2">연락처</div>
					<div class="col-md-10"><%=order_tel%></div>
					<div class="col-md-2">주소</div>
					<div class="col-md-10"><%=order_addr%></div>
				</div>
			</div>
		</div>
<%
}
%>
<div style="padding:20px;"></div>
<%@ include file="bottom.jsp"%>			