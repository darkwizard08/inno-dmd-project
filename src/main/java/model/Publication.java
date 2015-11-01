package model;

/**
 * @author darkwizard
 */
public class Publication {
	public int ID;
	public String title;
	public int year;
	public String type;

	public Publication(int ID, String title, int year, String type) {
		this.ID = ID;
		this.title = title;
		this.year = year;
		this.type = type;
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

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
