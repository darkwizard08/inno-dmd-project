package model;

public class Proceedings extends Publication {
    private int conferenceID = 0;


    public Proceedings(int ID, String title, int year, int conferenceID) {
        super(ID, title, year, "proceedings");
        this.conferenceID = conferenceID;
    }

    public Proceedings(Publication pub, int conferenceID) {
        super(pub.getID(), pub.getTitle(), pub.getYear(), pub.getType());
        this.conferenceID = conferenceID;
    }

    public int getConferenceID() {
        return conferenceID;
    }

    public void setConferenceID(int conferenceID) {
        this.conferenceID = conferenceID;
    }

    @Override
    public String toString() {
        return "Proceedings{" +
                "pubID=" + ID +
                ", conferenceID=" + conferenceID +
                '}';
    }
}
