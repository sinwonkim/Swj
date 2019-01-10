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
	
	// ����¡ ����ó��
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
	
	//�� �ҷ����� �뵵
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
	
	// ������Ʈ 
	public int update(int boardID,String boardTitle,String boardContent) {
		String SQL = "UPDATE BoardList SET boardTitle = ?, boardContent = ? WHERE boardID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle); 
			pstmt.setString(2, boardContent);
			pstmt.setInt(3, boardID); 
			return pstmt.executeUpdate(); // insert���� �� ���������� �ݿ��� 1��ȯ 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB���� 
	}
	
	public int delete(int boardID) {
		String SQL = "UPDATE BoardList SET boardAvailable = 0 WHERE boardID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);  
			return pstmt.executeUpdate(); // insert���� �� ���������� �ݿ��� 1��ȯ 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB���� 
	}
	
}
