package model;

/**
 * @author darkwizard
 */
public class Publisher {
	public int ID;
	public String Name;

	public Publisher(int ID, String name) {
		this.ID = ID;
		Name = name;
	}

	public int getID() {
		return ID;
	}

	public void setID(int ID) {
		this.ID = ID;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}
}
