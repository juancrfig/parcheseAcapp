import java.util.Stack;

public class Application {
    private Stack<Menu> menuStack = new Stack<>();
    private MenuView view;
    private TerminalIO io;

    public Application(Menu initialMenu, TerminalIO io) {
        menuStack.push(initialMenu);
        this.io = io;
        this.view = new MenuView(io);
    }

    public void run() {
        while (!menuStack.isEmpty()) {
            Menu currentMenu = menuStack.peek();
            view.displayMenu(currentMenu);
            io.print("Select an option: ");
            String input = io.readLine();
            try {
                int choice = Integer.parseInt(input);
                if (choice == 0) {
                    menuStack.pop();
                } else if (choice > 0 && choice <= currentMenu.getItems().size()) {
                    MenuItem selectedItem = currentMenu.getItems().get(choice - 1);
                    Menu nextMenu = selectedItem.execute(io);
                    if (nextMenu != null) {
                        menuStack.push(nextMenu);
                    }
                } else {
                    io.println("Invalid option. Please try again.");
                }
            } catch (NumberFormatException e) {
                io.println("Please enter a valid number.");
            }
        }
    }
}
