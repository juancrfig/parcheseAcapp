public class MenuView {
    private TerminalIO io;

    public MenuView(TerminalIO io) {
        this.io = io;
    }

    public void displayMenu(Menu menu) {
        io.println("\n" + menu.getTitle());
        io.println("--------------------");
        List<MenuItem> items = menu.getItems();
        for (int i = 0; i < items.size(); i++) {
            io.println((i + 1) + ". " + items.get(i).getDisplayName());
        }
        io.println("0. Exit");
        io.println("--------------------");
    }
}
