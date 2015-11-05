package model;

public class Author {
    public int ID;
    public String name;
    public Institution institution;

    public Author(int ID, String name, int instID, String instTitle) {
        this.ID = ID;
        this.name = name;
        institution = new Institution(instID, instTitle);
    }

    public Author(int ID, String name) {
        this.ID = ID;
        this.name = name;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Institution getInstitution() {
        return institution;
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }
}
