package kr.co.acorn.dao;

public class NewMemberDao {
	private static NewMemberDao single;
	private NewMemberDao() {

	}
	public static NewMemberDao getInstance() {
		if (single == null) {
			single = new NewMemberDao();
		}
		return single;
	}
	
	
	
	
	
	
}
