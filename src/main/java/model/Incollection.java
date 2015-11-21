package model;

public class Incollection extends Publication {
    private int crossref = 0;
    private String pages = "";

    public Incollection(int ID, String title, int year, int crossref, String pages) {
        super(ID, title, year, "incollection");
        this.crossref = crossref;
        this.pages = pages;
    }

    public Incollection(Publication pub, int crossref, String pages) {
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
        return "Incollection{" +
                "pubID=" + ID +
                ", crossref=" + crossref +
                ", pages='" + pages + '\'' +
                '}';
    }
}
