import java.util.Scanner;

public class TerminalIO {
    private Scanner scanner = new Scanner(System.in);

    public void print(String message) {
        System.out.print(message);
    }

    public void println(String message) {
        System.out.println(message);
    }

    public String readLine() {
        return scanner.nextLine();
    }
}
