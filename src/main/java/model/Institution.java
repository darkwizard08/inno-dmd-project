package model;

/**
 * Created by lebdron on 02.11.2015.
 */
public class Institution {
    public int ID;
    public String title;

    public Institution(int ID, String title) {
        this.ID = ID;
        this.title = title;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
