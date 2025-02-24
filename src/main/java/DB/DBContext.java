/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Dong Minh Quang - CE182250
 */
public class DBContext {

    private Connection conn;

    public DBContext() {
        try {
            String user = "sa";

            String url = "jdbc:sqlserver://localhost:1433;databaseName=Laptop2;encrypt=false";
            String pass = "11111"; // Đổi lại theo pass sa

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url, user, pass);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //Lay connection 
    public Connection getConnection() {
        return conn;
    }

    //Phuong thuc cho cac lenh SELECT(co params)
    public ResultSet execSelectQuery(String query, Object[] params) throws SQLException {
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                preparedStatement.setObject(i + 1, params[i]);
            }
        }
        return preparedStatement.executeQuery();
    }

    //Phuong thuc cho cac lenh select khong co params
    public ResultSet execSelectQuery(String query) throws SQLException {
        return this.execSelectQuery(query, null);
    }

    //Phuong thuc cho cac lenh INSERT UPDATE DELETE 
    public int execQuery(String query, Object[] params) throws SQLException {
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                preparedStatement.setObject(i + 1, params[i]);
            }
        }
        return preparedStatement.executeUpdate();
    }
    
    public int excecCountQuery(String query) throws SQLException {
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
    } else {
        return 0;
        }

    }
    
}
