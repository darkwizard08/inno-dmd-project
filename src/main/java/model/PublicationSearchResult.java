package model;

public class PublicationSearchResult extends Publication {
    int count;

    public PublicationSearchResult(int ID, String title, int year, String type, int count) {
        super(ID, title, year, type);
        this.count = count;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
