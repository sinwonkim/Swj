<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="board.BoardDAO" %> 
<%@ page import="board.BoardList" %> 
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%
			String userID = null;                                           
			if(session.getAttribute("userID")!= null){
				userID = (String) session.getAttribute("userID");
			}
			if(userID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요.')");
				script.println("loaction.href = 'login.jsp'");
				script.println("</script>");
			}
			int boardID = 0;
			if (request.getParameter("boardID") !=null){
				boardID = Integer.parseInt(request.getParameter("boardID"));
			}
			if (boardID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글 입니다.')");
				script.println("location.href= 'boardView.jsp'");
				script.println("</script>");
			}
			BoardList boardList = new BoardDAO().getBoardList(boardID);
			if(!userID.equals(boardList.getUserID())){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.')");
				script.println("location.href= 'boardView.jsp'");
				script.println("</script>");
			} else {
							BoardDAO boardDAO = new BoardDAO();
							int result = boardDAO.delete(boardID);
							if(result == -1){ // 반환값 -1 실패
								PrintWriter script = response.getWriter();
								script.println("<script>");
								script.println("alert('글 삭제에 실패하였습니다.')");
								script.println("histroy.back()");
								script.println("</script>");
							}
							else { // 성공적으로 글 작성됬을 때
								PrintWriter script = response.getWriter(); 
								script.println("<script>");
								script.println("location.href = 'boardList.jsp'");
								script.println("</script>");
					         }
			}
				
			
		     
		%>
</body>
</html>