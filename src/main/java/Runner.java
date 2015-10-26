/**
 * @author darkwizard
 */

import spark.template.jade.JadeTemplateEngine;

import static spark.Spark.*;

public class Runner {
	public static void main(String[] args) {
		new Runner().run();
	}

	public void run() {
		RequestProcessor proc = new RequestProcessor();
		get("/", (req, res) -> {res.redirect("/login"); return "Moving...";});
		get("/login", proc::login, new JadeTemplateEngine());
		get("/index", proc::index, new JadeTemplateEngine());
		post("/authorize", proc::authorize);
	}


}
