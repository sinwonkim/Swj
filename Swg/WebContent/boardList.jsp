<%@page import="com.sun.xml.internal.txw2.Document"%>
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
<style type="text/css">
	a {
		color: #000000;
		text-decoration: none;
	}
	a:hover {
		color: #8181F7;
		text-decoration: none;	
	}
</style>
<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'></script>
<script type='text/javascript'>
	function filter(){
		if($('#txtFilter').val()=="")
			$("#languageTBody td").css('display','');			
		else{
			$("#languageTBody td").css('display','none');
			$("#languageTBody td[id*='"+$('#txtFilter').val()+"']").css('display','');
		}
		return false;
	}
</script>


</head>
<body>
	<%!
	int page = 22;

	int countList = 10;

	int countPage = 10;


	int totalCount = 255;

	int totalPage = totalCount / countList;
	
	%>
	
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
			<a href="https://github.com/sinwonkim"><img src="images/unp2.PNG" alt="이미지 " style="width:50px;height:50px; font-style: lightblue">Sinwon's git</a>
	    </div>
	    <div>
	    </div>
	    <div  id="#bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav" >
	        <li><a class="navbar-brand " href="main.jsp"  style="margin-left:0px;">Home</a></li>
	        <li><a href="#">2번 메뉴</a></li> 
	        <li><a href="boardList.jsp">게시판</a></li> 
	      </ul>
	    </div>
	    <%
	    	if(userID == null) {
	    %>
	     <ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"  data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expended="false">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu" style="min-width: 80px;">
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
	작성자 검색: <input type='text' id='txtFilter' onkeyup='{filter();return false}' onkeypress='javascript:if(event.keyCode==13){ filter(); return false;}'>
	

			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align:center;">번호</th>
						<th style="background-color: #eeeeee; text-align:center;">제목</th>
						<th style="background-color: #eeeeee; text-align:center;">작성자</th>
						<th style="background-color: #eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody id="languageTBody">
					<%
						BoardDAO boardDAO = new BoardDAO();
						ArrayList<BoardList> list = boardDAO.getList(pageNumber);
						for(int i = 0; i <list.size(); i++){
					%>	
					<tr>
						<td id='<%=list.get(i).getUserID()%>'><%= list.get(i).getBoardID()%></td>
						<td id='<%=list.get(i).getUserID()%>'><a href="boardView.jsp?boardID=<%= list.get(i).getBoardID()%>"><%=list.get(i).getBoardTitle().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">","&gt").replaceAll("\n","<br>")%></a></td>
						<td id='<%=list.get(i).getUserID()%>'><%= list.get(i).getUserID()%></td>
						<td id='<%=list.get(i).getUserID()%>'><%= list.get(i).getBoardDate().substring(0,11) + list.get(i).getBoardDate().substring(11,13)+"시 " + list.get(i).getBoardDate().substring(14,16) + "분" %></td>
					</tr>
					<% 		
						}
					%>
					
				</tbody>
				
			</table>
			<%
				if(pageNumber != 1){	
			%>
				<a href="boardList.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<% 
				} if(boardDAO.nextPage(pageNumber + 1)){
			%>		
				<a href="boardList.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<% 	
				}
			%>
			<a href="boardWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
$(document).ready(function() {
    $("#keyword").keyup(function() {
        var k = $(this).val();
        $("#user-table > tbody > tr").hide();
        var temp = $("#user-table > tbody > tr > td:nth-child(5n+2):contains('" + k + "')");

        $(temp).parent().show();
    })
})
</script>
</body>
</html>