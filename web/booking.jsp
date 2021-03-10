
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="bean.Court" %>
<%@ page import="bean.CourtList" %>
<%@ page import="bean.Booking" %>
<%@ page import="bean.BookingList" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>



<jsp:useBean id="list" class="bean.CourtList" scope="session"/>
<jsp:useBean id="blist" class="bean.BookingList" scope="session"/>



<c:if test="${sessionScope.clientloggedin == null}">
    <% response.sendRedirect(request.getContextPath() + "/index.jsp");%>
</c:if>

<jsp:useBean id="clientloggedin" class="bean.User" scope="session" />




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
                    <%
                        int id = Integer.parseInt(request.getParameter("id"));
                        session.setAttribute("id", id);
                        
                        //set today as default value for date input
                        Date current = new java.util.Date();
                        
                        DateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
                        
                        String date = sdf.format(current);
                        
                        session.setAttribute("date", date);
                    %>

                    <c:set var="id" value="${sessionScope.id}"/>

                    <c:forEach var="v" begin="0" items="${list.list}">
                        <c:if test="${v.id == id}">

                            <div class="line text-center">        
                                <h1 class="text-dark text-s-size-30 text-m-size-40 text-l-size-headline text-thin text-line-height-1">Book ${v.name}</h1>
                            </div>  


                            <div class="s-12 m-12 l-4 center">
                                <img class="full-img" src="img/${v.picture}" alt=""/>
                            </div>
                        </c:if>
                    </c:forEach >
                    <br><br>



                    <div class="s-12 m-12 l-4 center">
                        <form action="BookCourtServlet" name="BookCourt" class="customform" method="post">


                            <c:set var="id" value="${sessionScope.id}"/>
                            <c:set var="date" value="${sessionScope.date}"/>

                            <input type="hidden" name="courtId" value="${id}">
                            <input type="hidden" name="userId" value="<jsp:getProperty name="clientloggedin" property="id"/>">
                            <input type="hidden" name="currentDay" value="${date}">
                            <div class="s-12">
                            </div>
                            <div class="s-12">
                                 P.S. The date will be set to todays date if left empty
                                <input name="day" placeholder="Day" title="name" type="date"">
                            </div>
                            <div class="s-12">
                                Start Time
                            </div>
                            
                            <div class="s-12 m-12 l-6">
                                <input value="00" name="starth" class="subject" placeholder="Start time: hour" title="start" type="number" min="0" max="23"> <b></b>
                            </div>
                            <div class="s-12 m-12 l-6">
                                <input style="margin-left:30px;" value="00" name="startm" class="subject" placeholder="Start time: minute" title="start" type="number" min="0" max="59">
                            </div>
                            <div class="s-12">
                                End Time
                            </div>
                            
                            <div class="s-12 m-12 l-6"> 
                                
                                <input  name="endh" value="23" class="subject" placeholder="End time: hour" title="time" type="number" min="0" max="23"> <b></b>
                            </div>
                            <div class="s-12 m-12 l-6">
                                <input style="margin-left:30px;" name="endm" value="59" class="subject" placeholder="End time: minute" title="time" type="number" min="0" max="59">
                            </div>
                            <br><br><br><br>


                            <div class="s-12"><button class="s-12 submit-form button background-primary text-white" type="submit">Book</button></div>
                        </form>
                    </div>


                    <div class="s-12 m-12 l-4 center">
                        <h2>Current Bookings: </h2>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-wrap">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Booking</th>
                                                <th>Date </th>
                                                <th>Start Time</th>
                                                <th>End Time </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="v" begin="0" items="${blist.list}">
                                                <c:if test="${not empty v.id}">
                                                    <c:if test="${v.status != 'Cancelled'}">
                                                        <c:if test="${v.status != 'Declined'}">
                                                            <tr>
                                                                <td><c:out value="${v.id}" /></td>
                                                                <td><c:out value="${v.day}" /></td>
                                                                <td><c:out value="${v.start}" /></td>
                                                                <td><c:out value="${v.end}" /></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach >

                                        </tbody>
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
