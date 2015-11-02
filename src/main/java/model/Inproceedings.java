package model;

/**
 * Created by lebdron on 01.11.2015.
 */
public class Inproceedings extends Publication {
    private int crossref = 0;
    private String pages = "";

    public Inproceedings(int ID, String title, int year, int crossref, String pages) {
        super(ID, title, year, "inproceedings");
        this.crossref = crossref;
        this.pages = pages;
    }

    public Inproceedings(Publication pub, int crossref, String pages) {
        super(pub.getID(), pub.getTitle(), pub.getYear(), pub.getType());
        this.crossref = crossref;
        this.pages = pages;
    }

    public int getCrossref() {
        return crossref;
    }

    public void setCrossref(int crossref) {
        this.crossref = crossref;
    }

    public String getPages() {
        return pages;
    }

    public void setPages(String pages) {
        this.pages = pages;
    }

    @Override
    public String toString() {
        return "Inproceedings{" +
                "pubID=" + ID +
                ", crossref=" + crossref +
                ", pages='" + pages + '\'' +
                '}';
    }
}
