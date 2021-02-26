<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.Court" %>
<%@ page import="bean.CourtList" %>

<jsp:useBean id="clientloggedin" class="bean.User" scope="session"/>
<jsp:useBean id="list" class="bean.CourtList" scope="session"/>



<c:if test="${sessionScope.clientloggedin == null}">
    <% response.sendRedirect(request.getContextPath() + "/index.jsp");%>
</c:if>

<html lang="en-US">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Football Courts</title>
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
                                <li><a href="DisplayPersonalBookingServlet?id=<jsp:getProperty name="clientloggedin" property="id"/> ">View My Bookings</a></li>
                                <li><a href="editProfile.jsp">Edit Profile</a></li>             
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
                        <h1 class="text-dark text-s-size-30 text-m-size-40 text-l-size-headline text-thin text-line-height-1">Court List</h1>
                    </div>
                    <div class="background-white full-width"> 

                        <c:forEach var="v" begin="0" items="${list.list}">
                            <c:if test="${not empty v.id}">
                                <div class="s-12 m-6 l-five">
                                    <a class="image-with-hover-overlay image-hover-zoom" href="DisplayBookingServlet?id=${v.id}" title="Portfolio Image">
                                        <div class="image-hover-overlay background-primary"> 
                                            <div class="image-hover-overlay-content text-center padding-2x">
                                                <h3 class="text-white text-size-20 margin-bottom-10">${v.name}</h3>
                                                <p class="text-white text-size-14 margin-bottom-20">Location: ${v.location}<br>Price: ${v.price}<br>Court Number: ${v.id}</p>  
                                            </div> 
                                        </div> 
                                        <img class="full-img" src="img/${v.picture}" alt=""/>
                                    </a>	
                                </div>
                            </c:if>
                        </c:forEach >
                    </div>  
                </article>
            </main>

        </div>


        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        
        <footer>
            <span>Photo by <a href="https://unsplash.com/@sarkozhevnikov?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Evgeny Kozhevnikov</a> on <a href="https://unsplash.com/s/photos/volleyball-court?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span> <br>
            <span>Photo by <a href="https://unsplash.com/@storiesofg?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Gilda Gonzàlez</a> on <a href="https://unsplash.com/s/photos/tennis-court?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span> <br>
            <span>Photo by <a href="https://unsplash.com/@emilevictorp?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Emile-Victor Portenart</a> on <a href="https://unsplash.com/s/photos/soccer-court?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span> <br>
            <span>Photo by <a href="https://unsplash.com/@xamh?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Max Hermansson</a> on <a href="https://unsplash.com/s/photos/soccer-court?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span> <br>
            </footer>

        <script type="text/javascript" src="js/responsee.js"></script>
        <script type="text/javascript" src="js/jquery.events.touch.js"></script>
        <script type="text/javascript" src="owl-carousel/owl.carousel.js"></script>
        <script type="text/javascript" src="js/template-scripts.js"></script> 
    </body>
</html>