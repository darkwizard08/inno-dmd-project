package model;

/**
 * @author darkwizard
 */
public class Article {
	private int pubID = 0;
	private int journalID = 0;
	private String pages = "";

	public Article(int pubID, int journalID, String pages) {
		this.pubID = pubID;
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
}
