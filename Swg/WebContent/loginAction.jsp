<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장을 작성하기 위해  추가-->
<% request.setCharacterEncoding("UTF-8"); %> <!--  UTF-8 넘어오는 데이터 한글처리-->
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>  <!-- 자바빈 객체 생성  -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
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
			UserDAO userDAO = new UserDAO();		
			int result = userDAO.login(user.getUserID(),user.getUserPassword());
			if(result == 1){
				session.setAttribute("userID", user.getUserID()); //로그인 ,회원가입 했을 시 세션 저장 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			else if(result == 0) {
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(result == -1) {
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(result == -2){
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		%>
</body>
</html>