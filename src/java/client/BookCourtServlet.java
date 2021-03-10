/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package client;

import bean.Booking;
import java.sql.Time;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import bean.User;
import java.io.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jdbc.JDBCUtility;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author MSI
 */
@WebServlet(name = "BookCourtServlet", urlPatterns = {"/BookCourtServlet"})
public class BookCourtServlet extends HttpServlet {

    private JDBCUtility jdbcUtility;
    private Connection con;

    /**
     *
     * @throws ServletException
     */
    @Override
    public void init() throws ServletException {
        String driver = "com.mysql.jdbc.Driver";

        String dbName = "sql5398016";
        String url = "jdbc:mysql://sql5.freesqldatabase.com:3306/" + dbName + "?";
        String userName = "sql5398016";
        String password = "Rjxt6itiQA";


        jdbcUtility = new JDBCUtility(driver,
                url,
                userName,
                password);

        jdbcUtility.jdbcConnect();
        con = jdbcUtility.jdbcGetConnection();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        PrintWriter out = response.getWriter();

        //get form data from VIEW > V-I
        int courtId = Integer.parseInt(request.getParameter("courtId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String starth = request.getParameter("starth");
        String startm = request.getParameter("startm");
        String endh = request.getParameter("endh");
        String endm = request.getParameter("endm");
        String currentDay = request.getParameter("currentDay");

        String startd = starth + ":" + startm;
        String endd = endh + ":" + endm;

        SimpleDateFormat startsdf = new SimpleDateFormat("HH:mm");
        SimpleDateFormat endsdf = new SimpleDateFormat("HH:mm");

        long startl = 0;
        try {
            startl = startsdf.parse(startd).getTime();
        } catch (ParseException ex) {
            Logger.getLogger(BookCourtServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        long endl = 0;
        try {
            endl = endsdf.parse(endd).getTime();
        } catch (ParseException ex) {
            Logger.getLogger(BookCourtServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        Time start = new Time(startl);
        Time end = new Time(endl);

        String day = request.getParameter("day");
        if ("".equals(day)) {
            day = currentDay;
        }

        String status = "Awaiting Approval";

        boolean clash = false;
        //sql select variables
        int id1, userId1, courtId1;
        Time start1, end1;
        String day1, status1;

        boolean error = false;

        if (end.before(start)) {
            error = true;
        }

        if (end.equals(start)) {
            error = true;
        }

        String sqlSelect = "SELECT * FROM booking WHERE day = ? AND courtid = ?";
        String sqlInsert = "INSERT INTO booking(courtid, userid, day, start, end, status) VALUES(?, ?, ?, ?, ?, ?);";

        try {
            PreparedStatement preparedStatement1 = con.prepareStatement(sqlSelect);
            preparedStatement1.setString(1, day);
            preparedStatement1.setInt(2, courtId);
            ResultSet rs = preparedStatement1.executeQuery();

            while (rs.next()) {

                start1 = rs.getTime("start");
                end1 = rs.getTime("end");
                status1 = rs.getString("status");

                if ("Approved".equals(status1)) {
                    

                    if (start.equals(start1)) {
                        clash = true;
                    }

                    if (start.after(start1)) {
                        if (start.before(end1)) {
                            clash = true;
                        }
                    }

                    if (end.after(start1)) {
                        if (end.before(end1)) {
                            clash = true;
                        }
                        if (end.equals(end1)) {
                            clash = true;
                        }

                    }

                    if (start.before(start1)) {
                        if (end.after(end1)) {
                            clash = true;
                        }
                    }

                }
                
                if ("Awaiting Approval".equals(status1)) {
                    

                    if (start.equals(start1)) {
                        clash = true;
                    }

                    if (start.after(start1)) {
                        if (start.before(end1)) {
                            clash = true;
                        }
                    }

                    if (end.after(start1)) {
                        if (end.before(end1)) {
                            clash = true;
                        }
                        if (end.equals(end1)) {
                            clash = true;
                        }

                    }

                    if (start.before(start1)) {
                        if (end.after(end1)) {
                            clash = true;
                        }
                    }

                }

            }

            if (!error) {
                if (!clash) {
                    PreparedStatement preparedStatement = con.prepareStatement(sqlInsert);
                    preparedStatement.setInt(1, courtId);
                    preparedStatement.setInt(2, userId);
                    preparedStatement.setString(3, day);
                    preparedStatement.setTime(4, start);
                    preparedStatement.setTime(5, end);
                    preparedStatement.setString(6, status);

                    int insertStatus = 0;
                    insertStatus = preparedStatement.executeUpdate();

                    if (insertStatus == 1) {
                        out.println("<script>");
                        out.println("    alert('Court Added Successfully');");
                        out.println("    window.location = '/DisplayBookingServlet?id=" + courtId + "'");
                        out.println("</script>");
                    }
                } else {
                    out.println("<script>");
                    out.println("    alert('The selected time is already booked! Book at a different time.');");
                    out.println("    window.location = '/DisplayBookingServlet?id=" + courtId + "'");
                    out.println("</script>");
                }
            } else {
                out.println("<script>");
                out.println("    alert('Error. End time cannot be before or equal to start time');");
                out.println("    window.location = '/DisplayBookingServlet?id=" + courtId + "'");
                out.println("</script>");
            }
        } catch (SQLException ex) {
            throw new ServletException("book insert failed", ex);
        }
    }

    void sendPage(HttpServletRequest req, HttpServletResponse res, String fileName) throws ServletException, IOException {
        // Get the dispatcher; it gets the main page to the user
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(fileName);

        if (dispatcher == null) {
            System.out.println("There was no dispatcher");
            // No dispatcher means the html file could not be found.
            res.sendError(res.SC_NO_CONTENT);
        } else {
            dispatcher.forward(req, res);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
