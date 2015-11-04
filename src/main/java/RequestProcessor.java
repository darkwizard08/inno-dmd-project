import db.CollectionRetriever;
import model.FullInfo;
import spark.ModelAndView;
import spark.Request;
import spark.Response;
import spark.Spark;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author darkwizard
 */
public class RequestProcessor {
	public List<Object> lastResponse = new ArrayList<>();
	public int lastPage = 0;
	public HashMap<String, String> emptyMapForRenderingNothing = new HashMap<>();

	public RequestProcessor() {
		Spark.staticFileLocation("/public"); // Static files
	}

	public ModelAndView login(Request r, Response response) {
		return new ModelAndView(emptyMapForRenderingNothing, "login");
	}

	public String authorize(Request r, Response response) {
		String username = r.queryParams("username");
		String password = r.queryParams("password");

		if ("admin".compareTo(username) == 0 && "admin".compareTo(password) == 0)
			response.redirect("/index");

		Spark.halt(401, "Access denied!");
		return "";
	}

	public ModelAndView search(Request r, Response res) {
		System.out.println("Calling search with page 1");
		lastPage = 1;
		String searchFor = r.queryParams("searchFor");
		String searchType = r.queryParams("searchType");

		System.out.println(searchType);

		switch (searchType) {
			case "researchArea":
				lastResponse = CollectionRetriever.getInstance().getPubsOnResearchArea(searchFor);
				break;
			case "authorName":
				lastResponse = CollectionRetriever.getInstance().getPubsOnAuthorName(searchFor);
				break;
			case "pubYear":
				lastResponse = CollectionRetriever.getInstance().getPublicationsOnYear(searchFor);
				break;
			case "pubTitle":
				lastResponse =  CollectionRetriever.getInstance().getPublicationsOnTitle(searchFor);
				break;
			case "keyword":
				lastResponse = CollectionRetriever.getInstance().getPublicationsOnKeyword(searchFor);
				break;
			case "pubType":
				lastResponse = CollectionRetriever.getInstance().getPublicationsOnType(searchFor);
				break;
			default:
				System.out.println("Unknown case :(");
		}

		return displayPageWithResults(r, res);
	}

	public ModelAndView getPublication(Request req, Response res) {
		int pubNumber = Integer.parseInt(req.params(":number"));
		FullInfo fi = CollectionRetriever.getInstance().getFullPublicationInfo(pubNumber);

		HashMap<String, Object> mapping = new HashMap<>();
		if (fi != null)
			mapping.put("data", fi);
		else mapping.put("data", "haha");

		return new ModelAndView(mapping, "page");
	}

	public ModelAndView displayPageWithResults(Request r, Response resp) {
		final int resultSize = 50;
		System.out.println("Switching page");
		if (r.params(":number") != null)
			lastPage = Integer.parseInt(r.params(":number"));

		HashMap<String, Object> mapping = new HashMap<>();
		if (lastResponse.size() != 0)
			mapping.put("results", lastResponse.subList((lastPage - 1) * resultSize,
					lastPage * resultSize < lastResponse.size() ?
							lastPage * resultSize : lastResponse.size() - 1));
		else mapping.put("results", emptyMapForRenderingNothing);

		mapping.put("pageNum", lastPage);
		mapping.put("pagesTotal", lastResponse.size() / resultSize +
				(lastResponse.size() % resultSize != 0 ? 1 : 0));
		return new ModelAndView(mapping, "searchresult");
	}


	public ModelAndView index(Request r, Response response) {
		return new ModelAndView(emptyMapForRenderingNothing, "index");
	}
}
