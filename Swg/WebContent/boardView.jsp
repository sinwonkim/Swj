<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardList" %>
<%@ page import="board.BoardDAO" %>
 
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
		int boardID = 0;
		if (request.getParameter("boardID") !=null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if (boardID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href= 'boardList.jsp'");
			script.println("</script>");
		}
		BoardList boardList = new BoardDAO().getBoardList(boardID);
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
	    <!-- 로그인  되었을 때 view,로그인 되지 않았을 때 view -->
	    <%
	    	if(userID == null) {
	    %>
	    <ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"  data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expended="false">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">로그인</a></li> 
					<li><a href="join.jsp">회원가입</a></li>
				</ul>
			</li>
		</ul>
		
		<%
			}else{
		%>	
			<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"  data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expended="false">회원관리<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃</a></li> 
				</ul>
			</li>
		</ul>
		<%
			}
		%>	
	  </div>
	</nav>
	<div class="container">
		<div class="row">
			
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글보기</th>	
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width:200;">글제목</td>
							<td colspan="2"><%= boardList.getBoardTitle().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">","&gt").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= boardList.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= boardList.getBoardDate().substring(0,11) + boardList.getBoardDate().substring(11,13)+"시 " + boardList.getBoardDate().substring(14,16) + "분"  %></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height:200px; text-align: left;"><%= boardList.getBoardContent().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">","&gt").replaceAll("\n","<br>") %></td>
						</tr>
					</tbody>
				</table>
				<a href="boardList.jsp" class="btn btn-primary">게시판 목록</a>
				<%
					if(userID != null && userID.equals(boardList.getUserID())){
				%>
						<a href="boardUpdate.jsp?boardID=<%=boardID %>" class="btn btn-primary">수정</a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="boardDeleteAction.jsp?boardID=<%=boardID %>" class="btn btn-primary">삭제</a>
				<%  		
					}
				%>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">	
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>