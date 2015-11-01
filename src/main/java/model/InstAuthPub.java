package model;

/**
 * @author darkwizard
 */
public class InstAuthPub {
	public int pubID;
	public int instID;
	public String author;

	public InstAuthPub(int pubID, int instID, String author) {
		this.pubID = pubID;
		this.instID = instID;
		this.author = author;
	}

	public int getPubID() {
		return pubID;
	}

	public void setPubID(int pubID) {
		this.pubID = pubID;
	}

	public int getInstID() {
		return instID;
	}

	public void setInstID(int instID) {
		this.instID = instID;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
}
