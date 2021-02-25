
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<c:if test="${sessionScope.adminloggedin == null}">
    <% response.sendRedirect(request.getContextPath() + "/index.jsp"); %>
</c:if>

<jsp:useBean id="adminloggedin" class="bean.User" scope="session" />




<html lang="en-US">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Profile</title>
    <link rel="stylesheet" href="css/components.css">
    <link rel="stylesheet" href="css/icons.css">
    <link rel="stylesheet" href="css/responsee.css">
    <link rel="stylesheet" href="owl-carousel/owl.carousel.css">
    <link rel="stylesheet" href="owl-carousel/owl.theme.css">
    <link rel="stylesheet" href="css/lightcase.css">
    <!-- CUSTOM STYLE -->      
    <link rel="stylesheet" href="css/template-style.css">
    <link href="https://fonts.googleapis.com/css?family=Work+Sans:100,400,600,900&subset=latin-ext" rel="stylesheet"> 
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>      
  </head>

  <body class="size-1140">
  	    <div id="page-wrapper">
      <!-- HEADER -->
      <header role="banner" class="position-absolute margin-top-30 margin-m-top-0 margin-s-top-0">    
        <!-- Top Navigation -->
        <nav class="background-transparent background-transparent-hightlight full-width sticky">
          <div class="s-12 l-2">
            <a href="index.html" class="logo">
              <!-- Logo version before sticky nav -->
              <img class="logo-before" src="img/logo-dark.png" alt="">
              <!-- Logo version after sticky nav -->
              <img class="logo-after" src="img/logo-dark.png" alt="">
            </a>
          </div>
          <div class="s-12 l-10">
            <div class="top-nav right">
              <p class="nav-text"></p>
              <ul class="right chevron">
                <li><a href="index.html">Home</a></li>
                <li><a href="editProfileAdmin.jsp">Edit Profile</a></li>             
                <li><a href="logout.jsp">Logout</a></li>
              </ul>
            </div>
          </div>  
        </nav>
      </header>
      
      <!-- MAIN -->
      <main role="main">
        <!-- Content -->
        <article>
            <div class="line text-center">        
              <h1 class="text-dark text-s-size-30 text-m-size-40 text-l-size-headline text-thin text-line-height-1">Add Court</h1>
            </div>  
            <br><br><br>
            <div class="s-12 m-12 l-4 center">
              <form action="AddCourtServlet" name="AddCourt" class="customform" method="post">
                <div class="s-12">
                </div>
                <div class="s-12"> 
                  <input name="name" class="subject" placeholder="Court Name" title="name" type="text">
                </div>
                  <br><br><br><br>
                  <div class="s-12"> 
                  <input name="location" class="subject" placeholder="Location" title="location" type="text">
                </div>
                  <br><br><br><br>
                  <div class="s-12"> 
                  <input name="price" class="subject" placeholder="Price/hour" title="price" step="0.01" type="number">
                </div>
                  <br><br><br><br>
                  

                <div class="s-12"><button class="s-12 submit-form button background-primary text-white" type="submit">Add Court</button></div>
              </form>
            </div>           

        </article>
      </main>
      <br><br><br><br>
      <!-- FOOTER -->
      <footer>
        <!-- Contact Us -->
        <div class="background-dark padding text-center footer-social">
          <a class="margin-right-10" target="_blank" href="https://www.facebook.com"><i class="icon-facebook_circle text-size-30"></i> <span class="text-strong text-white hide-s hide-m">FACEBOOK</span></a>
          <a class="margin-right-10" target="_blank" href="https://www.twitter.com"><i class="icon-twitter_circle text-size-30"></i> <span class="text-strong text-white hide-s hide-m">TWITTER</span></a>
          <a class="margin-right-10" target="_blank" href="https://www.instagram.com"><i class="icon-instagram_circle text-size-30"></i> <span class="text-strong text-white hide-s hide-m">INSTAGRAM</span></a>
          <a target="_blank" href="https://www.linkedin.com"><i class="icon-linked_in_circle text-size-30"></i> <span class="text-strong text-white hide-s hide-m">LINKEDIN</span></a>                                                                         
        </div>

        <hr class="break margin-top-bottom-0" style="border-color: rgba(0, 0, 0, 0.80);">
        
        <!-- Bottom Footer -->
        <section class="padding background-dark full-width">
          <div class="text-center">
            <p class="text-size-12">Copyright 2019, Vision Design - graphic zoo</p>
          </div>
        </section>
      </footer>
    </div>
    <script type="text/javascript" src="js/responsee.js"></script>
    <script type="text/javascript" src="js/jquery.events.touch.js"></script>
    <script type="text/javascript" src="owl-carousel/owl.carousel.js"></script>
    <script type="text/javascript" src="js/template-scripts.js"></script> 
  </body>
</html>