public interface MenuItem {
    String getDisplayName();
    Menu execute(TerminalIO io);
}
