package com.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Ejemplo seguro equivalente que usa parámetros preparados.
 */
public class SafeExample {

    public ResultSet findUserByEmail(Connection connection, String email) throws Exception {
        String query = "SELECT * FROM users WHERE email = ?";

        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setString(1, email);
        return stmt.executeQuery();
    }
}

