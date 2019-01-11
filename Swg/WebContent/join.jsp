<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width ,initial-scale=1"> <!-- 컴,핸폰 어느것이든  해상도에 맞게 디자인 맞추는 용도  -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 부트스트랩 사용하겠다. -->
<title>Insert title here</title>
<style type="text/css">
 a:hover { text-decoration: underline;}
 a:link { text-decoration: none;}
</style>
</head>
<body>
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
			
			<a href="https://github.com/sinwonkim"><img src="images/unp2.PNG" alt="이미지 " style="width:50px;height:50px; font-style: lightblue">sinwon's git</a>
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
	    <ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"  data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expended="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu" style="min-width: 80px;">
						<li><a href="login.jsp">로그인</a></li>
						<li class="active"><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
		</ul>		
	  </div>
	</nav>
	
	<!-- 회원가입 -->
	<div class="container">
      <form class="form-signin" method="post" action="joinAction.jsp">
        <h2 class="form-signin-heading" style="text-align: center;">회원 가입</h2>
        <label for="userID" class="sr-only">아이디</label>
        <input type="text" class="form-control" placeholder="아이디" id="userID" name="userID" required autofocus>
        <label for="userName" class="sr-only">이름</label>
        <input type="text" class="form-control" placeholder="이름" id="userName" name="userName" required>
        <label for="userPassword" class="sr-only">비밀번호</label>
        <input type="password" class="form-control" placeholder="비밀번호" id="userPassword" name="userPassword" required>
        <label for="userEmail" class="sr-only">이메일</label>
        <input type="email" class="form-control" placeholder="이메일" id="userEmail" name="userEmail" required>
      	<div class="checkbox" data-toggle="buttons" style="text-align: center">
			<label class="btn btn-primary">
				<input type="checkbox" name="userGender" autocomplete="off" value="남자" checked>남자	
			</label>
			<label class="btn btn-primary">
			 	<input type="checkbox" name="userGender" autocomplete="off" value="여자" checked>여자	
			</label>		
	 	</div>
	 	<button class="btn btn-lg btn-primary btn-block" type="submit" value="회원가입">회원가입</button>
      </form>
    </div> <!-- /container -->
<script
  src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
 <script src="js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</body>
</html>