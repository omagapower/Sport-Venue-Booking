
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ page import="bean.Court" %>
<%@ page import="bean.CourtList" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>


<jsp:useBean id="list" class="bean.CourtList" scope="session"/>



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
                        <h1 class="text-dark text-s-size-30 text-m-size-40 text-l-size-headline text-thin text-line-height-1">Court Management</h1><br>
                        <div class="s-12"><button onclick="window.location.href = 'addCourt.jsp'" class="s-12 submit-form button background-primary text-white">Add Court</button></div>
                    </div> 
                    <br><br>
                    <div class="background-white full-width"> 
                        <div class="line text-center"> 
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-md-6 text-center mb-5">
                                        <h2 class="heading-section">Courts</h2>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="table-wrap">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Id</th>
                                                        <th>Court Name</th>
                                                        <th>Location</th>
                                                        <th>Price/hour</th>
                                                        <th>Status</th>
                                                        <th></th>
                                                        <th>Update</th>
                                                        <th>Delete</th>
                                                        <th></th>
                                                        <th></th>
                                                        <th>Report</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="v" begin="0" items="${list.list}">
                                                        <c:if test="${not empty v.id}">
                                                            <tr>
                                                                <td><c:out value="${v.id}" /></td>
                                                                <td><c:out value="${v.name}" /></td>
                                                                <td><c:out value="${v.location}" /></td>
                                                                <td>RM<c:out value="${v.price}" />/hour</td>
                                                                <td><c:out value="${v.status}" /></td>
                                                                <td></td>
                                                                <td><a href="updateCourt.jsp?id=${v.id}" class="btn btn-success">Update</a></td>
                                                                <td><a href="DeleteCourtServlet?id=${v.id}" class="btn btn-success">Delete</a></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td><a href="ReportCourtServlet?id=${v.id}" class="btn btn-success">Get Report</a></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach >

                                                </tbody>
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