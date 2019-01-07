<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장을 작성하기 위해  추가-->
<% request.setCharacterEncoding("UTF-8"); %> <!--  UTF-8 데이터 한글처리 -->
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>  <!-- vo -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userEmail"/>
<jsp:setProperty name="user" property="userGender"/>
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
			if(userID != null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인이 되어있습니다.')");
				script.println("loaction.href = 'main.jsp'");
				script.println("</script>");
			}	
				
			if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
			user.getUserEmail() == null || user.getUserGender()== null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 항목이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");	
			} else {
				UserDAO userDAO = new UserDAO();
				int result = userDAO.join(user);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디 입니다.')");
					script.println("histroy.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter(); // 회원가입 했을시 ,로그인 했을 시 세션 저장
					script.println("<script>");
					script.println("location.href='main.jsp'");
					script.println("</script>");
		         }
		     }
		%>
</body>
</html>