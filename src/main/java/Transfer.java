import db.DBConnector;
import phase3.CommandProcessor;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Transfer {
	public static void main(String[] args) {
		DBConnector conn = DBConnector.getInstance();
		conn.connect();
		CommandProcessor cp = new CommandProcessor();

		cp.create("Area", "id", "ID", "Name");
		cp.create("Incollection", "id", "PubID", "Crossref", "Pages");
		cp.create("Inproceedings", "id", "PubID", "Crossref", "Pages");
		cp.create("Keyword", "id", "ID", "Word");
		cp.create("PubArea", "id", "PubID", "AreaID");
		cp.create("PubKeyword", "id", "PubID", "KeywordID");
		cp.create("Published", "id", "PublicationID", "PublisherID");
		cp.create("Publisher", "id", "ID", "Name");
		cp.create("User", "id", "ID", "Username", "Password");

		ResultSet rs;
		int id;

		// Article
		cp.create("Article", "id", "PubID", "JournalID", "Pages");

		rs = conn.getRawQueryResult("SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Article\"\n" +
				"WHERE\n" +
				"  \"PubID\" between 1 and 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("Article", String.valueOf(id++), rs.getString(1), rs.getString(2), rs.getString(3) != null ? rs.getString(3) : "");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Author
		cp.create("Author", "id", "ID", "Name");

		rs = conn.getRawQueryResult("SELECT DISTINCT\n" +
				"  \"Author\".* \n" +
				"FROM \n" +
				"  public.\"Author\", \n" +
				"  public.\"InstAuthPub\"\n" +
				"WHERE \n" +
				"  \"InstAuthPub\".\"Author\" = \"Author\".\"Name\" AND\n" +
				"  \"PubID\" between 1 and 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("Author", String.valueOf(id++), rs.getString(1), rs.getString(2));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Book
		cp.create("Book", "id", "PubID", "Volume");

		rs = conn.getRawQueryResult("SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Book\"\n" +
				"WHERE\n" +
				"  \"PubID\" between 1 and 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("Book", String.valueOf(id++), rs.getString(1), rs.getString(2) != null ? rs.getString(2) : "");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Conference
		cp.create("Conference", "id", "ID", "Title", "Volume");

		rs = conn.getRawQueryResult("SELECT DISTINCT\n" +
				"  \"Conference\".* \n" +
				"FROM \n" +
				"  public.\"Conference\", \n" +
				"  public.\"Proceedings\"\n" +
				"WHERE \n" +
				"  \"Proceedings\".\"ConferenceID\" = \"Conference\".\"ID\" AND\n" +
				"  \"Proceedings\".\"PubID\" BETWEEN 1 AND 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("Conference", String.valueOf(id++), rs.getString(1), rs.getString(2), rs.getString(3) != null ? rs.getString(3) : "");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// InstAuthPub
		cp.create("InstAuthPub", "id", "PubID", "InstID", "Author");

		rs = conn.getRawQueryResult("SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"InstAuthPub\"\n" +
				"WHERE \n" +
				"  \"PubID\" BETWEEN 1 AND 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("InstAuthPub", String.valueOf(id++), rs.getString(1), rs.getString(2) != null ? rs.getString(2) : "", rs.getString(3));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Institution
		cp.create("Institution", "id", "ID", "Title");

		rs = conn.getRawQueryResult("SELECT DISTINCT\n" +
				"  \"Institution\".* \n" +
				"FROM \n" +
				"  public.\"InstAuthPub\", \n" +
				"  public.\"Institution\"\n" +
				"WHERE \n" +
				"  \"Institution\".\"ID\" = \"InstAuthPub\".\"InstID\" AND\n" +
				"  \"PubID\" BETWEEN 1 AND 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("Institution", String.valueOf(id++), rs.getString(1), rs.getString(2));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Journal
		cp.create("Journal", "id", "ID", "Title", "Volume", "Number", "Name");

		rs = conn.getRawQueryResult("SELECT DISTINCT\n" +
				"  \"Journal\".* \n" +
				"FROM \n" +
				"  public.\"Journal\", \n" +
				"  public.\"Article\"\n" +
				"WHERE \n" +
				"  \"Article\".\"JournalID\" = \"Journal\".\"ID\" AND\n" +
				"  \"PubID\" BETWEEN 1 AND 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("Journal", String.valueOf(id++), rs.getString(1), rs.getString(2), rs.getString(3) != null ? rs.getString(3) : "", rs.getString(4) != null ? rs.getString(4) : "", rs.getString(5) != null ? rs.getString(5) : "");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Proceedings
		cp.create("Proceedings", "id", "PubID", "ConferenceID");

		rs = conn.getRawQueryResult("SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Proceedings\"\n" +
				"WHERE \n" +
				"  \"PubID\" BETWEEN 1 AND 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("Proceedings", String.valueOf(id++), rs.getString(1), rs.getString(2));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Publication
		cp.create("Publication", "id", "ID", "Title", "Year", "Type");

		rs = conn.getRawQueryResult("SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"ID\" BETWEEN 1 AND 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("Publication", String.valueOf(id++), rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Referenced
		cp.create("Referenced", "id", "PubID", "RefPub");

		rs = conn.getRawQueryResult("SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Referenced\"\n" +
				"WHERE \n" +
				"  \"PubID\" BETWEEN 1 AND 10000\n" +
				"  AND \"RefPubID\" BETWEEN 1 AND 10000");

		id = 1;
		try {
			while (rs.next()) {
				cp.insert("Referenced", String.valueOf(id++), rs.getString(1), rs.getString(2));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}


		cp.close();
	}
}
