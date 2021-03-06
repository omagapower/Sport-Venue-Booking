
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ page import="bean.Court" %>
<%@ page import="bean.CourtList" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>



<jsp:useBean id="Rlist" class="bean.CourtList" scope="session"/>
<jsp:useBean id="Rblist" class="bean.BookingList" scope="session"/>
<jsp:useBean id="Report" class="bean.Report" scope="session"/>


<c:if test="${sessionScope.adminloggedin == null}">
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
        <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">

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
                    <br><br>
                    <div class="line text-center">        
                        <h1 class="text-dark text-s-size-30 text-m-size-40 text-l-size-headline text-thin text-line-height-1">Court Report</h1><br>
                    </div> 
                    <br><br>
                    <div class="background-white full-width"> 
                        <div class="line text-center"> 
                            <div class="container">


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row justify-content-center">
                                            <table class="table table-striped">
                                                <c:forEach var="v" begin="0" items="${Rlist.list}">
                                                    <c:if test="${not empty v.id}">
                                                        <tr>
                                                            <td>
                                                                <h2>
                                                                    Court ID: ${v.id} <br>
                                                                    Court Name: ${v.name} <br><br>
                                                                    Booked ${Report.booking} times <br>
                                                                    Approved bookings: ${Report.approved} <br>
                                                                    Declined bookings: ${Report.declined} <br>
                                                                    Canceled bookings: ${Report.cancelled} <br>
                                                                    Bookings awaiting approval: ${Report.booking-(Report.approved+Report.cancelled+Report.declined)} <br><br>
                                                                    Booking Price: RM${v.price}/hour<br>
                                                                    Total Booking time (approved bookings only): ${Report.totalTime} hours<br>
                                                                    Money Earned (approved bookings only): RM${Report.earned}
                                                                </h2>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>  
                    </div>
                </article>
            </main>

            <br><br>
        </div>

        <script type="text/javascript" src="js/responsee.js"></script>
        <script type="text/javascript" src="js/jquery.events.touch.js"></script>
        <script type="text/javascript" src="owl-carousel/owl.carousel.js"></script>
        <script type="text/javascript" src="js/template-scripts.js"></script> 
        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>