package db;

import model.*;
import phase3.CommandProcessor;
import phase3.model.tuple.Tuple;

import java.lang.reflect.Constructor;
import java.util.*;
import java.util.stream.Collectors;

public class CollectionRetriever {
	private static CollectionRetriever retr = null;
	private final HashMap<String, String> queries, orderings, sortings, sortAttributes;
	private final String limitOffset = "\nLIMIT %s\n" +
			"OFFSET %s", orderBy = "\nORDER BY %s %s";
	private final HashSet<String> types;

	private final CommandProcessor cp;
	private DBConnector conn = null;

	private CollectionRetriever() {
		this.cp = new CommandProcessor();
		this.queries = new HashMap<>();
		this.orderings = new HashMap<>();
		this.sortings = new HashMap<>();
		this.sortAttributes = new HashMap<>();
		types = new HashSet<>(Arrays.asList("article", "proceedings", "inproceedings", "incollection", "book"));

		orderings.put("year", "\"Publication\".\"Year\"");
		orderings.put("cite", "rank_cnt");
		orderings.put(null, "");

		sortings.put("cite", "LEFT OUTER JOIN (SELECT \n" +
				"  \"Referenced\".\"RefPubID\", COUNT(\"Referenced\".\"PubID\") as count\n" +
				"FROM\n" +
				"  public.\"Referenced\"\n" +
				"GROUP BY\n" +
				"  \"Referenced\".\"RefPubID\") AS rank ON (rank.\"RefPubID\" = \"Publication\".\"ID\")\n");
		sortings.put("year", "");
		sortings.put(null, "");

		sortAttributes.put("cite", ",\n" +
				" coalesce(rank.count, 0) as rank_cnt");
		sortAttributes.put("year", "");
		sortAttributes.put(null, "");

		queries.put("researchArea", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Area\", \n" +
				"  public.\"PubArea\", \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Area\".\"ID\" = \"PubArea\".\"AreaID\" AND\n" +
				"  \"PubArea\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Area\".\"Name\" like '%%%s%%'");

		queries.put("authorName", "SELECT DISTINCT \n" +
				" \"Publication\".*\n" +
				"FROM \n" +
				" public.\"InstAuthPub\", \n" +
				" public.\"Publication\"\n" +
				"WHERE \n" +
				" \"Publication\".\"ID\" = \"InstAuthPub\".\"PubID\" AND\n" +
				" \"InstAuthPub\".\"Author\" IN (\n" +
				"   select \"Author\".\"Name\" \n" +
				"   from public.\"Author\" \n" +
				"   where \"Author\".\"ID\" in (\n" +
				"     select \"Author\".\"ID\"\n" +
				"     from public.\"Author\"\n" +
				"     where \"Author\".\"Name\" like '%%%s%%'))");

		queries.put("pubYear", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Publication\".\"Year\" = %s");

		queries.put("pubTitle", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Publication\".\"Title\" like '%%%s%%'");

		queries.put("keyword", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Keyword\", \n" +
				"  public.\"PubKeyword\", \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Keyword\".\"ID\" = \"PubKeyword\".\"KeywordID\" AND\n" +
				"  \"PubKeyword\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Keyword\".\"Word\" like '%%%s%%'");

		queries.put("pubType", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"%1$s\"\n" +
				"WHERE \n" +
				"  \"%1$s\".\"PubID\" = \"Publication\".\"ID\"");

		queries.put("references", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"Referenced\"\n" +
				"WHERE \n" +
				"  \"Referenced\".\"RefPubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Referenced\".\"PubID\" = %s");

		queries.put("citedBy", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"Referenced\"\n" +
				"WHERE \n" +
				"  \"Referenced\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Referenced\".\"RefPubID\" = %s");

		queries.put("institution", "SELECT DISTINCT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"InstAuthPub\", \n" +
				"  public.\"Institution\"\n" +
				"WHERE \n" +
				"  \"InstAuthPub\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"InstAuthPub\".\"InstID\" = \"Institution\".\"ID\" AND\n" +
				"  \"Institution\".\"Title\" like '%%%s%%'");

		queries.put("venue", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE\n" +
				"  \"Publication\".\"ID\" IN (\n" +
				"  SELECT \n" +
				"    \"Article\".\"PubID\"\n" +
				"  FROM  \n" +
				"    public.\"Article\"\n" +
				"  WHERE \n" +
				"    \"Article\".\"JournalID\" IN " +
				"(SELECT \"Journal\".\"ID\" " +
				"from public.\"Journal\" " +
				"where \"Journal\".\"Title\" like '%%%1$s%%')\n" +
				"\n" +
				"  UNION\n" +
				"\n" +
				"  SELECT \n" +
				"    \"Proceedings\".\"PubID\"\n" +
				"  FROM  \n" +
				"    public.\"Proceedings\"\n" +
				"  WHERE \n" +
				"    \"Proceedings\".\"ConferenceID\" IN " +
				"(SELECT \"Conference\".\"ID\" " +
				"from public.\"Conference\" " +
				"where \"Conference\".\"Title\" like '%%%1$s%%')\n" +
				"\n" +
				"  UNION\n" +
				"\n" +
				"  SELECT \n" +
				"    \"Inproceedings\".\"PubID\"\n" +
				"  FROM  \n" +
				"    public.\"Inproceedings\"\n" +
				"  WHERE \n" +
				"    \"Inproceedings\".\"Crossref\" IN (\n" +
				"    SELECT \n" +
				"      \"Proceedings\".\"PubID\"\n" +
				"    FROM  \n" +
				"      public.\"Proceedings\"\n" +
				"    WHERE \n" +
				"      \"Proceedings\".\"ConferenceID\" IN " +
				"(SELECT \"Conference\".\"ID\" " +
				"from public.\"Conference\"" +
				" where \"Conference\".\"Title\" like '%%%1$s%%')))");
	}

	public static CollectionRetriever getInstance() {
		if (retr == null)
			retr = new CollectionRetriever();
		return retr;
	}

	/* template
	public List<Object> getPublicationsOn...(String searchFor) {
		String query = ...;
		return this.processResult(conn.getRawQueryResult(query), Publication.class);
	}
	 */

	public static String convertListOfTuplesToString(List<Tuple> list) {
		List<String> res = list.stream()
				.map(tuple -> tuple.get(0))
				.collect(Collectors.toList());

		return String.join(", ", res);
	}

	public List<Object> getPublications(String searchType, String searchFor, String offset, String sortType, String orderType) {
		if (searchType.equals("pubType")) {
			searchFor = searchFor.toLowerCase();
			if (!types.contains(searchFor.toLowerCase())) {
				return null;
			}
			searchFor = Character.toUpperCase(searchFor.charAt(0)) + searchFor.substring(1);
		}

		switch (searchType) {
			case "institution":
				List<Tuple> institution = cp.scan("Institution")
						.filter("Institution.Title LIKE " + searchFor).list(),
						instauthpub = cp.scan("InstAuthPub")
								.join(institution, "InstAuthPub.InstID", "Institution.ID", "INNER").list();
				cp.scan("Publication")
						.join(instauthpub, "Publication.ID", "InstAuthPub.PubID", "INNER")
						.groupBy("Publication.ID")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "venue":
				List<Tuple> journal = cp.scan("Journal")
						.filter("Journal.Title LIKE " + searchFor)
						.project("Journal.ID").list(),
						conference = cp.scan("Conference")
								.filter("Conference.Title LIKE " + searchFor)
								.project("Conference.ID").list();
				List<Tuple> proceedings = cp.scan("Proceedings")
						.filter("Proceedings.ConferenceID IN " + convertListOfTuplesToString(conference))
						.project("Proceedings.PubID")
						.rename("Proceedings.PubID", "Publication.ID").list();
				List<Tuple> inproceedings = cp.scan("Inproceedings")
						.filter("Inproceedings.Crossref IN " + convertListOfTuplesToString(proceedings))
						.project("Inproceedings.PubID")
						.rename("Inproceedings.PubID", "Publication.ID").list(),
						article = cp.scan("Article").filter("Article.JournalID IN " + convertListOfTuplesToString(journal))
								.project("Article.PubID")
								.rename("Article.PubID", "Publication.ID").list();
				cp.scan("Publication").filter("Publication.ID IN " + convertListOfTuplesToString(new CommandProcessor().init()
						.union(article)
						.union(proceedings)
						.union(inproceedings).list())).project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");

				break;
			case "authorName":
				List<Tuple> authid = cp.scan("Author").filter("Author.Name LIKE " + searchFor)
						.project("Author.ID").list();
				List<Tuple> authname = cp.scan("Author").filter("Author.ID IN " + convertListOfTuplesToString(authid))
						.project("Author.Name").list();
				instauthpub = cp.scan("InstAuthPub")
						.filter("InstAuthPub.Author IN " + convertListOfTuplesToString(authname)).list();
				cp.scan("Publication").join(instauthpub, "Publication.ID", "InstAuthPub.PubID", "INNER")
						.groupBy("Publication.ID")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "researchArea":
				List<Tuple> area = cp.scan("Area")
						.filter("Area.Name LIKE " + searchFor)
						.list(),
						pubArea = cp.scan("PubArea")
								.list();
				cp.scan("Publication")
						.join(pubArea, "Publication.ID", "PubArea.PubID", "INNER")
						.join(area, "PubArea.AreaID", "Area.ID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "pubYear":
				cp.scan("Publication")
						.filter("Publication.Year = " + searchFor)
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "pubTitle":
				cp.scan("Publication")
						.filter("Publication.Title LIKE " + searchFor)
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "keyword":
				List<Tuple> keyword = cp.scan("Keyword")
						.filter("Keyword.Word LIKE " + searchFor)
						.list(),
						pubKeyword = cp.scan("PubKeyword")
								.list();
				cp.scan("Publication")
						.join(pubKeyword, "Publication.ID", "PubKeyword.PubID", "INNER")
						.join(keyword, "PubKeyword.KeywordID", "Keyword.ID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "pubType":
				List<Tuple> type = cp.scan(searchFor).project(searchFor + ".PubID").list();
				cp.scan("Publication")
						.join(type, "Publication.ID", searchFor + ".PubID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "references":
				List<Tuple> referenced = cp.scan("Referenced")
						.filter("Referenced.PubID = " + searchFor)
						.list();
				cp.scan("Publication")
						.join(referenced, "Publication.ID", "Referenced.RefPubID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "citedBy":
				referenced = cp.scan("Referenced")
						.filter("Referenced.RefPubID = " + searchFor)
						.list();
				cp.scan("Publication")
						.join(referenced, "Publication.ID", "Referenced.PubID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
		}

		cp.count("*");

		if (sortType != null) {
			orderType = orderType.toUpperCase();
			switch (sortType) {
				case "cite":
					CommandProcessor rank = new CommandProcessor();
					rank.scan("Referenced")
							.count("Referenced.PubID")
							.groupBy("Referenced.RefPubID")
							.project("Referenced.RefPubID", "count(Referenced.PubID)")
							.rename("Referenced.RefPubID", "rank.RefPubID")
							.rename("count(Referenced.PubID)", "rank.count");
					cp.join(rank.list(), "Publication.ID", "rank.RefPubID", "LEFT OUTER")
							.coalesce("rank.count", "0").sort("rank.count", orderType);
				case "year":
					cp.sort("Publication.Year", orderType);
			}
		} else {
			cp.sort("Publication.ID", "ASC");
		}

		cp.offset(Integer.parseInt(offset))
				.limit(50);

		List<Object> result = this.processResult(cp.list(), PublicationSearchResult.class);
		return result.size() == 0 ? null : result;
	}

	public int i(String conv) {
		return conv.length() > 0 ? Integer.parseInt(conv) : 0;
	}

	public FullInfo getFullPublicationInfo(int pubId) {
		List<Tuple> area = this.cp.init().scan("Area").list();
		List<Tuple> keyw = this.cp.init().scan("Keyword").list();
		List<Tuple> publ = this.cp.init().scan("Publisher").list();
		List<Tuple> published = this.cp.init().scan("Published").list();
		List<Tuple> pubarea = this.cp.init().scan("PubArea").list();
		List<Tuple> pubkeyw = this.cp.init().scan("PubKeyword").list();

		List<Tuple> res = cp.init().scan("Publication")
				.filter("Publication.ID = " + pubId)
				.join("PubArea", pubarea, "Publication.ID", "PubArea.PubID", "LEFT OUTER")
				.join("PubKeyword", pubkeyw, "Publication.ID", "PubKeyword.PubID", "LEFT OUTER")
				.join("Area", area, "PubArea.AreaID", "Area.ID", "LEFT OUTER")
				.join("Keyword", keyw, "PubKeyword.KeywordID", "Keyword.ID", "LEFT OUTER")
				.join("Published", published, "Publication.ID", "Published.PublicationID", "LEFT OUTER")
				.join("Publisher", publ, "Published.PublisherID", "Publisher.ID", "LEFT OUTER")
				.project("Publication.Title", "Publication.Year", "Publication.Type",
						"Area.ID", "Area.Name", "Keyword.ID", "Keyword.Word", "Publisher.ID", "Publisher.Name")
				.list();

			for (Tuple tp : res) {
				Publication publication = new Publication(
						pubId,
						tp.get("Publication.Title"),
						Integer.parseInt(tp.get("Publication.Year")),
						tp.get("Publication.Type")
				);
				Area a = new Area(i(tp.get("Area.ID")), tp.get("Area.Name"));
				Keyword keyword = new Keyword(i(tp.get("Keyword.ID")), tp.get("Keyword.Word"));
				Publisher publisher = new Publisher(i(tp.get("Publisher.ID")), tp.get("Publisher.Name"));

				FullInfo result = null;
				switch (publication.getType()) {
					case "article":

						List<Tuple> articles = cp.init()
								.scan("Article")
								.filter("Article.PubID = " + pubId)
								.list();

						List<Tuple> journal = cp.init()
								.scan("Journal")
								.join(articles, "Journal.ID", "Article.JournalID", "INNER")
								.project("Journal.ID","Journal.Title","Journal.Volume","Journal.Number", "Journal.Name", "Article.Pages")
								.list();

						for (Tuple jour : journal) {
							Journal j = new Journal(
									i(jour.get("Journal.ID")),
									jour.get("Journal.Title"),
									jour.get("Journal.Volume"),
									jour.get("Journal.Number"),
									jour.get("Journal.Name")
							);
							Article art = new Article(publication, j.getJournalID(), jour.get("Article.Pages"));
							result = new FullInfo(art, a, keyword, publisher);
							result.setAddition(j);
						}
						break;
					case "proceedings":

						List<Tuple> proc = cp.init()
								.scan("Proceedings")
								.filter("Proceedings.PubID = " + pubId)
								.list();

						List<Tuple> conf = cp.init()
								.scan("Conference")
								.join(proc, "Conference.ID", "Proceedings.ConferenceID", "INNER")
								.project("Conference.ID", "Conference.Title", "Conference.Volume")
								.list();

						for (Tuple c : conf) {
							Conference j = new Conference(
									i(c.get("Conference.ID")),
									c.get("Conference.Title"),
									c.get("Conference.Volume")
							);
							Proceedings p = new Proceedings(publication, j.getConferenceID());
							result = new FullInfo(p, a, keyword, publisher);
							result.setAddition(j);
						}
						break;

					case "inproceedings":

						List<Tuple> inproc = cp.init()
								.scan("Inproceedings")
								.filter("Inproceedings.PubID = " + pubId)
								.project("Inproceedings.Crossref", "Inproceedings.Pages")
								.list();

						for (Tuple inp : inproc) {
							Inproceedings i = new Inproceedings(
									publication,
									i(inp.get("Inproceedings.Crossref")),
									inp.get("Inproceedings.Pages")
							);
							result = new FullInfo(i, a, keyword, publisher);
							result.setAddition(getFullPublicationInfo(i.getCrossref()));
						}
						break;
					case "book":

						List<Tuple> books = cp.init()
								.scan("Book")
								.filter("Book.PubID = " + pubId)
								.project("Book.Volume")
								.list();

						for (Tuple b : books) {
							Book j = new Book(publication, b.get("Book.Volume"));
							result = new FullInfo(j, a, keyword, publisher);
						}
						break;

					case "incollection":

						List<Tuple> incoll = cp.init()
								.scan("Incollection")
								.filter("Incollection.PubID = " + pubId)
								.project("Incollection.Crossref", "Incollection.Pages")
								.list();

						for (Tuple inc : incoll) {
							Incollection i = new Incollection(
									publication,
									i(inc.get("Incollection.Crossref")), inc.get("Incollection.Pages")
							);
							result = new FullInfo(i, a, keyword, publisher);
							result.setAddition(getFullPublicationInfo(i.getCrossref()));
						}
						break;
				}
				List<Tuple> authors = cp.init()
						.scan("Author")
						.list();

				List<Tuple> institutions = cp.init()
						.scan("Institution")
						.list();

				List<Tuple> instauthpub = cp.init()
						.scan("InstAuthPub")
						.filter("InstAuthPub.PubID = " + pubId)
						.join("Institution", institutions, "InstAuthPub.InstID", "Institution.ID", "LEFT OUTER")
						.join(authors, "InstAuthPub.Author", "Author.Name", "INNER")
						.project("Author.ID", "InstAuthPub.Author", "Institution.ID", "Institution.Title")
						.list();

				if (result != null) {
					List<Object> authorsProcessed = this.processResult(instauthpub, Author.class);
					result.setAuthors(authorsProcessed);
				}
				return result;
			}

		return null;
	}

	public List<Object> processResult(List<Tuple> result, Class collectionOf) {
		return processResult(result, collectionOf, 0);
	}

	public List<Object> processResult(List<Tuple> result, Class collectionOf, int constID) {
		List<Object> answer = new LinkedList<>();

		try {
			for (Tuple t : result) {
				Constructor c = collectionOf.getDeclaredConstructors()[constID];
				Object[] array = new Object[c.getParameterCount()];
				for (int i = 0; i < c.getParameterCount(); ++i)
					array[i] = ("" + c.getParameterTypes()[i].getSimpleName()).compareTo("int") == 0
							? i(t.get(i)) : t.get(i);

				Object instance = c.newInstance(array);

				answer.add(instance);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return answer;
	}

	public User getUser(String name) {
		List<Tuple> res = cp.scan("User").filter("User.Username = " + name).list();
		List<Object> result = processResult(res, User.class);
		return result.size() > 0 ? (User) result.get(0) : null;
	}

	public Journal getJournal(String title, String volume, String number) {
		List<Tuple> journals = cp.init()
				.scan("Journal")
				.filter("Journal.Title = " + title)
				.filter("Journal.Volume = " + volume)
				.filter("Journal.Number = " + number)
				.project("Journal.ID", "Journal.Title", "Journal.Volume", "Journal.Number")
				.list();

		List<Object> result = processResult(journals, Journal.class);
		return result.size() > 0 ? (Journal) result.get(0) : null;
	}

	public Conference getConference(String title, String volume) {
		List<Tuple> conf = cp.init()
				.scan("Conference")
				.filter("Conference.Title = " + title)
				.filter("Conference.Volume = " + volume)
				.project("Conference.ID", "Conference.Title", "Conference.Volume")
				.list();

		List<Object> result = processResult(conf, Conference.class);
		return result.size() > 0 ? (Conference) result.get(0) : null;
	}

	public Book getBook(String title, String year, String volume) {
		List<Tuple> books = cp.init()
				.scan("Book")
				.filter("Book.Volume = " + volume)
				.list();

		List<Tuple> pubs = cp.init()
				.scan("Publication")
				.filter("Publication.Title = " + title)
				.filter("Publication.Year = " + year)
				.join(books, "Publication.ID", "Book.PubID", "INNER")
				.project("Publication.ID", "Publication.Title", "Publication.Year", "Book.Volume")
				.list();

		List<Object> result = processResult(pubs, Book.class);
		return result.size() > 0 ? (Book) result.get(0) : null;
	}

	public Proceedings getProceedings(String title, String year) {
		List<Tuple> books = cp.init()
				.scan("Book")
				.list();

		List<Tuple> pubs = cp.init()
				.scan("Publication")
				.filter("Publication.Title = " + title)
				.filter("Publication.Year = " + year)
				.join(books, "Publication.ID", "Book.PubID", "INNER")
				.project("Publication.ID", "Publication.Title", "Publication.Year", "Book.Volume")
				.list();

		List<Object> result = processResult(pubs, Proceedings.class);
		return result.size() > 0 ? (Proceedings) result.get(0) : null;
	}

	public Area getArea(String name) {
		List<Tuple> areas = cp.init()
				.scan("Area")
				.filter("Area.Name = " + name)
				.project("Area.ID", "Area.Name")
				.list();

		List<Object> result = processResult(areas, Area.class);
		return result.size() > 0 ? (Area) result.get(0) : null;
	}

	public Keyword getKeyword(String word) {
		List<Tuple> keywords = cp.init()
				.scan("Keyword")
				.filter("Keyword.Word = " + word)
				.project("Keyword.ID", "Keyword.Word")
				.list();


		List<Object> result = processResult(keywords, Keyword.class);
		return result.size() > 0 ? (Keyword) result.get(0) : null;
	}

	public Institution getInstitution(String title) {
		List<Tuple> inst = cp.init()
				.scan("Institution")
				.filter("Institution.Title = " + title)
				.project("Institution.ID", "Institution.Title")
				.list();
		List<Object> result = processResult(inst, Institution.class);
		return result.size() > 0 ? (Institution) result.get(0) : null;
	}

	public Publisher getPublisher(String name) {
		List<Tuple> inst = cp.init()
				.scan("Publisher")
				.filter("Publisher.Name = " + name)
				.project("Publisher.ID", "Publisher.Name")
				.list();

		List<Object> result = processResult(inst, Publisher.class);
		return result.size() > 0 ? (Publisher) result.get(0) : null;
	}

	public Author getAuthor(String name) {
		List<Tuple> auth = cp.init()
				.scan("Author")
				.filter("Author.Name = " + name)
				.project("Author.ID", "Author.Name")
				.list();

		List<Object> result = processResult(auth, Author.class, 1);
		return result.size() > 0 ? (Author) result.get(0) : null;
	}

	public List<Object> getCrossreferenced(String type, String ID) {
		type = Character.toUpperCase(type.charAt(0)) + type.substring(1);

		List<Tuple> smth = cp.init()
				.scan(type)
				.filter(type + ".Crossref = " + ID)
				.list();

		List<Tuple> pubs = cp.init()
				.scan("Publication")
				.join(smth, "Publication.ID", type + ".PubID", "INNER")
				.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type")
				.list();

		return processResult(pubs, Publication.class);
	}
}
