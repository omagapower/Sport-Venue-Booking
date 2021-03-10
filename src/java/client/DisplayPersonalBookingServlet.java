
package client;

import admin.*;
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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jdbc.JDBCUtility;
import java.sql.Time;


/**
 *
 * @author MSI
 */
@WebServlet(name = "DisplayPersonalBookingServlet", urlPatterns = {"/DisplayPersonalBookingServlet"})
public class DisplayPersonalBookingServlet extends HttpServlet {

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
        
        BookingList list = new BookingList();
        
        int search = Integer.parseInt(request.getParameter("id"));
        String day="", status="";
        int id, userId, courtId;
        Time start, end;

        String sqlInsert = "SELECT * FROM booking WHERE userid = ?";
        
        

        try {
            PreparedStatement preparedStatement = con.prepareStatement(sqlInsert);
            preparedStatement.setInt(1, search);
            
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                
                id = rs.getInt("id");
                userId = rs.getInt("userid");
                courtId = rs.getInt("courtid");
                start = rs.getTime("start");
                end = rs.getTime("end");
                day = rs.getString("day");
                status = rs.getString("status");

                Booking booking = new Booking();
                
                booking.setId(id);
                booking.setUserId(userId);
                booking.setCourtId(courtId);
                booking.setStart(start);
                booking.setEnd(end);
                booking.setDay(day);
                booking.setStatus(status);
                
                list.setChild(booking);
                
            }

        } catch (SQLException ex) {
            throw new ServletException("Failed to retrieve court data", ex);
        }
        session.setAttribute("pblist", list);
        
        response.sendRedirect(request.getContextPath() + "/userBooking.jsp");
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







