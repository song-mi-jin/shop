package shop.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import shop.com.bean.OrderListBean;
import shop.com.bean.OrderItemBean;
import shop.com.bean.CartBean;
import shop.com.dao.CartDAO;
import shop.com.dao.ProductDAO;
import shop.com.dbconn.DBconn;

public class OrderDAO {

	public int getListCount(String sdate, String sw, String ss) {
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;

		int cnt=0;
		try {
			
			con = DBconn.getConnection();
			String sql = null;
			String sql2 = "";
			String sql3 = "";
			
			if(sdate !=null && sdate !="") {
				sql2 = " AND date_format(o.order_date, '%Y-%c')='"+sdate+"'";
			}
			
			if(ss !=null && ss !="") {
				sql3 = " AND o.order_status='"+ss+"'";
			}
			sql = " SELECT COUNT(o.order_num) FROM orderlist AS o LEFT JOIN member AS m ON o.mem_num=m.mem_num WHERE m.mem_name LIKE '%"+sw+"%'"+sql2+sql3;

			//System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			 }
						
		} catch (SQLException ex) {
			System.out.println("orderlist 조회가 실패했습니다.");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( rs != null ){ rs.close(); rs=null; }
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return cnt;

	}
	
	public ArrayList<OrderListBean> allSelectOrderList(int page, int limit, String sdate, String sw, String ss) {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<OrderListBean> list = new ArrayList<OrderListBean>();

		try {
			con = DBconn.getConnection();

			int total_record = getListCount(sdate, sw, ss);
			int start = (page - 1) * limit;
			int index = start + 1;
			
			String sql = null;
			String sql2 = "";
			String sql3 = "";
			
			if(sdate !=null && sdate !="") {
				sql2 = " AND date_format(o.order_date, '%Y-%c')='"+sdate+"'";
			}
			
			if(ss !=null && ss !="") {
				sql3 = " AND o.order_status='"+ss+"'";
			}
			sql = " SELECT m.mem_name, m.mem_id, o.* FROM orderlist AS o LEFT JOIN member AS m ON o.mem_num=m.mem_num WHERE m.mem_name LIKE '%"+sw+"%'"+sql2+sql3;
			
			System.out.println(sql);
			
			pstmt = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = pstmt.executeQuery();

			while(rs.absolute(index)){
				OrderListBean olbean = new OrderListBean();
				olbean.setOnum(rs.getInt("order_num"));
				olbean.setMnum(rs.getInt("mem_num"));
				olbean.setMname(rs.getString("mem_name"));
				olbean.setMid(rs.getString("mem_id"));
				olbean.setOcode(rs.getString("order_code"));
				olbean.setOname(rs.getString("order_name"));
				olbean.setOtel(rs.getString("order_tel"));
				olbean.setOaddr(rs.getString("order_addr"));
				olbean.setOstatus(rs.getString("order_status"));
				olbean.setOdate(rs.getString("order_date"));
				olbean.setDelivery(rs.getString("delivery"));
				olbean.setDelivery_no(rs.getString("delivery_no"));
				 
				list.add(olbean);

				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;

			 }
						
		} catch (SQLException ex) {
			System.out.println("OrderList 조회가 실패했습니다.");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( rs != null ){ rs.close(); rs=null; }
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return list;
		
	}
	
	public ArrayList<OrderListBean> memberSelectOrderList(int mnum) {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<OrderListBean> list = new ArrayList<OrderListBean>();

		try {
			con = DBconn.getConnection();
			
			String sql = null;

			sql = " SELECT * FROM orderlist WHERE mem_num="+mnum+" ORDER BY order_num DESC";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()){
				OrderListBean olbean = new OrderListBean();
				olbean.setOnum(rs.getInt("order_num"));
				olbean.setMnum(rs.getInt("mem_num"));
				olbean.setOcode(rs.getString("order_code"));
				olbean.setOname(rs.getString("order_name"));
				olbean.setOtel(rs.getString("order_tel"));
				olbean.setOaddr(rs.getString("order_addr"));
				olbean.setOstatus(rs.getString("order_status"));
				olbean.setOdate(rs.getString("order_date"));
				olbean.setDelivery(rs.getString("delivery"));
				olbean.setDelivery_no(rs.getString("delivery_no"));
				 
				list.add(olbean);

			 }
						
		} catch (SQLException ex) {
			System.out.println("OrderList 조회가 실패했습니다.");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( rs != null ){ rs.close(); rs=null; }
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return list;
		
	}
	
	public ArrayList<OrderItemBean> memberSelectOrderItem(String ocode) {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<OrderItemBean> list = new ArrayList<OrderItemBean>();

		try {
			con = DBconn.getConnection();
			
			String sql = null;

			sql = " SELECT p.pro_name, p.pro_img, o.* FROM OrderItem AS o LEFT JOIN product AS p ON o.pro_num=p.pro_num WHERE o.order_code='"+ocode+"'";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()){
				OrderItemBean oibean = new OrderItemBean();
				oibean.setInum(rs.getInt("item_num"));
				oibean.setOcode(rs.getString("order_code"));
				oibean.setPnum(rs.getInt("pro_num"));
				oibean.setPname(rs.getString("pro_name"));
				oibean.setPimg(rs.getString("pro_img"));
				oibean.setIprice(rs.getInt("item_price"));
				oibean.setIamount(rs.getInt("item_amount"));
				 
				list.add(oibean);

			 }
						
		} catch (SQLException ex) {
			System.out.println("OrderItem 조회가 실패했습니다.");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( rs != null ){ rs.close(); rs=null; }
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return list;
		
	}

	public int getOrderMember(int num) {
		
		Connection con = null;
	    PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt=0;
		try {
			
			con = DBconn.getConnection();
			String sql =  " SELECT COUNT(order_num) FROM orderlist WHERE mem_num=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			 }
						
		} catch (SQLException ex) {
			System.out.println("order 조회가 실패했습니다.");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return cnt;

	}
	
	public OrderListBean getOrderInfo(String ocode) {
		
		Connection con = null;
	    PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderListBean obean = new OrderListBean();
		
		try {
			
			con = DBconn.getConnection();
			String sql =  " SELECT * FROM orderlist WHERE order_code=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ocode);
			rs = pstmt.executeQuery();
			if(rs.next()){
				obean.setOnum(rs.getInt("order_num"));
				obean.setOname(rs.getString("order_name"));
				obean.setOtel(rs.getString("order_tel"));
				obean.setOaddr(rs.getString("order_addr"));
				obean.setOstatus(rs.getString("order_status"));
				obean.setOdate(rs.getString("order_date"));
				obean.setDelivery(rs.getString("delivery"));
				obean.setDelivery_no(rs.getString("delivery_no"));
			 }
						
		} catch (SQLException ex) {
			System.out.println("order 조회가 실패했습니다.");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return obean;

	}
	
	public int addOrder(OrderListBean obean){
		
		Connection con = null;
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();
			String sql = null;
			sql = "INSERT INTO orderlist VALUES (null,?,?,?,?,?,NOW(),'주문완료',NULL,NULL) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, obean.getOcode());
			pstmt.setInt(2, obean.getMnum());
			pstmt.setString(3, obean.getOname());
			pstmt.setString(4, obean.getOtel());
			pstmt.setString(5, obean.getOaddr());

			rss = pstmt.executeUpdate();
						
		} catch (SQLException ex) {
			System.out.println("cart 테이블 수정 실패했습니다.<br>");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return rss;
	}


	public int addOrderItem(int mnum, String ocode){
		
		Connection con = null;
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();

			CartDAO cdao = new CartDAO();
			ArrayList<CartBean> list = cdao.memberSelectCart(mnum);

			int[] cnt = new int[list.size()];

			String sql = null;
			sql = "INSERT INTO orderitem VALUES (null,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);
			
			ProductDAO pdao = new ProductDAO();
			
			for(CartBean cbean : list) {			
				pstmt.setString(1, ocode);
				pstmt.setInt(2, cbean.getPnum());
				pstmt.setInt(3, cbean.getPprice());
				pstmt.setInt(4, cbean.getCamount());
				pstmt.addBatch();
				
				//재고 수량 조정
				pdao.updateStockProduct(cbean.getPnum(), cbean.getCamount());
			}
			cnt = pstmt.executeBatch();
			
			// 장바구니 삭제
			cdao.deleteCart(mnum);
			
			for(int i=0; i<cnt.length; i++) {
				if(cnt[i] != -2) rss++;
			}
						
		} catch (SQLException ex) {
			System.out.println("orderitem 테이블 등록이 실패했습니다.<br>");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
	
		return rss;
	}
	
	public int batchUpdateStatus(String[] ocode, String ostatus){
		
		Connection con = null;
	    int[] cnt = new int[ocode.length];
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();

			String sql = " UPDATE orderlist set order_status=? WHERE order_code=?";
			pstmt = con.prepareStatement(sql);

			for(String order_code : ocode) {

				pstmt.setString(1, ostatus);
				pstmt.setString(2, order_code);
				pstmt.addBatch();

			}


			cnt = pstmt.executeBatch();
						
		} catch (SQLException ex) {
			System.out.println("Orderlist 테이블  수정이 실패했습니다.<br>");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		for(int i=0; i<cnt.length; i++) {
			if(cnt[i] != -2) rss++;
		}

		return rss;
	}
}
