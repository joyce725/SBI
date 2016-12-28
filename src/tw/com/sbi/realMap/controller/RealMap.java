package tw.com.sbi.realMap.controller;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

//import org.apache.http.HttpResponse;
//import org.apache.http.client.ClientProtocolException;
//import org.apache.http.config.Lookup;
//import org.apache.http.client.HttpClient;
//import org.apache.http.client.methods.HttpGet;
//import org.apache.http.impl.client.BasicResponseHandler;
//import org.apache.http.impl.client.HttpClientBuilder;

import java.util.ArrayList;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import com.google.gson.Gson;
//import tw.com.sbi.vo.FincaseVO;

import java.util.concurrent.TimeUnit;
public class RealMap extends HttpServlet {
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		final String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL")
				+ "?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		final String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		final String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");
		
		String action = request.getParameter("action").toString();
		String name = request.getParameter("name").toString();
		
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
//		int i=0;if(i==0)return;
		if("select_poi".equals(action)){
			POI[] poi_array;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				statement = con.createStatement();
				Float lat = Float.parseFloat(request.getParameter("lat").toString());
				Float lng = Float.parseFloat(request.getParameter("lng").toString());
				int zoom = Integer.valueOf(request.getParameter("zoom").toString());
				String cmd ="";
				if ( zoom < 6 ){}else{
					float rangelat=0,rangelng=0;
					if (zoom == 6 ){ rangelat=(float)7.189065946400108;rangelng=(float)26.7626953125; }
					if (zoom == 7 ){ rangelat=(float)3.634160791278207;rangelng=(float)13.42529296875; }
					if (zoom == 8 ){ rangelat=(float)1.787952365573586;rangelng=(float)6.6851806640625; }
					if (zoom == 9 ){ rangelat=(float)0.906527594036945;rangelng=(float)3.35357666015625; }
					if (zoom == 10 ){rangelat=(float)0.444468948036502;rangelng=(float)1.67266845703125; }
					if (zoom == 11 ){rangelat=(float)0.224114345560578;rangelng=(float)0.83564758300781; }
					if (zoom == 12 ){rangelat=(float)0.111742516346193;rangelng=(float)0.41885375976562; }
					if (zoom == 13 ){rangelat=(float)0.056970028577563;rangelng=(float)0.20959854125976; }
					if (zoom == 14 ){rangelat=(float)0.02809265942393;rangelng=(float)0.1043701171875; }
					if (zoom == 15 ){rangelat=(float)0.01412479234012;rangelng=(float)0.05227088928223; }
					if (zoom == 16 ){rangelat=(float)0.007062391894589;rangelng=(float)0.02619981765748; }
					if (zoom > 16 ){ rangelat=(float)0.003491961762692;rangelng=(float)0.01306772232056; }
					
					cmd = " and lat > "+String.valueOf(lat-rangelat)+" and lat < "+String.valueOf(lat+rangelat)+" and lng > "+String.valueOf(lng-rangelng)+" and lng <"+String.valueOf(lng+rangelng)+"";
				}
//				System.out.println(cmd);
				String sp="SELECT * FROM tb_data_POI WHERE type = '"+name+"' "+cmd;
				rs = statement.executeQuery(sp);
				int count=0;
			    if (rs.last()){count = rs.getRow();}else{count = 0;}
			    poi_array=new POI[count];
//			    System.out.println("poi count: " + count);
			    rs.beforeFirst();count=0;
				
				while (rs.next()) {
					poi_array[count]= new POI();
					poi_array[count].id=rs.getString("poi_id");
					poi_array[count].type=rs.getString("type");
					poi_array[count].subtype=rs.getString("subtype");
					poi_array[count].name=rs.getString("name");
					poi_array[count].addr=rs.getString("address");//rs.getString("");
					poi_array[count].icon="";//rs.getString("icon");
					poi_array[count].loca="";
					poi_array[count].center= new Center();
					poi_array[count].center.lat=rs.getFloat("lat");
					poi_array[count].center.lng=rs.getFloat("lng");
					count++;
				}
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(poi_array);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				if (rs != null) {try {rs.close();} catch (SQLException se) {se.printStackTrace(System.err);}}if (statement != null) {try {statement.close();} catch (SQLException se) {se.printStackTrace(System.err);}}if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
			response.getWriter().write("fail!!!!!");
			return;
		}
		if("select_poi_2".equals(action)){
			POI[] poi_array;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				statement = con.createStatement();
				
				Float lat = Float.parseFloat(request.getParameter("lat").toString());
				Float lng = Float.parseFloat(request.getParameter("lng").toString());
				int zoom = Integer.valueOf(request.getParameter("zoom").toString());
				String cmd ="";
				if ( zoom < 6 ){}else{
					float rangelat=0,rangelng=0;
					if (zoom == 6 ){ rangelat=(float)7.189065946400108;rangelng=(float)26.7626953125; }
					if (zoom == 7 ){ rangelat=(float)3.634160791278207;rangelng=(float)13.42529296875; }
					if (zoom == 8 ){ rangelat=(float)1.787952365573586;rangelng=(float)6.6851806640625; }
					if (zoom == 9 ){ rangelat=(float)0.906527594036945;rangelng=(float)3.35357666015625; }
					if (zoom == 10 ){rangelat=(float)0.444468948036502;rangelng=(float)1.67266845703125; }
					if (zoom == 11 ){rangelat=(float)0.224114345560578;rangelng=(float)0.83564758300781; }
					if (zoom == 12 ){rangelat=(float)0.111742516346193;rangelng=(float)0.41885375976562; }
					if (zoom == 13 ){rangelat=(float)0.056970028577563;rangelng=(float)0.20959854125976; }
					if (zoom == 14 ){rangelat=(float)0.02809265942393;rangelng=(float)0.1043701171875; }
					if (zoom == 15 ){rangelat=(float)0.01412479234012;rangelng=(float)0.05227088928223; }
					if (zoom == 16 ){rangelat=(float)0.007062391894589;rangelng=(float)0.02619981765748; }
					if (zoom > 16 ){ rangelat=(float)0.003491961762692;rangelng=(float)0.01306772232056; }
					
					cmd = " and lat > "+String.valueOf(lat-rangelat)+" and lat < "+String.valueOf(lat+rangelat)+" and lng > "+String.valueOf(lng-rangelng)+" and lng <"+String.valueOf(lng+rangelng)+"";
				}
				
				
				String sp="SELECT * FROM tb_data_POI WHERE subtype = '"+name+"' "+cmd;
				rs = statement.executeQuery(sp);
				int count=0;
			    if (rs.last()){count = rs.getRow();}else{count = 0;}
			    poi_array=new POI[count];
//			    System.out.println("poi2 count: " + count);
			    rs.beforeFirst();count=0;
				
				while (rs.next()) {
					poi_array[count]= new POI();
					poi_array[count].id=rs.getString("poi_id");
					poi_array[count].type=rs.getString("type");
					poi_array[count].subtype=rs.getString("subtype");
					poi_array[count].name=rs.getString("name");
					poi_array[count].addr=rs.getString("address");//rs.getString("");
					poi_array[count].icon="";//rs.getString("icon");
					poi_array[count].loca="";
					poi_array[count].center= new Center();
					poi_array[count].center.lat=rs.getFloat("lat");
					poi_array[count].center.lng=rs.getFloat("lng");
					count++;
				}
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(poi_array);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				if (rs != null) {try {rs.close();} catch (SQLException se) {se.printStackTrace(System.err);}}if (statement != null) {try {statement.close();} catch (SQLException se) {se.printStackTrace(System.err);}}if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
			response.getWriter().write("fail!!!!!");
			return;
		}
		if("select_BD".equals(action)){
			BD[] bd_array;
			//System.out.println("coming?");
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				statement = con.createStatement();
				String sp="SELECT * FROM tb_data_BD WHERE BD = '"+name+"'";
				rs = statement.executeQuery(sp);
				int count=0;
			    if (rs.last()){count = rs.getRow();}else{count = 0;}
			    bd_array=new BD[count];
//			    System.out.println(count);
			    rs.beforeFirst();count=0;
				
				while (rs.next()) {
					bd_array[count]= new BD();
					bd_array[count].id=rs.getString("BD_id");
					bd_array[count].BD_name=rs.getString("BD");
					bd_array[count].city=rs.getString("city");
					bd_array[count].geometry=rs.getString("geometry");
					bd_array[count].middle=new Center();
					bd_array[count].middle.lat=rs.getFloat("lat");
					bd_array[count].middle.lng=rs.getFloat("lng");
					bd_array[count].lat=rs.getString("lat");
					bd_array[count].lng=rs.getString("lng");
					String geometrystring = rs.getString("geometry").replaceAll("\\(", "").replaceAll("\\)", "");
//					geometrystring= "((106.821159 -6.191856, 106.822433 -6.189573, 106.822563 -6.191813, 106.821159 -6.191856))".replaceAll("\\(", "").replaceAll("\\)", "");
					String[] point = geometrystring.split(",");
					bd_array[count].center=new Center[point.length];
					
					
			        for(int i = 0 ; i < point.length ; i ++){
			        	bd_array[count].center[i]= new Center();
			        	
			        	String[] latlng = point[i].split(" ");
			        	int get=0;
			        	for(int j = 0 ; j < latlng.length ; j ++){
			        		
			        		if( isFloat(latlng[j]) ){
			        			if(get==0){
			        				get=1;
			        				bd_array[count].center[i].lng=Float.parseFloat(latlng[j]);
			        			}else{
			        				bd_array[count].center[i].lat=Float.parseFloat(latlng[j]);
			        			}
			        		}
			        	}
			        	
			        }
					count++;
				}
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(bd_array);
				response.getWriter().write(jsonStrList);
				
				return;
			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				if (rs != null) {try {rs.close();} catch (SQLException se) {se.printStackTrace(System.err);}}if (statement != null) {try {statement.close();} catch (SQLException se) {se.printStackTrace(System.err);}}if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
			response.getWriter().write("fail!!!!!");
			return;
		}
		if("select_menu".equals(action)){
			Menu[] menu_array;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				statement = con.createStatement();
				rs = statement.executeQuery("SELECT * FROM tb_data_menu");
				int count=0;
			    if (rs.last()){count = rs.getRow();}else{count = 0;}
			    menu_array=new Menu[count];
//			    System.out.println("coming?"+count);
			    rs.beforeFirst();count=0;
				while (rs.next()) {
					menu_array[count] = new Menu();
					menu_array[count].key=rs.getString("menu_id");
					menu_array[count].title=rs.getString("menu_name");
					if("true".equals(rs.getString("folder"))){menu_array[count].folder=rs.getString("folder");}
					menu_array[count].action=rs.getString("action");
					menu_array[count].children = new ArrayList<Menu>();
//					menu_array[count].children.add(menu_array[count]);
//					System.out.println("coming!!"+menu_array.length+" ");
					count++;
				}
				
				rs.beforeFirst();count=0;
				while (rs.next()) {
					for(int i=0;i<menu_array.length;i++){
						if(menu_array[i]!=null){
							if(menu_array[i].key.equals(rs.getString("parent_id"))){
								menu_array[i].children.add(menu_array[count]);
							}
						}
					}
					count++;
				}
//				System.out.println("coming##");
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(menu_array[0]);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				if (rs != null) {try {rs.close();} catch (SQLException se) {se.printStackTrace(System.err);}}if (statement != null) {try {statement.close();} catch (SQLException se) {se.printStackTrace(System.err);}}if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
			response.getWriter().write("fail!!!!!");
			return;
		}
		if("select_menu_act".equals(action)){//好像不用?
			
		}
		
		
		System.out.println("coming soon?");
		return ;
	}
	
	class Center{
		float lat;
		float lng;
	}
	
	class BD {
		String id;
		String city;
		String BD_name;
		String geometry;
		String lat;
		String lng;
		Center middle;
		Center[] center;
	}
	
	class POI{
		String id;
		String name;
		String type;
		String subtype;
		String icon;
		String addr;
		String loca;
		Center center;
	}
	
	class Menu{
		String title;
		String key;
		String action;
		String folder;
		List<Menu> children; 
	}
	private static boolean isFloat(String str){
	  try{
	   Float.parseFloat(str);
	  }catch (Exception e){
	   //System.out.println("輸入錯誤");
	   return false;
	  }
	  return str.contains(".");
	 }
	
}
