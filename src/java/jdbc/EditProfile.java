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
import org.apache.commons.lang3.RandomStringUtils;

/**
 *
 * @author MSI
 */
@WebServlet(name = "EditProfileServlet", urlPatterns = {"/EditProfileServlet"})
public class EditProfile extends HttpServlet {

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

        User user = new User();

        String login = request.getParameter("oldlogin");
        String newlogin = request.getParameter("login");
        String oldPassword = request.getParameter("oldPassword");
        String newpassword = request.getParameter("password");
        String oldSalt = request.getParameter("salt");
        String confirmPassword = request.getParameter("confpassword");
        String fullName = request.getParameter("fullName");
        String userType = request.getParameter("userType");

        //generate salt
        int length = 30;
        boolean useLetters = true;
        boolean useNumbers = true;
        String salt;
        String passwordHash;
        
        
        if("".equals(newpassword)){
            
            salt = oldSalt;
            passwordHash = oldPassword;
        }
        else{
            salt = RandomStringUtils.random(length, useLetters, useNumbers);
            passwordHash = DigestUtils.sha512Hex(newpassword + salt);
        }
        

        String sqlQuery = "UPDATE user SET login = ?, password = ?, fullName = ?, salt = ? WHERE login = ?";

        try {

            if (newpassword.equals(confirmPassword)) {

                PreparedStatement preparedStatement = con.prepareStatement(sqlQuery);
                preparedStatement.setString(1, newlogin);
                preparedStatement.setString(2, passwordHash);
                preparedStatement.setString(3, fullName);
                preparedStatement.setString(4, salt);
                preparedStatement.setString(5, login);// get user by login only, no need for password

                int insertStatus = 0;
                insertStatus = preparedStatement.executeUpdate();
                if (insertStatus == 1) {
                    user.setLogin(newlogin);
                    user.setFullName(fullName);
                    user.setPassword(passwordHash);
                    user.setSalt(salt);
                    user.setUserType(userType);

                    if ("admin".equals(user.getUserType())) {
                        session.setAttribute("adminloggedin", user);

                    } else {
                        session.setAttribute("clientloggedin", user);

                    }

                    out.println("<script>");
                    out.println("    alert('Update successful');");
                    out.println("    window.location = '/Sport-Venue-Booking/index.jsp'");
                    out.println("</script>");

                } else {
                    //if password and confirm password not the same

                    out.println("<script>");
                    out.println("    alert('Error updating data');");
                    out.println("</script>");

                }
            } else {
                //if password and confirm password not the same

                out.println("<script>");
                out.println("    alert('Password and confirm password not similar, try again');");

                if ("admin".equals(userType)) {
                    out.println("    window.location = '/editProfileAdmin.jsp'");
                } else {
                    out.println("    window.location = '/editProfile.jsp'");
                }

                out.println("</script>");
            }

        } catch (SQLException ex) {
            user = null;
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
