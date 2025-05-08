import java.util.ArrayList;
import java.util.List;

public class Menu {
    private String title;
    private List<MenuItem> items = new ArrayList<>();

    public Menu(String title) {
        this.title = title;
    }

    public void addItem(MenuItem item) {
        items.add(item);
    }

    public String getTitle() {
        return title;
    }

    public List<MenuItem> getItems() {
        return items;
    }
}
