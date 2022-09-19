import static org.junit.Assert.*;

import org.junit.Test;

import shop.com.dao.MemberDAO;

public class MemberIDTest {

	@Test
	public void testGetSearchID() {
		
		MemberDAO mdao = new MemberDAO();
		// 아이디 중복 검사
		Boolean rsid = mdao.getSearchID("test111");
		
		assertTrue("true 가 아님니다", rsid);
		
		
	}

}
