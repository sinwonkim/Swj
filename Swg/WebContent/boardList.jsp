<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 자바 라이브러리 추가 -->
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardList" %>
<%@ page import="java.util.ArrayList" %> 
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
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null ){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
	        <li class="active"><a href="#">게시판</a></li> 
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
						<th style="background-color: #eeeeee; text-align:center;">번호</th>
						<th style="background-color: #eeeeee; text-align:center;">제목</th>
						<th style="background-color: #eeeeee; text-align:center;">작성자</th>
						<th style="background-color: #eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BoardDAO boardDAO = new BoardDAO();
						ArrayList<BoardList> list = boardDAO.getList(pageNumber);
						for(int i = 0; i <list.size(); i++){
					%>	
					<tr>
						<td><%= list.get(i).getBoardID()%></td>
						<td><a href="view.jsp?boardID=<%= list.get(i).getBoardID()%>"><%=list.get(i).getBoardTitle()%></a></td>
						<td><%= list.get(i).getUserID()%></td>
						<td><%= list.get(i).getBoardDate().substring(0,11) + list.get(i).getBoardDate().substring(11,13)+"시 " + list.get(i).getBoardDate().substring(14,16) + "분" %></td>
					</tr>
					<% 		
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){	
			%>
				<a href="boardList.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(boardDAO.nextPage(pageNumber + 1)){
			%>		
				<a href="boardList.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<% 	
				}
			%>
			<a href="boardWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>