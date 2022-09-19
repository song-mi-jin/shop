package shop.com.dao;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import shop.com.bean.CartBean;
import shop.com.dbconn.DBconn;

public class CartDAO {
	
	public int getListCount() {
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;

		int cnt=0;
		try {
			
			con = DBconn.getConnection();
			String sql = null;
			sql = " SELECT COUNT(cart_num) FROM cart ";

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			 }
						
		} catch (SQLException ex) {
			System.out.println("cart 조회가 실패했습니다.");
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
	
	public int getCartMember(int num) {
		
		Connection con = null;
	    PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt=0;
		try {
			
			con = DBconn.getConnection();
			String sql =  " SELECT COUNT(cart_num) FROM cart WHERE mem_num=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			 }
						
		} catch (SQLException ex) {
			System.out.println("cart 조회가 실패했습니다.");
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
	
	public ArrayList<CartBean> allSelectCart(int page, int limit) {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<CartBean> list = new ArrayList<CartBean>();

		try {
			con = DBconn.getConnection();

			int total_record = getListCount();
			int start = (page - 1) * limit;
			int index = start + 1;
			
			String sql = null;
			sql = " SELECT m.mem_num, m.mem_name, p.pro_num, p.pro_name, p.pro_price,  c.cart_num, c.cart_amount, c.cart_date FROM cart AS c LEFT JOIN member AS m ON c.mem_num=m.mem_num LEFT JOIN product AS p ON c.pro_num=p.pro_num ";
			
			System.out.println(sql);
			
			pstmt = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = pstmt.executeQuery();
			System.out.println(sql);
			while(rs.absolute(index)){
				CartBean cbean = new CartBean();
				cbean.setCnum(rs.getInt("cart_num"));
				cbean.setMnum(rs.getInt("mem_num"));
				cbean.setMname(rs.getString("mem_name"));
				cbean.setPnum(rs.getInt("pro_num"));
				cbean.setPprice(rs.getInt("pro_price"));
				cbean.setPname(rs.getString("pro_name"));
				cbean.setCamount(rs.getInt("cart_amount"));
				cbean.setCdate(rs.getString("cart_date"));
				 
				list.add(cbean);

				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;

			 }
						
		} catch (SQLException ex) {
			System.out.println("Cart 조회가 실패했습니다.");
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
	
	public ArrayList<CartBean> memberSelectCart(int mnum) {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<CartBean> list = new ArrayList<CartBean>();

		try {
			con = DBconn.getConnection();
			
			String sql = null;
			sql = " SELECT p.pro_name, p.pro_img, p.pro_price, p.pro_stock, c.* FROM cart AS c LEFT JOIN product AS p ON c.pro_num=p.pro_num WHERE c.mem_num="+mnum;			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()){
				CartBean cbean = new CartBean();
				cbean.setCnum(rs.getInt("cart_num"));
				cbean.setMnum(rs.getInt("mem_num"));
				cbean.setPnum(rs.getInt("pro_num"));
				cbean.setPprice(rs.getInt("pro_price"));
				cbean.setPstock(rs.getInt("pro_stock"));
				cbean.setPname(rs.getString("pro_name"));
				cbean.setPimg(rs.getString("pro_img"));
				cbean.setCamount(rs.getInt("cart_amount"));
				cbean.setCdate(rs.getString("cart_date"));
				 
				list.add(cbean);

			 }
						
		} catch (SQLException ex) {
			System.out.println("Cart 조회가 실패했습니다.");
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
	
	public int getCartProduct(int mnum, int pnum) {
		
		Connection con = null;
	    PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt=0;
		try {
			
			con = DBconn.getConnection();
			String sql =  " SELECT cart_num FROM cart WHERE mem_num=? AND pro_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			pstmt.setInt(2, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			 }
						
		} catch (SQLException ex) {
			System.out.println("cart 조회가 실패했습니다.");
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
	
 	public int addCart(CartBean cbean){
		
		Connection con = null;
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();

			int mem_num = cbean.getMnum();
			int pro_num = cbean.getPnum();
			int cart_amount = cbean.getCamount();
			int cnum=0;
			String sql = null;

			cnum = getCartProduct(mem_num, pro_num);
			
			if(cnum !=0) {
				sql = "UPDATE Cart SET cart_amount = cart_amount+?, cart_date=NOW() WHERE cart_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cart_amount);
				pstmt.setInt(2, cnum);

				rss = pstmt.executeUpdate();
			}else{

				sql = "INSERT INTO Cart VALUES (null,?,?,?,NOW()) ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mem_num);
				pstmt.setInt(2, pro_num);
				pstmt.setInt(3, cart_amount);

				rss = pstmt.executeUpdate();
			}
			
			//System.out.println(sql);
						
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
 	
 	public int modCart(int cnum, int amount){
		
		Connection con = null;
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();
	
			String sql = "UPDATE Cart SET cart_amount=? WHERE cart_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, amount);
			pstmt.setInt(2, cnum);
			
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
 	
 	public int deleteCart(int mnum){
		
		Connection con = null;
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();

			String sql = null;

			
			
			sql = "DELETE FROM Cart WHERE mem_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			rss = pstmt.executeUpdate();

						
		} catch (SQLException ex) {
			System.out.println("cart 테이블 삭제 실패했습니다.<br>");
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

 	public int batchDeleteCart(int[] cnum){
		
		Connection con = null;
	    int[] cnt = new int[cnum.length];
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();

			String sql = "DELETE FROM Cart WHERE cart_num=?";
			pstmt = con.prepareStatement(sql);

			for(int cid : cnum) {

				pstmt.setInt(1, cid);
				pstmt.addBatch();

			}


			cnt = pstmt.executeBatch();
						
		} catch (SQLException ex) {
			System.out.println("member 테이블 삭제가 실패했습니다.<br>");
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
