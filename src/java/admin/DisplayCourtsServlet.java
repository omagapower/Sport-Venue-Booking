/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import java.sql.Time;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import bean.Court;
import bean.CourtList;
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

/**
 *
 * @author MSI
 */
@WebServlet(name = "DisplayCourtsServlet", urlPatterns = {"/DisplayCourtsServlet"})
public class DisplayCourtsServlet extends HttpServlet {

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

        CourtList list = new CourtList();

        String name = "", location = "", picture = "default.jpg", status = "Free/Attended";
        int id;
        double price;

        //for the booking search results
        String bookingStatus;
        Time start, end;

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

        String sqlSearch = "SELECT * FROM booking WHERE courtid = ? AND day = ?";
        String sqlInsert = "SELECT * FROM courts";

        try {

            //get courts list
            PreparedStatement preparedStatement = con.prepareStatement(sqlInsert);
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

                //check if court is being used right now
                PreparedStatement preparedStatement1 = con.prepareStatement(sqlSearch);
                preparedStatement1.setInt(1, id);
                preparedStatement1.setString(2, date);
                ResultSet rs1 = preparedStatement1.executeQuery();
                while (rs1.next()) {
                    start = rs1.getTime("start");
                    end = rs1.getTime("end");
                    bookingStatus = rs1.getString("status");

                    if ("Approved".equals(bookingStatus)) {
                        if ((currTime.after(start)) && (currTime.before(end))) {
                            status = "In Process";
                        }

                        if ((currTime.after(start)) && (currTime.equals(end))) {
                            status = "In Process";
                        }

                        if ((currTime.equals(start)) && (currTime.before(end))) {
                            status = "In Process";
                        }

                    }
                }

                court.setStatus(status);

                list.setChild(court);

                status = "Free/Attended";

            }

        } catch (SQLException ex) {
            throw new ServletException("Failed to retrieve court data", ex);
        }
        
        session.setAttribute("list", list);

        out.println("<script>");
        out.println("    window.location = '/admin.jsp'");
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
