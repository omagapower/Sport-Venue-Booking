/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import bean.Court;
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
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.RandomStringUtils;

/**
 *
 * @author MSI
 */
@WebServlet(name = "UpdateCourtServlet", urlPatterns = {"/UpdateCourtServlet"})
public class UpdateCourtServlet extends HttpServlet {

    private JDBCUtility jdbcUtility;
    private Connection con;

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

        //Get the session object
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();

        String oldName = request.getParameter("oldName");
        String newName = request.getParameter("name");
        String oldLocation = request.getParameter("oldLocation");
        String newLocation = request.getParameter("location");
        String oldPrice = request.getParameter("oldPrice");
        String picture = request.getParameter("picture");
        


        double newPrice = Double.parseDouble(request.getParameter("price"));

        String sqlQuery = "UPDATE courts SET name = ?, location = ?, price = ?, picture = ? WHERE name = ? AND location = ? AND price = ?";

        try {

            PreparedStatement preparedStatement = con.prepareStatement(sqlQuery);
            preparedStatement.setString(1, newName);
            preparedStatement.setString(2, newLocation);
            preparedStatement.setDouble(3, newPrice);
            preparedStatement.setString(4, picture);
            preparedStatement.setString(5, oldName);
            preparedStatement.setString(6, oldLocation);
            preparedStatement.setString(7, oldPrice);

            int insertStatus = 0;
            insertStatus = preparedStatement.executeUpdate();
            if (insertStatus == 1) {

                out.println("<script>");
                out.println("    alert('Court updated successfully');");
                out.println("    window.location = '/DisplayCourtsServlet'");
                out.println("</script>");

            } else {

                out.println("<script>");
                out.println("    alert('Error updating data');");
                out.println("</script>");

            }

        } catch (SQLException ex) {
            throw new ServletException("Update failed", ex);
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
