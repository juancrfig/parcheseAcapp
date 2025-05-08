import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// DAO class for managing customer data in the database
public class CustomerDAO {
    // Adds a new customer to the database
    public void addCustomer(String name) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "INSERT INTO customers (name) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.executeUpdate();
        }
    }

    // Retrieves a customer's name by their ID
    public String getCustomerById(int id) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "SELECT name FROM customers WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        }
        return null; // Return null if customer is not found
    }

    // Updates an existing customer's name by their ID
    public void updateCustomer(int id, String newName) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "UPDATE customers SET name = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newName);
            stmt.setInt(2, id);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Customer with ID " + id + " not found.");
            }
        }
    }

    // Deletes a customer from the database by their ID
    public void deleteCustomer(int id) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "DELETE FROM customers WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Customer with ID " + id + " not found.");
            }
        }
    }

    // Retrieves a list of all customer names
    public List<String> listAllCustomers() throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "SELECT name FROM customers";
        List<String> customers = new ArrayList<>();
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                customers.add(rs.getString("name"));
            }
        }
        return customers;
    }

    // Checks if a customer exists in the database by their ID
    public boolean customerExists(int id) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "SELECT 1 FROM customers WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }
}
