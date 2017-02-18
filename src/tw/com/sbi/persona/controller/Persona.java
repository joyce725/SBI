package tw.com.sbi.persona.controller;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class Persona extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		String userId = request.getSession().getAttribute("user_id").toString();
		String groupId = request.getSession().getAttribute("group_id").toString();
		
		String action = request.getParameter("action");
		if("persona".equals(action)){
			
			System.out.println("sex:" + request.getParameter("sex") + ","
					+ "age:" + request.getParameter("age") + ","
					+ "px3:" + request.getParameter("px3") + ","
					+ "px4:" + request.getParameter("px4") + ","
					+ "px5:" + request.getParameter("px5") + ","
					+ "px6:" + request.getParameter("px6") + ","
					+ "px7:" + request.getParameter("px7") + ","
					+ "px8:" + request.getParameter("px8") + ","
					+ "px9:" + request.getParameter("px9") + ",");
			
			String url = getServletConfig().getServletContext().getInitParameter("pythonwebservice")+"/persona/"
				+"sex="+new String(Base64.encodeBase64String(request.getParameter("sex").getBytes()))
				+"&age="+new String(Base64.encodeBase64String(request.getParameter("age").getBytes()))
				+"&px3="+new String(Base64.encodeBase64String(request.getParameter("px3").getBytes()))
				+"&px4="+new String(Base64.encodeBase64String(request.getParameter("px4").getBytes()))
				+"&px5="+new String(Base64.encodeBase64String(request.getParameter("px5").getBytes()))
				+"&px6="+new String(Base64.encodeBase64String(request.getParameter("px6").getBytes()))
				+"&px7="+new String(Base64.encodeBase64String(request.getParameter("px7").getBytes()))
				+"&px8="+new String(Base64.encodeBase64String(request.getParameter("px8").getBytes()))
				+"&px9="+new String(Base64.encodeBase64String(request.getParameter("px9").getBytes()));
			
			System.out.println(url);
			HttpGet httpRequest = new HttpGet(url);
        	HttpClient client = HttpClientBuilder.create().build();
        	HttpResponse httpResponse;
        	try {
        		StringBuffer result = new StringBuffer();
        		httpResponse = client.execute(httpRequest);
    			int responseCode = httpResponse.getStatusLine().getStatusCode();
    
    	    	if(responseCode==200){
    	    		BufferedReader rd = new BufferedReader(new InputStreamReader(httpResponse.getEntity().getContent()));
        	    	String line = "";
        	    	while ((line = rd.readLine()) != null) {
        	    		result.append(line);
        	    	}	
    	    		response.getWriter().write(result.toString());
    	    	}
    	    	else{
    	    		System.out.println("responseCode: " + responseCode+"\nfail to get data");
    	    	}    	    	
    		}catch (Exception e){System.out.println(e.toString());}
//			String product_name = request.getParameter("product_name");
//			String sex = request.getParameter("sex");
//			String age = request.getParameter("age");
//			String px3 = request.getParameter("px3");
//			String px4 = request.getParameter("px4");
//			String px5 = request.getParameter("px5");
//			String px6 = request.getParameter("px6");
//			String px7 = request.getParameter("px7");
//			String px8 = request.getParameter("px8");
//			String px9 = request.getParameter("px9");
        	System.out.println(url);
//        	System.out.println(product_name+" "+sex+" "+age+" "+px3+px4+px5+px6+px7+px8+px9);
		}
	}
}
