import static org.junit.Assert.*;

import org.junit.Test;

import shop.com.bean.MemberBean;
import shop.com.dao.MemberDAO;

public class MemberTest {

	@Test
	public void testLoginMember() {
		
		MemberDAO mdao = new MemberDAO();

		MemberBean mbean = mdao.loginMember("test", "1234");
		
		System.out.println(mbean.getNum());
		assertEquals(2, mbean.getNum());
		//fail("Not yet implemented");
	}

}
