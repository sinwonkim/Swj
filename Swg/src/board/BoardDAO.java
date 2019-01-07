package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BoardDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BoardDAO() {
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
	
	// ��¥ 
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB���� 
	}
	
	//�Խñ� ��ȣ
	public int getNext() {
		String SQL = "SELECT boardID FROM boardList ORDER BY boardID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; // ������ 
			}
			return 1; //ù ��° �Խù�
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB���� 
	}
	//�۾���
	public int write(String boardTitle, String userID, String boardContent) {
		String SQL = "INSERT INTO boardList VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); // ���̺� �����ҋ� boardID�� ��Ҵ���  �Խ��� ��ȣ�� �÷�
			pstmt.setString(2, boardTitle); 
			pstmt.setString(3, userID); 
			pstmt.setString(4, getDate()); 
			pstmt.setString(5, boardContent); 
			pstmt.setInt(6, 1); // boardAvailable ù �� ������ �ƴ϶� ������� �ؼ� 
			return pstmt.executeUpdate(); // insert���� �� ���������� �ݿ��� 1��ȯ 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB���� 
	}
	
}
