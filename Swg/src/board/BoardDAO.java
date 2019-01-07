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
	
	// 날짜 
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
		return ""; // DB오류 
	}
	
	//게시글 번호
	public int getNext() {
		String SQL = "SELECT boardID FROM boardList ORDER BY boardID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; // 다음글 
			}
			return 1; //첫 번째 게시물
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류 
	}
	//글쓰기
	public int write(String boardTitle, String userID, String boardContent) {
		String SQL = "INSERT INTO boardList VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); // 테이블 생성할떄 boardID로 잡았던거  게시판 번호글 컬럼
			pstmt.setString(2, boardTitle); 
			pstmt.setString(3, userID); 
			pstmt.setString(4, getDate()); 
			pstmt.setString(5, boardContent); 
			pstmt.setInt(6, 1); // boardAvailable 첫 글 삭제가 아니라 보여줘야 해서 
			return pstmt.executeUpdate(); // insert에서 글 성공적으로 반영시 1반환 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류 
	}
	
}
