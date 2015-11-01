package model;

/**
 * @author darkwizard
 */
public class Article extends Publication {
	private int pubID = 0;
	private int journalID = 0;
	private String pages = "";

	public Article(int ID, String title, int year, int journalID, String pages) {
		super(ID, title, year, "article");
		this.pubID = ID;
		this.journalID = journalID;
		this.pages = pages;
	}

	public Article(Publication pub, int journalID, String pages) {
		super(pub.getID(), pub.getTitle(), pub.getYear(), pub.getType());
		this.journalID = journalID;
		this.pages = pages;
	}

	public int getPubID() {
		return pubID;
	}

	public void setPubID(int pubID) {
		this.pubID = pubID;
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
		return "[" + pubID + "; " + "JID: " + journalID + "; pg: " + pages + "]";
	}
}
