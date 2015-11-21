package model;

public class Book extends Publication {
    public String volume;


    public Book(int ID, String title, int year, String volume) {
        super(ID, title, year, "book");
        this.volume = volume;
    }

    public Book(Publication pub, String volume) {
        super(pub.getID(), pub.getTitle(), pub.getYear(), pub.getType());
        this.volume = volume;
    }

    public String getVolume() {
        return volume;
    }

    public void setVolume(String volume) {
        this.volume = volume;
    }

    @Override
    public String toString() {
        return "Book{" +
                "pubID=" + ID +
                ", volume='" + volume + '\'' +
                '}';
    }
}
