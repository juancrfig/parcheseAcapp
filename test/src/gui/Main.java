public class Main {
    public static void main(String[] args) {
        TerminalIO io = new TerminalIO();

        // Create menus
        Menu mainMenu = new Menu("Workshop Management System");
        Menu customerMenu = new Menu("Customer Management");

        // Define actions
        Action addCustomer = io -> {
            io.println("Enter customer name:");
            String name = io.readLine();
            io.println("Customer '" + name + "' added successfully!");
        };

        // Populate menus
        mainMenu.addItem(new SubMenuItem("Manage Customers", customerMenu));
        mainMenu.addItem(new ActionItem("Exit System", io -> System.exit(0)));
        customerMenu.addItem(new ActionItem("Add Customer", addCustomer));

        // Run application
        Application app = new Application(mainMenu, io);
        app.run();
    }
}
