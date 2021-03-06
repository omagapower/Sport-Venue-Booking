
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<c:if test="${sessionScope.adminloggedin == null}">
    <% response.sendRedirect(request.getContextPath() + "/index.jsp");%>
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
                                <li><a href="DisplayBookingServletAdmin">Manage Bookings</a></li>
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
                        <h1 class="text-dark text-s-size-30 text-m-size-40 text-l-size-headline text-thin text-line-height-1">Edit Profile</h1>
                    </div>  
                    <section class="section background-white">
                        <div class="s-12 m-12 l-4 center">
                            <h4 class="text-size-20 margin-bottom-20 text-dark text-center">Edit Profile</h4>
                            <form action="EditProfileServlet" name="editProfile" class="customform" method="post">
                                <div class="s-12">
                                    <div class="margin">
                                        <input type="hidden" name="oldlogin" value="<jsp:getProperty name="adminloggedin" property="login"/>">
                                        <input type="hidden" name="userType" value="<jsp:getProperty name="adminloggedin" property="userType"/>">
                                        <input type="hidden" name="oldPassword" value="<jsp:getProperty name="adminloggedin" property="password"/>">
                                        <input type="hidden" name="salt" value="<jsp:getProperty name="adminloggedin" property="salt"/>">
                                        <div class="s-12 m-12 l-6">
                                            <input name="login" class="required email" title="login" type="text" value="<jsp:getProperty name="adminloggedin" property="login"/>">
                                        </div>
                                        <div class="s-12 m-12 l-6">
                                            <input name="fullName" class="name" title="Your name" type="text" value="<jsp:getProperty name="adminloggedin" property="fullName"/>">
                                        </div>
                                    </div>
                                </div>
                                <div class="s-12"> 
                                    <input name="password" class="subject" placeholder="new password" title="password" type="password">
                                </div>
                                <div class="s-12"> 
                                    <input name="confpassword" class="subject" placeholder="confirm new password" title="confpassword" type="password">
                                </div>

                                <div class="s-12"><button class="s-12 submit-form button background-primary text-white" type="submit">Edit Profile</button></div>
                            </form>
                        </div>           
                    </section> 
                </article>
            </main>
        </div>

        <script type="text/javascript" src="js/responsee.js"></script>
        <script type="text/javascript" src="js/jquery.events.touch.js"></script>
        <script type="text/javascript" src="owl-carousel/owl.carousel.js"></script>
        <script type="text/javascript" src="js/template-scripts.js"></script> 
    </body>
</html>