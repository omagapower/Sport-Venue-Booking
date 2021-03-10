/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jdbc;

import bean.User;
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

/**
 *
 * @author MSI
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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

        User user = new User();

        //Get the session object
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();

        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String userType = "", fullName = "";

        String sqlQuery = "SELECT * FROM user WHERE login = ?";

        try {
            PreparedStatement preparedStatement = con.prepareStatement(sqlQuery);
            preparedStatement.setString(1, login); // get user by login only, no need for password
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String dbPasswordHash = rs.getString("password");
                String salt = rs.getString("salt");
                userType = rs.getString("usertype");
                fullName = rs.getString("fullname");

                user.setId(id);
                user.setLogin(login);
                user.setFullName(fullName);
                user.setUserType(userType);
                user.setPassword(dbPasswordHash);
                user.setSalt(salt);
            }
        } catch (SQLException ex) {
            user = null;
            throw new ServletException("Login failed", ex);
        }

        if (user != null) {

            String hash = DigestUtils.sha512Hex(password + user.getSalt());

            //validate hash
            if (hash.equals(user.getPassword())) {

                if ("admin".equals(user.getUserType())) {
                    session.setAttribute("adminloggedin", user);
                    response.sendRedirect("DisplayCourtsServlet");
                } else {
                    session.setAttribute("clientloggedin", user);
                    response.sendRedirect("DisplayCourtsServletClient");
                }

            } else {

                //login correct but password is incorrect
                out.println("<script>");
                out.println("    alert('Login/Password incorrect');");
                out.println("    window.location = '/index.jsp'");
                out.println("</script>");
            }

        } else {
            //user with that login not exist
                out.println("<script>");
                out.println("    alert('Login/Password incorrect');");
                out.println("    window.location = '/index.jsp'");
                out.println("</script>");       
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
