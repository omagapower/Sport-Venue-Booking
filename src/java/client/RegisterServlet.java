/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package client;

import bean.User;
import java.io.*;
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
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author MSI
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

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

        //get form data from VIEW > V-I
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confpassword");
        String fullName = request.getParameter("fullname");
        String userType = "client"; //change this to 'admin' to create an admin
        PrintWriter out = response.getWriter();

        //generate salt
        int length = 30;
        boolean useLetters = true;
        boolean useNumbers = true;
        String salt = RandomStringUtils.random(length, useLetters, useNumbers);

        //generate password hash
        String passwordHash = DigestUtils.sha512Hex(password + salt);

        String sqlInsert = "INSERT INTO user(login, password, salt, userType, fullName) VALUES(?, ?, ?, ?, ?);";

        try {

            if (password.equals(confirmPassword)) {
                PreparedStatement preparedStatement = con.prepareStatement(sqlInsert);
                preparedStatement.setString(1, login);
                preparedStatement.setString(2, passwordHash);
                preparedStatement.setString(3, salt);
                preparedStatement.setString(4, userType);
                preparedStatement.setString(5, fullName);

                int insertStatus = 0;
                insertStatus = preparedStatement.executeUpdate();

                User user = new User();

                user.setLogin(login);
                user.setFullName(fullName);
                user.setPassword(passwordHash);
                user.setSalt(salt);
                user.setUserType(userType);

                if (insertStatus == 1) {
                    out.println("<script>");
                    out.println("    alert('Account created successfully');");
                    out.println("    window.location = '/index.jsp'");
                    out.println("</script>");
                }
            } else {
                //if password and confirm password not the same

                out.println("<script>");
                out.println("    alert('Password and confirm password not similar, try again');");
                out.println("    window.location = '/register.jsp'");
                out.println("</script>");

            }

        } catch (SQLException ex) {
            
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
