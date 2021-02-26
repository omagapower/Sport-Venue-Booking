
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:if test="${sessionScope.clientloggedin != null}">
    <% response.sendRedirect(request.getContextPath() + "/client.jsp"); %>
</c:if>

<c:if test="${sessionScope.adminloggedin != null}">
    <% response.sendRedirect(request.getContextPath() + "/admin.jsp"); %>
</c:if>

<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="fonts/icomoon/style.css">

    <link rel="stylesheet" href="css/owl.carousel.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    
    <!-- Style -->
    <link rel="stylesheet" href="css/style.css">

    <title>Register</title>
  </head>
  <body>
  

  <div class="d-lg-flex half">
    <div class="bg order-1 order-md-2" style="background-image: url('img/bg.jpg');"></div>
    <div class="contents order-2 order-md-1">

      <div class="container">
        <div class="row align-items-center justify-content-center">
          <div class="col-md-7">
              <h3>Register to <strong>SCBS</strong></h3>
            <p class="mb-4">A way to book sport courts with no hassle.</p>
            <form action="RegisterServlet" method="post">
              <div class="form-group first">
                <label for="username">Username</label>
                <input type="text" class="form-control" placeholder="your-email@gmail.com" id="login" name="login">
              </div>
                <div class="form-group first">
                <label for="name">Full name</label>
                <input type="text" class="form-control" placeholder="Your Name" id="fullname" name="fullname">
              </div>
              <div class="form-group last mb-3">
                <label for="password">Password</label>
                <input type="password" class="form-control" placeholder="Your Password" id="password" name="password">
              </div>
              <div class="form-group last mb-3">
                <label for="confpassword">Confirm Password</label>
                <input type="password" class="form-control" placeholder="Confirm Password" id="confpassword" name="confpassword">
              </div>
                <div class="d-flex mb-5 align-items-center">
                <span class="ml-auto"><a href="index.jsp" class="forgot-pass">Already got an account?</a></span> 
               </div>
              

              <input type="submit" value="Register" class="btn btn-block btn-primary">

            </form>
          </div>
        </div>
      </div>
    </div>

    
  </div>
    <span>Photo by <a href="https://unsplash.com/@ripato?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Ricardo Gomez Angel</a> on <a href="https://unsplash.com/s/photos/soccer-court?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>

    

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
  </body>
</html>