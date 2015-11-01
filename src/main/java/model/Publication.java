package model;

/**
 * @author darkwizard
 */
public class Publication {
	public String ID;
	public String title;
	public String year;
	public String type;

	public Publication(String ID, String title, String year, String type) {
		this.ID = ID;
		this.title = title;
		this.year = year;
		this.type = type;
	}

	public String getID() {
		return ID;
	}

	public void setID(String ID) {
		this.ID = ID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
