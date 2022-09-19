package shop.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import shop.com.bean.ProductBean;
import shop.com.dbconn.DBconn;

public class ProductDAO {
	
	public int getListCount(String search) {
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;

		int cnt=0;
		try {
			
			con = DBconn.getConnection();
			String sql = null;
			if(search == null) {
				sql = " SELECT COUNT(pro_num) FROM product ";
			}else {
				sql = " SELECT COUNT(pro_num) FROM product WHERE pro_name LIKE '%"+search+"%' ";	
			}
			//System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			 }
						
		} catch (SQLException ex) {
			System.out.println("prodoct 조회가 실패했습니다.");
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

	public ArrayList<ProductBean> allSelectProduct(int page, int limit, String search) {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<ProductBean> list = new ArrayList<ProductBean>();

		try {
			con = DBconn.getConnection();

			int total_record = getListCount(search);
			int start = (page - 1) * limit;
			int index = start + 1;
			
			String sql = null;
			if(search == null) {
				sql = " SELECT * FROM product ";
			}else {
				sql = " SELECT * FROM product WHERE pro_name LIKE '%"+search+"%' ";	
			}
			pstmt = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = pstmt.executeQuery();
			//System.out.println(sql);
			while(rs.absolute(index)){
				ProductBean pbean = new ProductBean();
				pbean.setPnum(rs.getInt("pro_num"));
				pbean.setPname(rs.getString("pro_name"));
				pbean.setPprice(rs.getInt("pro_price"));
				pbean.setPstock(rs.getInt("pro_stock"));
				pbean.setPimg(rs.getString("pro_img"));
				pbean.setPdesc(rs.getString("pro_desc"));
				pbean.setPhot(rs.getString("pro_hot"));
				pbean.setPnew(rs.getString("pro_new"));
				pbean.setPdisplay(rs.getString("pro_display"));
				pbean.setPday(rs.getString("pro_day"));
				pbean.setPlike(rs.getInt("pro_like"));
				 
				list.add(pbean);

				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;

			 }
						
		} catch (SQLException ex) {
			System.out.println("product 조회가 실패했습니다.");
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
	
	public ArrayList<ProductBean> hotSelectProduct() {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<ProductBean> list = new ArrayList<ProductBean>();

		try {
			con = DBconn.getConnection();
			
			String sql = null;
			
			sql = " SELECT * FROM product WHERE pro_hot='y' ORDER BY pro_num DESC ";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				ProductBean pbean = new ProductBean();
				pbean.setPnum(rs.getInt("pro_num"));
				pbean.setPname(rs.getString("pro_name"));
				pbean.setPprice(rs.getInt("pro_price"));
				pbean.setPstock(rs.getInt("pro_stock"));
				pbean.setPimg(rs.getString("pro_img"));
				pbean.setPlike(rs.getInt("pro_like"));
				 
				list.add(pbean);
			 }
						
		} catch (SQLException ex) {
			System.out.println("product 조회가 실패했습니다.");
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
	
	public ArrayList<ProductBean> newSelectProduct() {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<ProductBean> list = new ArrayList<ProductBean>();

		try {
			con = DBconn.getConnection();
			
			String sql = null;
			
			sql = " SELECT * FROM product WHERE pro_new='y' ORDER BY pro_num DESC ";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				ProductBean pbean = new ProductBean();
				pbean.setPnum(rs.getInt("pro_num"));
				pbean.setPname(rs.getString("pro_name"));
				pbean.setPprice(rs.getInt("pro_price"));
				pbean.setPstock(rs.getInt("pro_stock"));
				pbean.setPimg(rs.getString("pro_img"));
				pbean.setPlike(rs.getInt("pro_like"));
				 
				list.add(pbean);
			 }
						
		} catch (SQLException ex) {
			System.out.println("product 조회가 실패했습니다.");
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
	
	public int insertProduct(ProductBean pbean){
		
		Connection con = null;
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();

			String sql = "INSERT INTO Product VALUES(null,?,?,?,?,?,?,?,?,CURDATE(),0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pbean.getPname());
			pstmt.setInt(2, pbean.getPprice());
			pstmt.setInt(3, pbean.getPstock());
			pstmt.setString(4, pbean.getPimg());
			pstmt.setString(5, pbean.getPdesc());
			pstmt.setString(6, pbean.getPhot());
			pstmt.setString(7, pbean.getPnew());
			pstmt.setString(8, pbean.getPdisplay());
			rss = pstmt.executeUpdate();
						
		} catch (SQLException ex) {
			System.out.println("Product 테이블 삽입이 실패했습니다.<br>");
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

	
	public int updateProduct(ProductBean pbean){
		
		Connection con = null;
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    String sql2 = null;
	    
		try {
			con = DBconn.getConnection();
			// 새로 업로드된 이미지가 있는 경우 이미지 파일명 업데이트
			if(pbean.getPimg() !=null) sql2 = ", pro_img=?";
			else sql2 = "";
			
			int pnum = pbean.getPnum();
			
			String sql = " UPDATE Product set pro_name=?, pro_price=?, pro_stock=?, pro_desc=?, pro_hot=?, pro_new=?, pro_display=? "+sql2+" WHERE pro_num="+pnum;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pbean.getPname());
			pstmt.setInt(2, pbean.getPprice());
			pstmt.setInt(3, pbean.getPstock());
			pstmt.setString(4, pbean.getPdesc());
			pstmt.setString(5, pbean.getPhot());
			pstmt.setString(6, pbean.getPnew());
			pstmt.setString(7, pbean.getPdisplay());
			if(pbean.getPimg() !=null) pstmt.setString(8, pbean.getPimg());
			rss = pstmt.executeUpdate();
			
			System.out.println(sql);
						
		} catch (SQLException ex) {
			System.out.println("Product 테이블 삽입이 실패했습니다.<br>");
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
	
	public ProductBean infoProduct(int num){
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    ProductBean pbean = new ProductBean();

		try {
			
			con = DBconn.getConnection();
			String sql = " SELECT * FROM product WHERE pro_num=? ";	

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				
				pbean.setPname(rs.getString("pro_name"));
				pbean.setPprice(rs.getInt("pro_price"));
				pbean.setPstock(rs.getInt("pro_stock"));
				pbean.setPimg(rs.getString("pro_img"));
				pbean.setPdesc(rs.getString("pro_desc"));
				pbean.setPhot(rs.getString("pro_hot"));
				pbean.setPnew(rs.getString("pro_new"));
				pbean.setPdisplay(rs.getString("pro_display"));
				pbean.setPday(rs.getString("pro_day"));
				pbean.setPlike(rs.getInt("pro_like"));
			}
						
		} catch (SQLException ex) {
			System.out.println("Product 조회가 실패했습니다.");
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
		
		return pbean;
	}
	
	public String getProductImg(int num){
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    String pimg = null;

		try {
			
			con = DBconn.getConnection();
			String sql = " SELECT pro_img FROM product WHERE pro_num=? ";	

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				pimg = rs.getString("pro_img");
				
			}
						
		} catch (SQLException ex) {
			System.out.println("Product 조회가 실패했습니다.");
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
		
		return pimg;
	}
	
	public int deleteProduct(int num){
		
		Connection con = null;
	    PreparedStatement pstmt = null;
	    int rss = 0;

		try {
			
			con = DBconn.getConnection();
			String sql = " DELETE FROM product WHERE pro_num=? ";	

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rss = pstmt.executeUpdate();
						
		} catch (SQLException ex) {
			System.out.println("Product 삭제가 실패했습니다.");
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
	
	public int likeProduct(int pnum){
		
		Connection con = null;
	    int rss = 0;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    PreparedStatement pstmt2 = null;
	    
		try {
			con = DBconn.getConnection();
			
			String sql = " UPDATE Product set pro_like=pro_like+1 WHERE pro_num="+pnum;
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			String sql2 = " SELECT pro_like FROM product WHERE pro_num="+pnum;			
			pstmt2 = con.prepareStatement(sql2);
			rs = pstmt2.executeQuery();
			if(rs.next()){
				rss = rs.getInt("pro_like");
				
			}
			
						
		} catch (SQLException ex) {
			System.out.println("Product 테이블 수정이 실패했습니다.<br>");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( pstmt2 != null ){ pstmt2.close(); pstmt2=null; }
				if ( rs != null ){ rs.close(); rs=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return rss;
	}
	
	public int updateStockProduct(int pnum, int pamount){
		
		Connection con = null;
	    int rss = 0;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    PreparedStatement pstmt2 = null;
	    
		try {
			con = DBconn.getConnection();
			
			String sql = " UPDATE Product set pro_stock=pro_stock-? WHERE pro_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pamount);
			pstmt.setInt(2, pnum);
			rss = pstmt.executeUpdate();
			
						
		} catch (SQLException ex) {
			System.out.println("Product 테이블 수정이 실패했습니다.<br>");
			System.out.println("SQLException: " + ex.getMessage());
			throw new RuntimeException(ex.getMessage());
		} finally {
			
			try{
				if ( pstmt != null ){ pstmt.close(); pstmt=null; }
				if ( pstmt2 != null ){ pstmt2.close(); pstmt2=null; }
				if ( rs != null ){ rs.close(); rs=null; }
				if ( con != null ){ con.close(); con=null;	}
			}catch(Exception e){
				System.out.println("SQLException: " + e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return rss;
	}

}
