public class ActionItem implements MenuItem {
    private String displayName;
    private Action action;

    public ActionItem(String displayName, Action action) {
        this.displayName = displayName;
        this.action = action;
    }

    @Override
    public String getDisplayName() {
        return displayName;
    }

    @Override
    public Menu execute(TerminalIO io) {
        action.execute(io);
        return null;
    }
}
