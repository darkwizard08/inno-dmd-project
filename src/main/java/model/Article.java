package model;

/**
 * @author darkwizard
 */
public class Article extends Publication {
	private int journalID = 0;
	private String pages = "";

	public Article(int ID, String title, int year, int journalID, String pages) {
		super(ID, title, year, "article");
		this.journalID = journalID;
		this.pages = pages;
	}

	public Article(Publication pub, int journalID, String pages) {
		super(pub.getID(), pub.getTitle(), pub.getYear(), pub.getType());
		this.journalID = journalID;
		this.pages = pages;
	}

	public int getJournalID() {
		return journalID;
	}

	public void setJournalID(int journalID) {
		this.journalID = journalID;
	}

	public String getPages() {
		return pages;
	}

	public void setPages(String pages) {
		this.pages = pages;
	}

	@Override
	public String toString() {
		return "[" + ID + "; " + "JID: " + journalID + "; pg: " + pages + "]";
	}
}
