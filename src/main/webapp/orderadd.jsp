<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.CartDAO"%>
<%@ page import="shop.com.bean.CartBean"%>
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
	CartDAO cdao = new CartDAO();
	ArrayList<CartBean> list = cdao.memberSelectCart(user_num);
	
	// 재고 수량 검사
	for(CartBean cbean : list) {
		// 해당 상품의 사용자가 주문한 수량이 현재 재고 수량보다 클 경우
		//out.println(cbean.getCamount());
		//out.println(cbean.getPstock());
		if(cbean.getCamount()>cbean.getPstock()) {
			int st = cbean.getCamount() - cbean.getPstock();
%>
			<script>
				alert("<%=cbean.getPname()%> 상품의 재고 수량이 <%=st%> 개 부족합니다.\n 수량을 수정해 주세요.");
				location.href="cartlist.jsp";
			</script>	
<%
			break;
		}
	}
%>
		<div class="alert alert-info" role="alert"><%=user_name%>님의 배송정보입니다.</div>
		<form action="orderok.jsp" method="post" class="order-form">
		<div class="row mb-3">
			<label for="name" class="col-sm-2 col-form-label text-primary">받는 사람</label>
			<div class="col-sm-2">
				<input type="text" name="oname" class="form-control" id="name">
			</div>
		</div>
		<div class="row mb-3">
			<label for="tel" class="col-sm-2 col-form-label text-primary">배송지 연락처</label>
			<div class="col-sm-2">
				<input type="text" name="otel" class="form-control" id="tel">
			</div>
		</div>
		<div class="row mb-3">
			<label for="addr" class="col-sm-2 col-form-label text-primary">배송지 주소</label>
			<div class="col-sm-3">
				<input type="text" name="oaddr" class="form-control" id="addr">
			</div>
		</div>
		<div class="alert alert-info" role="alert">Your Order</div>
		<hr />
 		<table class="table table-striped">
        <thead>
            <tr>
                <th scope="col">Image</th>
                <th scope="col">Product</th>
                <th scope="col">Quantity</th>
                <th scope="col" class="num">Unit Price</th>
                <th scope="col" class="num">Price</th>
            </tr>
        </thead>
        <tbody>
		<%
		int cart_total = 0;
		for(CartBean cbean : list) {
			int cart_num=cbean.getCnum();
			int pro_num=cbean.getPnum();
			String pro_name=cbean.getPname();
			String pro_img=cbean.getPimg();
			int pro_price=cbean.getPprice();
			int pro_stock=cbean.getPstock();
			int cart_amount=cbean.getCamount();
			int pro_sum = cart_amount*pro_price;
			cart_total +=pro_sum;
		%>
                <tr>
                    <th scope="row"><a href="">
                            <img src="<%=request.getContextPath()%>/upimg/<%=pro_img%>" class="img-thumbnail" width="100">
                        </a>
                    </th>
                    <td><%=pro_name%></td>
                    <td><%=cart_amount%>(<%=pro_stock%>)</td>
                    <td class="num"><fmt:formatNumber type="currency" value="<%=pro_price%>" /></td>
                    <td class="num"><fmt:formatNumber type="currency" value="<%=pro_price*cart_amount%>" /></td>
                </tr>
		<%
		}
		%>
		<tr class="total">
            <td>Total</td>
            <td colspan="2"></td>
            <td colspan="2" class="num"><div class="alert alert-success " role="alert"><fmt:formatNumber type="currency" value="<%=cart_total%>" /></div></td>
        </tr>
        </tbody>
    </table>
	<input type="submit" class="btn btn-danger float-right" value="주문하기">
	</form>
	<div style="height:50px;"></div>
<%
}
%>
<%@ include file="bottom.jsp"%>			