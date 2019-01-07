<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장을 작성하기 위해  추가-->
<%
	request.setCharacterEncoding("UTF-8");
%> <!--  UTF-8 데이터 한글처리 -->
<jsp:useBean id="board" class="board.BoardList" scope="page"></jsp:useBean>  
<jsp:setProperty name="board" property="boardTitle"/>
<jsp:setProperty name="board" property="boardContent"/>

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
			}else{
				if(board.getBoardTitle() == null || board.getBoardContent() == null ){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('입력이 안된 항목이 있습니다.')");
							script.println("history.back()");
							script.println("</script>");	
						} else {
							BoardDAO boardDAO = new BoardDAO();
							int result = boardDAO.write(board.getBoardTitle(),userID,board.getBoardContent());
							if(result == -1){ // 반환값 -1 실패
								PrintWriter script = response.getWriter();
								script.println("<script>");
								script.println("alert('글쓰기에 실패하였습니다.')");
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
				
			
		     }
		%>
</body>
</html>