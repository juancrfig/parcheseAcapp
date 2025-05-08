public class SubMenuItem implements MenuItem {
    private String displayName;
    private Menu subMenu;

    public SubMenuItem(String displayName, Menu subMenu) {
        this.displayName = displayName;
        this.subMenu = subMenu;
    }

    @Override
    public String getDisplayName() {
        return displayName;
    }

    @Override
    public Menu execute(TerminalIO io) {
        return subMenu;
    }
}
