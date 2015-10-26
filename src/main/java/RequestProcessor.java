import java.util.HashMap;

import spark.ModelAndView;
import spark.Request;
import spark.Response;
import spark.Spark;

/**
 * @author darkwizard
 */
public class RequestProcessor {

	public RequestProcessor() {
		Spark.staticFileLocation("/public"); // Static files
	}

	public HashMap<String, String> emptyMapForRenderingNothing = new HashMap<>();

	public ModelAndView login(Request r, Response response) {
		return new ModelAndView(emptyMapForRenderingNothing, "login");
	}

	public String authorize(Request r, Response response) {
		System.out.println(r.body());
		String[] args = r.body().split("&");
		String username = args[0].split("=")[1];
		String password = args[1].split("=")[1];

		if ("admin".compareTo(username) == 0 && "admin".compareTo(password) == 0)
			response.redirect("/index");

		Spark.halt(401, "Access denied!");
		return "";
	}

	public ModelAndView index(Request r, Response response) {
		return new ModelAndView(emptyMapForRenderingNothing, "index");
	}
}
