package shop.com.dao;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import shop.com.bean.MemberBean;
import shop.com.dbconn.DBconn;

public class MemberDAO {
	    
	public int getListCount(String search) {
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;

		int cnt=0;
		try {
			
			con = DBconn.getConnection();
			String sql = null;
			if(search == null) {
				sql = " SELECT COUNT(mem_num) FROM member ";
			}else {
				sql = " SELECT COUNT(mem_num) FROM member WHERE mem_name LIKE '%"+search+"%' ";	
			}
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				cnt = rs.getInt(1);
			 }
						
		} catch (SQLException ex) {
			System.out.println("member 조회가 실패했습니다.");
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

	public ArrayList<MemberBean> allSelectMember(int page, int limit, String search) {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();

		try {
			con = DBconn.getConnection();

			int total_record = getListCount(search);
			int start = (page - 1) * limit;
			int index = start + 1;
			
			String sql = null;
			if(search == null) {
				sql = " SELECT * FROM member ";
			}else {
				sql = " SELECT * FROM member WHERE mem_name LIKE '%"+search+"%' ";	
			}
			pstmt = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = pstmt.executeQuery();
			//System.out.println(sql);
			while(rs.absolute(index)){
				MemberBean mbean = new MemberBean(); //컬럼으로 나뉘어진 데이터를 빈 클래스에 저장 
				mbean.setNum(rs.getInt("mem_num"));
				mbean.setId(rs.getString("mem_id"));
				mbean.setName(rs.getString("mem_name"));
				mbean.setTel(rs.getString("mem_tel"));
				mbean.setZipcode(rs.getString("mem_zipcode"));
				mbean.setAddr(rs.getString("mem_addr"));
				mbean.setMday(rs.getString("mem_day"));
				 
				list.add(mbean);

				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;

			 }
						
		} catch (SQLException ex) {
			System.out.println("member 조회가 실패했습니다.");
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
	

	public MemberBean infoMember(int num){
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    MemberBean mbean = new MemberBean();

		try {
			
			con = DBconn.getConnection();
			String sql = " SELECT * FROM member WHERE mem_num=? ";	
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				
				mbean.setNum(rs.getInt("mem_num"));
				mbean.setId(rs.getString("mem_id"));
				mbean.setPwd(rs.getString("mem_pwd"));
				mbean.setName(rs.getString("mem_name"));
				mbean.setTel(rs.getString("mem_tel"));
				mbean.setZipcode(rs.getString("mem_zipcode"));
				mbean.setAddr(rs.getString("mem_addr"));
				mbean.setMday(rs.getString("mem_day"));
				
			}
						
		} catch (SQLException ex) {
			System.out.println("member 조회가 실패했습니다.");
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
		
		return mbean;
	}
	
	public Boolean getSearchID(String id){
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    Boolean rsid = false;

		try {
			
			con = DBconn.getConnection();
			String sql = " SELECT mem_id FROM member WHERE mem_id=? ";	
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				// 동일한 아이디가 존재하면 true를 리턴
				rsid=true;				
			}
						
		} catch (SQLException ex) {
			System.out.println("member 조회가 실패했습니다.");
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
		
		return rsid;
	}
	
	public int insertMember(MemberBean mbean){
		
		Connection con = null;
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();

			String sql = "INSERT INTO member VALUES(null,?,?,?,?,?,?,CURDATE())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mbean.getId());
			pstmt.setString(2, mbean.getPwd());
			pstmt.setString(3, mbean.getName());
			pstmt.setString(4, mbean.getTel());
			pstmt.setString(5, mbean.getZipcode());
			pstmt.setString(6, mbean.getAddr());
			rss = pstmt.executeUpdate();
						
		} catch (SQLException ex) {
			System.out.println("member 테이블 삽입이 실패했습니다.<br>");
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
	
	public int updateMember(MemberBean mbean){
		
		Connection con = null;
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();

			String sql = "UPDATE member SET mem_pwd=?, mem_name=?, mem_tel=?, mem_zipcode=?, mem_addr=? WHERE mem_num=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, mbean.getPwd());
			pstmt.setString(2, mbean.getName());
			pstmt.setString(3, mbean.getTel());
			pstmt.setString(4, mbean.getZipcode());
			pstmt.setString(5, mbean.getAddr());
			pstmt.setInt(6, mbean.getNum());
			rss = pstmt.executeUpdate();
						
		} catch (SQLException ex) {
			System.out.println("member 정보 수정이 실패했습니다.<br>");
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
	
	public ArrayList<MemberBean> todaySelectMember() {
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();

		try {
			con = DBconn.getConnection();

			String sql = " SELECT * FROM member WHERE mem_day =CURDATE() ";	
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()){
				MemberBean mbean = new MemberBean();

				mbean.setNum(rs.getInt("mem_num"));
				mbean.setId(rs.getString("mem_id"));
				mbean.setName(rs.getString("mem_name"));
				mbean.setTel(rs.getString("mem_tel"));
				mbean.setZipcode(rs.getString("mem_zipcode"));
				mbean.setAddr(rs.getString("mem_addr"));
				mbean.setMday(rs.getString("mem_day"));
				 
				list.add(mbean);

			 }
						
		} catch (SQLException ex) {
			System.out.println("member 조회가 실패했습니다.");
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
	
	public int batchDeleteMember(String[] id){
		
		Connection con = null;
	    int[] cnt = new int[id.length];
	    int rss = 0;
	    PreparedStatement pstmt = null;
	    
		try {
			con = DBconn.getConnection();

			String sql = "DELETE FROM member WHERE mem_id=?";
			pstmt = con.prepareStatement(sql);

			for(String mid : id) {

				pstmt.setString(1, mid);
				pstmt.addBatch();
				//pstmt.clearParameters();
				//각각의 쿼리 문이 다를경우 이전 쿼리문 리셋

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
	
	public MemberBean loginMember(String id, String pwd){
		
		Connection con = null;
	    ResultSet rs = null;
	    PreparedStatement pstmt = null;
	    MemberBean mbean = new MemberBean();

		try {
			
			con = DBconn.getConnection();
			String sql = " SELECT mem_num, mem_name FROM member WHERE mem_id=? AND mem_pwd=? ";	
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()){				
				
				mbean.setNum(rs.getInt("mem_num"));
				mbean.setName(rs.getString("mem_name"));
				
			}
						
		} catch (SQLException ex) {
			System.out.println("member 조회가 실패했습니다.");
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
		//System.out.println(mbean.getNum());
		return mbean;
	
	}
}
