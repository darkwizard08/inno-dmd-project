package model;

/**
 * @author darkwizard
 */
public class Journal {
	public int journalID;
	public String title;
	public String volume;
	public String number;
	public String name;

	public Journal(int journalID, String title, String volume, String number, String name) {
		this.journalID = journalID;
		this.title = title;
		this.volume = volume;
		this.number = number;
		this.name = name;
	}

	public int getJournalID() {
		return journalID;
	}

	public void setJournalID(int journalID) {
		this.journalID = journalID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
