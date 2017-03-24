package tw.com.sbi.realmap.controller;
import javax.servlet.ServletException;


import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.*;
import com.google.gson.Gson;

import tw.com.sbi.scenariojob.controller.ScenarioJob;
import tw.com.sbi.vo.ScenarioJobVO;
@SuppressWarnings("serial")
public class RealMap extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LogManager.getLogger(RealMap.class);
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
		String action = null2Str(request.getParameter("action"));
		String name = null2Str(request.getParameter("name"));
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		if("get_ChinaCity_Data".equals(action)){
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				statement = con.createStatement();
				String sp="SELECT * FROM tb_CHART_city WHERE city = '"+name+"'";
				rs = statement.executeQuery(sp);
				ChinaCityData ccd= new ChinaCityData();
				while (rs.next()) {
					ccd.link1=rs.getString("link1");
					ccd.link2=rs.getString("link2");
					ccd.link3=rs.getString("link3");
					ccd.link4=rs.getString("link4");
					ccd.link5=rs.getString("link5");
					ccd.link6=rs.getString("link6");
					ccd.link7=rs.getString("link7");
					ccd.link8=rs.getString("link8");
				}
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(ccd);
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
				String sp="SELECT * FROM tb_data_POI WHERE type = '"+name+"' "+cmd;
				rs = statement.executeQuery(sp);
				int count=0;
			    if (rs.last()){count = rs.getRow();}else{count = 0;}
			    poi_array=new POI[count];
			    rs.beforeFirst();count=0;
				while (rs.next()) {
					poi_array[count]= new POI();
					poi_array[count].id=rs.getString("poi_id");
					poi_array[count].type=rs.getString("type");
					poi_array[count].subtype=rs.getString("subtype");
					poi_array[count].name=rs.getString("name");
					poi_array[count].addr=rs.getString("address");//rs.getString("");
					poi_array[count].icon=rs.getString("icon");
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
			    rs.beforeFirst();count=0;
				while (rs.next()) {
					poi_array[count]= new POI();
					poi_array[count].id=rs.getString("poi_id");
					poi_array[count].type=rs.getString("type");
					poi_array[count].subtype=rs.getString("subtype");
					poi_array[count].name=rs.getString("name");
					poi_array[count].addr=rs.getString("address");//rs.getString("");
					poi_array[count].icon=rs.getString("icon");
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
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				statement = con.createStatement();
				String sp="SELECT * FROM tb_data_BD WHERE BD = '"+name+"'";
				rs = statement.executeQuery(sp);
				int count=0;
			    if (rs.last()){count = rs.getRow();}else{count = 0;}
			    bd_array=new BD[count];
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
					bd_array[count].population=rs.getString("population");
					bd_array[count].status=rs.getString("status");
					bd_array[count].radiation=rs.getString("radiation");
					bd_array[count].traffic=rs.getString("traffic");
					bd_array[count].resident=rs.getString("resident");
					bd_array[count].income=rs.getString("income");
					bd_array[count].revenue=rs.getString("revenue");
					bd_array[count].expenditur=rs.getString("expenditur");
					bd_array[count].nearstreet=rs.getString("nearstreet");
					bd_array[count].dept_store=rs.getString("dept_store");
					bd_array[count].working_po=rs.getString("working_po");
					bd_array[count].risk_5=rs.getString("5risk");
					bd_array[count].area=rs.getString("area");
					bd_array[count].memo=rs.getString("memo");
					bd_array[count].business_cost=rs.getString("business_cost");
					String geometrystring = rs.getString("geometry").replaceAll("\\(", "").replaceAll("\\)", "");
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
			String type = request.getParameter("type").toString();
			Menu[] menu_array;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				statement = con.createStatement();
				rs = statement.executeQuery("SELECT * FROM tb_data_menu");
				int count=0;
			    if (rs.last()){count = rs.getRow();}else{count = 0;}
			    menu_array=new Menu[count];
			    rs.beforeFirst();count=0;
				while (rs.next()) {
					menu_array[count] = new Menu();
					menu_array[count].key=rs.getString("menu_id");
					menu_array[count].title=rs.getString("menu_name");
					if("true".equals(rs.getString("folder"))){menu_array[count].folder=rs.getString("folder");}
					menu_array[count].action=rs.getString("action");
					menu_array[count].children = new ArrayList<Menu>();
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
				Gson gson = new Gson();
				String jsonStrList="";
//				System.out.println(type+"  "+ menu_array[3].title+"  "+menu_array[3].key);
				if("POI".equals(type)){
					jsonStrList = gson.toJson(menu_array[3]);
//					System.out.println(jsonStrList);
				}else if("RealMap".equals(type)){
					jsonStrList = gson.toJson(menu_array[0]);
				}
//				String jsonStrList = gson.toJson(menu_array[0]);
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
		
//		logger.debug("act:  "+action);
		if("select_metro".equals(action)){
			String station_name = null2Str(request.getParameter("station_name"));
			String time = null2Str(request.getParameter("time"));
			String weekend = null2Str(request.getParameter("weekend"));
			Connection con2 = null;
			PreparedStatement pstmt2 = null;
			ResultSet rs2 = null;
			String query = "SELECT AVG(flow) flow_avg "
					+" FROM tb_data_metro "
					+(("weekend".equals(weekend))?" WHERE DAYOFWEEK( tb_data_metro.date ) IN('1','7') ":" WHERE DAYOFWEEK( tb_data_metro.date ) IN('2','3','4','5','6') ")
					+" AND station_name = ? "
					+" AND time = ? ";
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con2 = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt2 = con2.prepareStatement(query);
				
				pstmt2.setString(1, station_name);
				pstmt2.setString(2, time);
				rs2=pstmt2.executeQuery();
				while (rs2.next()) {
					response.getWriter().write(null2Str(rs2.getString("flow_avg")));
				}
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
			} finally {
				// Clean up JDBC resources
				if (rs2 != null) {
					try {
						rs2.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (pstmt2 != null) {
					try {
						pstmt2.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con2 != null) {
					try {
						con2.close();
					} catch (Exception e) {
						e.printStackTrace(System.err);
					}
				}
			}
		}
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
		//資料
		String population;
		String status;
		String radiation;
		String traffic;
		String resident;
		String income;
		String revenue;
		String expenditur;
		String nearstreet;
		String dept_store;
		String working_po;
		String risk_5;
		String area;
		String memo;
		String business_cost;
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
	class ChinaCityData{
		String link1;
		String link2;
		String link3;
		String link4;
		String link5;
		String link6;
		String link7;
		String link8;
	}
	private static boolean isFloat(String str){
	  try{
	   Float.parseFloat(str);
	  }catch (Exception e){
	   return false;
	  }
	  return str.contains(".");
	 }
	private String null2Str(Object object) {
		if (object instanceof Timestamp)
			return object == null ? "" : new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(object);
		return object == null ? "" : object.toString().trim();
	}
}
