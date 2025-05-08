import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// This class manages the MySQL database connection using the Singleton pattern to ensure only one connection is used.
public class DatabaseConnection {
    private static Connection connection;

    // Private constructor to prevent instantiation
    private DatabaseConnection() {}

    // Method to get the database connection. It creates a new connection if one doesn't exist.
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            // Update these with your MySQL database details
            String url = "jdbc:mysql://localhost:3306/your_database";  // Replace with your database name
            String user = "your_username";  // Replace with your MySQL username
            String password = "your_password";  // Replace with your MySQL password
            connection = DriverManager.getConnection(url, user, password);
        }
        return connection;
    }

    // Method to close the database connection
    public static void closeConnection() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}
