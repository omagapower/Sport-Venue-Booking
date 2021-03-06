
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
        <title>Add Court</title>
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
                            <div>

                                <input type="radio" name="picture" value="default.jpg">
                                <label for="picture1"><img style="width:250px;height:250px;" src="img/default.jpg"> </label><br>
                                <input type="radio" name="picture" value="default2.jpg">
                                <label for="picture2"><img style="width:250px;height:250px;" src="img/default2.jpg"> </label><br>
                                <input type="radio" name="picture" value="default3.jpg">
                                <label for="picture3"><img style="width:250px;height:250px;" src="img/default3.jpg"> </label><br>
                                <input type="radio" name="picture" value="default4.jpg">
                                <label for="picture4"><img style="width:250px;height:250px;" src="img/default4.jpg"> </label><br>

                            </div>



                            <div class="s-12"><button class="s-12 submit-form button background-primary text-white" type="submit">Add Court</button></div>
                        </form>
                    </div>           

                </article>
            </main>
            <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
            <!-- FOOTER -->
            <footer>
                    <span>Photo by <a href="https://unsplash.com/@sarkozhevnikov?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Evgeny Kozhevnikov</a> on <a href="https://unsplash.com/s/photos/volleyball-court?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span> <br>
                    <span>Photo by <a href="https://unsplash.com/@storiesofg?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Gilda Gonzàlez</a> on <a href="https://unsplash.com/s/photos/tennis-court?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span> <br>
                    <span>Photo by <a href="https://unsplash.com/@emilevictorp?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Emile-Victor Portenart</a> on <a href="https://unsplash.com/s/photos/soccer-court?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span> <br>
                    <span>Photo by <a href="https://unsplash.com/@xamh?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Max Hermansson</a> on <a href="https://unsplash.com/s/photos/soccer-court?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span> <br>
            </footer>
        </div>
        <script type="text/javascript" src="js/responsee.js"></script>
        <script type="text/javascript" src="js/jquery.events.touch.js"></script>
        <script type="text/javascript" src="owl-carousel/owl.carousel.js"></script>
        <script type="text/javascript" src="js/template-scripts.js"></script> 
    </body>
</html>