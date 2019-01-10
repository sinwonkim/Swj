package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	public ArrayList<BoardList> getList(int pageNumber){
		String SQL = "SELECT * FROM BoardList WHERE boardID < ? AND boardAvailable = 1 ORDER BY boardID DESC LIMIT 10";
		ArrayList<BoardList> list = new ArrayList<BoardList>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardList boardList = new BoardList();
				boardList.setBoardID(rs.getInt(1));
				boardList.setBoardTitle(rs.getString(2));
				boardList.setUserID(rs.getString(3));
				boardList.setBoardDate(rs.getString(4));
				boardList.setBoardContent(rs.getString(5));
				boardList.setBoardAvailable(rs.getInt(6));
				list.add(boardList);			 
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 페이징 다음처리
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BoardList WHERE boardID < ? AND boardAvailable = 1 ORDER BY boardID DESC LIMIT 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10 );
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int targetPage(int pageNumber) {
		String SQL = "SELECT * COUNT(boardId) FROM boardList WHERE boardID > ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10 );
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) / 10;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	//글 불러오는 용도
	public BoardList getBoardList(int boardID) {
		String SQL = "SELECT * FROM BoardList WHERE boardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				BoardList boardList = new BoardList();
				boardList.setBoardID(rs.getInt(1));
				boardList.setBoardTitle(rs.getString(2));
				boardList.setUserID(rs.getString(3));
				boardList.setBoardDate(rs.getString(4));
				boardList.setBoardContent(rs.getString(5));
				boardList.setBoardAvailable(rs.getInt(6));
				return boardList;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 업데이트 
	public int update(int boardID,String boardTitle,String boardContent) {
		String SQL = "UPDATE BoardList SET boardTitle = ?, boardContent = ? WHERE boardID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle); 
			pstmt.setString(2, boardContent);
			pstmt.setInt(3, boardID); 
			return pstmt.executeUpdate(); // insert에서 글 성공적으로 반영시 1반환 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류 
	}
	
	public int delete(int boardID) {
		String SQL = "UPDATE BoardList SET boardAvailable = 0 WHERE boardID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);  
			return pstmt.executeUpdate(); // insert에서 글 성공적으로 반영시 1반환 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류 
	}
	
}
