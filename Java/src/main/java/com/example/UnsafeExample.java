package com.example;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Ejemplo inseguro a propósito para CodeQL.
 */
public class UnsafeExample {

    public ResultSet findUserByEmail(Connection connection, String email) throws Exception {
        // Lógica vulnerable: se concatena el parámetro directamente.
        String query = "SELECT * FROM users WHERE email = '" + email + "'";

        Statement stmt = connection.createStatement();
        return stmt.executeQuery(query);
    }
}

