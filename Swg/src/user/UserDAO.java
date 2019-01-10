package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {
	
	private Connection conn;
	private	PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL ="jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword ="1234"; 
			Class.forName("com.mysql.jdbc.Driver"); 
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 
		} catch(Exception e) {
			e.printStackTrace(); 
		}
	}
	
	public ArrayList<User> search(String userName){
		String SQL = "SELECT * FROM USER WHERE userName LIKE ?";
		ArrayList<User> userList = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserName(rs.getString(1));
				user.setUserID(rs.getString(2));
				user.setUserEmail(rs.getString(3));
				userList.add(user);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return userList;
	}
	
	
	public int login(String userID,String userPassword) { 
		String SQL = "SELECT userPassword FROM USER WHERE userID =?"; 
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 1 로그인 성공
				}
				else 
					return 0; // 0 로그인 실패 
			}
			return -1; // 아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;// 데이터베이스 오류
	}
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserGender());
			return pstmt.executeUpdate(); // 성공시 1 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 실패 DB오류 
	}
}
