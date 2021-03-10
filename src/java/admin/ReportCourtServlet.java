/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import java.sql.Time;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import bean.Report;
import bean.Court;
import bean.CourtList;
import bean.Booking;
import bean.BookingList;
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
import java.text.DecimalFormat;

@WebServlet(name = "ReportCourtServlet", urlPatterns = {"/ReportCourtServlet"})
public class ReportCourtServlet extends HttpServlet {

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

        Report report = new Report();
        CourtList list = new CourtList();
        BookingList blist = new BookingList();

        int courtId = Integer.parseInt(request.getParameter("id"));
        int userId, bookingAmount = 0, approved = 0, declined = 0, attended = 0, cancelled = 0;
        String day;
        String name = "", location = "", picture = "default.jpg";
        int id;
        double price = 0, earned = 0, bookTime = 0, startTotalHours = 0, endTotalHours = 0, totalTime = 0;

        //for the booking search results
        String bookingStatus;
        Time start, end;

        //get the current date and time in correct format
        SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm");
        DateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");

        Date current = new java.util.Date();

        String currentString = sdf1.format(current);

        long curr = 0;
        try {
            curr = sdf1.parse(currentString).getTime();
        } catch (ParseException ex) {
            Logger.getLogger(DisplayCourtsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        Time currTime = new Time(curr);

        String date = sdf.format(current);

        String sqlInsert = "SELECT * FROM courts WHERE id = ?";
        String sqlSearch = "SELECT * FROM booking WHERE courtid = ?";

        try {

            //get courts list
            PreparedStatement preparedStatement = con.prepareStatement(sqlInsert);
            preparedStatement.setInt(1, courtId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {

                id = rs.getInt("id");
                price = rs.getDouble("price");
                name = rs.getString("name");
                location = rs.getString("location");
                picture = rs.getString("picture");

                Court court = new Court();
                court.setId(id);
                court.setLocation(location);
                court.setName(name);
                court.setPrice(price);
                court.setPicture(picture);

                list.setChild(court);

            }

            //check if court is being used right now
            PreparedStatement preparedStatement1 = con.prepareStatement(sqlSearch);
            preparedStatement1.setInt(1, courtId);
            ResultSet rs1 = preparedStatement1.executeQuery();

            while (rs1.next()) {
                userId = rs1.getInt("userId");
                start = rs1.getTime("start");
                end = rs1.getTime("end");
                day = rs1.getString("day");
                bookingStatus = rs1.getString("status");

                if ("Approved".equals(bookingStatus)) {
                    approved++;

                    String startString = start.toString();
                    String[] hourMin = startString.split(":");
                    double starthour = Integer.parseInt(hourMin[0]);
                    double startmins = Integer.parseInt(hourMin[1]);
                    double starthoursInMins = starthour * 60;
                    startTotalHours = (starthoursInMins + startmins) / 60;

                    String endString = end.toString();
                    String[] endhourMin = endString.split(":");
                    double endhour = Integer.parseInt(endhourMin[0]);
                    double endmins = Integer.parseInt(endhourMin[1]);
                    double endhoursInMins = endhour * 60;
                    endTotalHours = (endhoursInMins + endmins) / 60;

                    totalTime = endTotalHours - startTotalHours;

                    earned += (price * totalTime);
                }
                if ("Declined".equals(bookingStatus)) {
                    declined++;
                }
                if ("Cancelled".equals(bookingStatus)) {
                    approved++;
                }
                bookingAmount++;

                Booking booking = new Booking();

                booking.setUserId(userId);
                booking.setCourtId(courtId);
                booking.setStart(start);
                booking.setEnd(end);
                booking.setDay(day);

                blist.setChild(booking);

            }
            
            
            DecimalFormat df = new DecimalFormat("###.##");
            String earnedRounded = df.format(earned);
            String totalTimeRounded = df.format(totalTime);
            

            report.setBooking(bookingAmount);
            report.setApproved(approved);
            report.setDeclined(declined);
            report.setCancelled(cancelled);
            report.setCourtId(courtId);
            report.setEarned(Double.parseDouble(earnedRounded));
            report.setTotalTime(Double.parseDouble(totalTimeRounded));

        } catch (SQLException ex) {
            throw new ServletException("Failed to retrieve court data", ex);
        }

        session.setAttribute("Report", report);
        session.setAttribute("Rlist", list);
        session.setAttribute("Rblist", blist);

        out.println("<script>");
        out.println("    window.location = '/courtReport.jsp'");
        out.println("</script>");
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
        processRequest(request, response);
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
