package model;

/**
 * Created by lebdron on 01.11.2015.
 */
public class Conference {
    public int conferenceID;
    public String title;
    public String volume;

    public Conference(int conferenceID, String title, String volume) {
        this.conferenceID = conferenceID;
        this.title = title;
        this.volume = volume;
    }

    public int getConferenceID() {
        return conferenceID;
    }

    public void setConferenceID(int conferenceID) {
        this.conferenceID = conferenceID;
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
}
