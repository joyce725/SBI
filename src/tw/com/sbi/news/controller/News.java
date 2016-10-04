package tw.com.sbi.news.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

import static java.util.Arrays.asList;


public class News extends HttpServlet  {

	private static final long serialVersionUID = 1L;

	private static final Logger logger = LogManager.getLogger(News.class);

	private MongoClient mongoClient;
	
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String action = request.getParameter("action");
		if("onload".equals(action)){
			NewsService newsService = new NewsService();
			JSONArray jsonArray = newsService.getNews();
			response.getWriter().write(jsonArray.toString());
		}
	}
	
	public class NewsService {
		private News_interface dao;
		
		public NewsService() {
			dao = new NewsDAO();
		}
		
		public JSONArray getNews(){
			logger.info("into NewsService getNews function");
			return dao.getNews();
		}
	}
	
	interface News_interface {
		public JSONArray getNews();
	}
	
	class NewsDAO implements News_interface {

		private final String mongoPath = getServletConfig().getServletContext().getInitParameter("mongodbpath");
		private final int mongoPort = Integer.parseInt(getServletConfig().getServletContext().getInitParameter("mongodbport"));
		private final String mongoDatabase = getServletConfig().getServletContext().getInitParameter("mongodb");
		private final String mongoCollection = getServletConfig().getServletContext().getInitParameter("mongocollection");
		
		@Override
		public JSONArray getNews(){

			List<String> jsonList = new ArrayList<String>();
			JSONObject jsonObject = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			
			// To directly connect to a single MongoDB server
			// (this will not auto-discover the primary even if it's a member of a replica set)
			mongoClient = new MongoClient(mongoPath, mongoPort);
			MongoDatabase database = mongoClient.getDatabase(mongoDatabase);
			MongoCollection<Document> collection = database.getCollection(mongoCollection);
			
			MongoCursor<String> cursor = collection.distinct("source", String.class).iterator();
			try {
				while (cursor.hasNext()) {
					String source = cursor.next();
					MongoCursor<Document> result = collection.aggregate(asList(
							new Document("$project", new Document("source", 1).append("title", 1).append("link", 1)),
//						new Document("$project", new Document("title", 1)),
						new Document("$match", new Document("source", source)),
						new Document("$limit", 5))).iterator();
					
					while (result.hasNext()) {
						jsonList.add(result.next().toJson());					
					}
					jsonObject.put("source", source);
					jsonObject.put("data", jsonList);
//					logger.info("jsonObject: " + jsonObject);
					jsonArray.put(jsonObject);
					jsonList = new ArrayList<String>();
					jsonObject = new JSONObject();
				}
			} finally {
			    cursor.close();
			}
			
			return jsonArray;
		}
	}
}
