<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="board.BoardDAO" %> 
<%@ page import="board.BoardList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width ,initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Do what</title>
</head>
<body>


	<%
		String userID = null;
		if(session.getAttribute("userID") != null ){
			userID	= (String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href= 'login.jsp'");
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
		}
	%>
		


	<!-- Nav쪽 -->
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <div class="navbar-header">
	    	<button type="button" class="navbar-toggle collapsed" 
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Home</a>
	    </div>
	    <div  id="#bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	        <li><a href="#">1번 메뉴</a></li>
	        <li><a href="#">2번 메뉴</a></li> 
	        <li class="active"><a href="boardList.jsp">게시판</a></li> 
	      </ul>
	    </div>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"  data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expended="false">회원관리<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃</a></li> 
				</ul>
			</li>
		</ul>
	  </div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="boardUpdateAction.jsp?boardID=<%=boardID%>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글수정</th>	
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="boardTitle" maxlength="50" value="<%= boardList.getBoardTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea  class="form-control" placeholder="글 내용" name="boardContent" maxlength="2048" style="height:350px;"><%= boardList.getBoardContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정" onclick="return confirm('수정 하시겠습니까?')">
			</form>		
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>