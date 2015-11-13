import db.CollectionRetriever;
import model.FullInfo;
import spark.ModelAndView;
import spark.Request;
import spark.Response;
import spark.Spark;

import java.util.HashMap;

/**
 * @author darkwizard
 */
public class RequestProcessor {
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

	public ModelAndView getPublication(Request req, Response res) {
		int pubNumber = Integer.parseInt(req.params(":number"));
		FullInfo fi = CollectionRetriever.getInstance().getFullPublicationInfo(pubNumber);

		HashMap<String, Object> mapping = new HashMap<>();
		if (fi != null)
			mapping.put("data", fi);
		else mapping.put("data", "haha");

		return new ModelAndView(mapping, "page");
	}

	public ModelAndView getPublicationForUpdate(Request req, Response res) {
		int pubNumber = Integer.parseInt(req.params(":number"));
		FullInfo fi = CollectionRetriever.getInstance().getFullPublicationInfo(pubNumber);

		HashMap<String, Object> mapping = new HashMap<>();
		if (fi != null) {
			mapping.put("data", fi);
		}
		else mapping.put("data", "haha");

		return new ModelAndView(mapping, "update");
	}

	public ModelAndView search(Request req, Response res) {
		String searchFor = req.queryParams("query");
		String searchType = req.queryParams("type");
		String offset = req.queryParams("offset") != null ? req.queryParams("offset") : "0";

		HashMap<String, Object> mapping = new HashMap<>();
		mapping.put("results", CollectionRetriever.getInstance().getPublications(searchType, searchFor, offset));
		mapping.put("offset", offset);
		mapping.put("query", searchFor);
		mapping.put("type", searchType);

		return new ModelAndView(mapping, "searchresult");
	}

	public ModelAndView addPublication(Request rq, Response rs) {
		return new ModelAndView(emptyMapForRenderingNothing, "add");
	}

	public ModelAndView index(Request r, Response response) {
		return new ModelAndView(emptyMapForRenderingNothing, "index");
	}
}
