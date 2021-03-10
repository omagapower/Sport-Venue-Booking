
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.Court" %>
<%@ page import="bean.CourtList" %>
<%@ page import="bean.Booking" %>
<%@ page import="bean.BookingList" %>

<jsp:useBean id="pblist" class="bean.BookingList" scope="session"/>
<jsp:useBean id="clientloggedin" class="bean.User" scope="session" />


<c:if test="${sessionScope.clientloggedin == null}">
    <% response.sendRedirect(request.getContextPath() + "/index.jsp");%>
</c:if>






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







                    <div class="s-12 m-12 l-4 center">
                        <h2>Current Bookings: </h2>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-wrap">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Booking</th>
                                                <th>Court</th>
                                                <th>Date </th>
                                                <th>Start Time</th>
                                                <th>End Time</th>
                                                <th>Status </th>
                                                <th>Cancel </th>
                                            </tr>
                                        </thead>

                                        <c:forEach var="v" begin="0" items="${pblist.list}">
                                            <c:if test="${not empty v.id}">
                                                <c:if test="${v.status!='Cancelled'}">
                                                    <tr>
                                                        <td><c:out value="${v.id}" /></td>
                                                        <td><c:out value="${v.courtId}" /></td>
                                                        <td><c:out value="${v.day}" /></td>
                                                        <td><c:out value="${v.start}" /></td>
                                                        <td><c:out value="${v.end}" /></td>
                                                        <td><c:out value="${v.status}" /></td>
                                                        <c:if test="${v.status!='Approved'}">
                                                            <c:if test="${v.status!='Declined'}">
                                                                <td><a href="CancelBookingServlet?id=${v.id}&user=${v.userId}" class="btn btn-success">Cancel</a></td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                </c:if>
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
