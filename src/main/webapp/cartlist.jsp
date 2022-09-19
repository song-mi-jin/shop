<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.com.dao.CartDAO"%>
<%@ page import="shop.com.bean.CartBean"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ include file="top.jsp"%>
<script> 
  function submit2(frm, id) { 
    frm.action="cartmodify.jsp?=cart_num="+id;
    frm.submit(); 
    return true; 
  } 
</script>
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
%>
		<p><%=user_name%>님의 장바구니 정보입니다.</p>
		<hr />
		<form action="cartdel.jsp" method="post">
 		<table class="table table-striped">
        <thead>
            <tr>
                <th scope="col">Image</th>
                <th scope="col">Product</th>
                <th scope="col">Quantity</th>
                <th scope="col">Remove</th>
                <th scope="col" class="num">Unit Price</th>
                <th scope="col" class="num">Price</th>
				<th scope="col"></th>
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
                    <td><input type="checkbox" name="cnum" value="<%=cart_num%>"> <%=pro_name%></td>
                    <td><%=cart_amount%>(<%=pro_stock%>)</td>
                    <td><a href="cartdel.jsp?cart_num=<%=cart_num%>" class="btn btn-success btn-sm">삭제</a></td>
                    <td class="num"><fmt:formatNumber type="currency" value="<%=pro_price%>" /></td>
                    <td class="num"><fmt:formatNumber type="currency" value="<%=pro_price*cart_amount%>" /></td>
		    <td class="num">
		    <form action="" method="post">
		    <input type="number" name="amount" min="1" max="100" value="<%=cart_amount%>">
		    <input type="hidden" name="cart_num" value="<%=cart_num%>">
		    <input type="submit" class="btn btn-danger btn-sm" value="수정" onclick="return submit2(this.form, <%=cart_num%>);">
		</form>
		</td>
                </tr>
		<%
		}
		%>
		<tr class="total">
            <td>Total</td>
            <td colspan="4"></td>
            <td colspan="2" class="num"><fmt:formatNumber type="currency" value="<%=cart_total%>" /></td>
        </tr>
        </tbody>
    </table>
	<input type="submit" class='btn btn-success' value="선택삭제">
	<a href="orderadd.jsp" class="btn btn-primary">주문하기</a>
	<a href="products.jsp" class='btn btn-secondary'>쇼핑 계속하기</a>
	</form>
	<div style="height:50px;"></div>
<%
}
%>
<%@ include file="bottom.jsp"%>			