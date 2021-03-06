
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.Court" %>
<%@ page import="bean.CourtList" %>
<%@ page import="bean.Booking" %>
<%@ page import="bean.BookingList" %>

<jsp:useBean id="alllist" class="bean.BookingList" scope="session"/>



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







                    <div class="s-12 m-12 l-4 center">
                        <h2>Current Bookings: </h2>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-wrap">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Booking</th>
                                                <th>CourtID</th>
                                                <th>Date </th>
                                                <th>Start Time</th>
                                                <th>End Time</th>
                                                <th>Status </th>
                                                <th>Approve </th>
                                                <th>Decline </th>
                                            </tr>
                                        </thead>

                                        <c:forEach var="v" begin="0" items="${alllist.list}">
                                            <c:if test="${not empty v.id}">

                                                <tr>
                                                    <td><c:out value="${v.id}" /></td>
                                                    <td><c:out value="${v.courtId}" /></td>
                                                    <td><c:out value="${v.day}" /></td>
                                                    <td><c:out value="${v.start}" /></td>
                                                    <td><c:out value="${v.end}" /></td>
                                                    <td><c:out value="${v.status}" /></td>
                                                    <c:if test="${v.status!='Cancelled'}">
                                                        <c:if test="${v.status!='Approved'}">
                                                            <c:if test="${v.status!='Declined'}">
                                                                <td><a href="ApproveBookingServlet?id=${v.id}" class="btn btn-success">Approve</a></td>
                                                                <td><a href="DeclineBookingServlet?id=${v.id}" class="btn btn-success">Decline</a></td>
                                                            </c:if>
                                                        </c:if>
                                                    </c:if>


                                                </tr>

                                            </c:if>
                                        </c:forEach >


                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </article>
            </main>
            <br><br><br><br>

        </div>
        <script type="text/javascript" src="js/responsee.js"></script>
        <script type="text/javascript" src="js/jquery.events.touch.js"></script>
        <script type="text/javascript" src="owl-carousel/owl.carousel.js"></script>
        <script type="text/javascript" src="js/template-scripts.js"></script> 
    </body>
</html>
