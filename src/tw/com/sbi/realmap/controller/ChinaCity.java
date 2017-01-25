package tw.com.sbi.realmap.controller;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

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

import tw.com.sbi.vo.FincaseVO;

import java.util.concurrent.TimeUnit;
public class ChinaCity extends HttpServlet {
	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		if("draw_shpLegend".equals(action)){
			String type=request.getParameter("type");//"GDP";
			GetData getData= new GetData();
			String tmp = getData.buildup1(type)+"|"+getData.buildup2(type);//+"|"+getData.buildup3(type);
			response.getWriter().write(tmp);
		}
		if("change_select".equals(action)){
			String type = request.getParameter("type");
			//String year = request.getParameter("year");
			GetData getData= new GetData();
			String tmp = getData.change_select(type);
			response.getWriter().write(tmp);
		}
	}
	public class GetData{
		private final String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL")
				+ "?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		private final String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		private final String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");
//		private final String wsPath = getServletConfig().getServletContext().getInitParameter("pythonwebservice");
		String buildquery1 = "SELECT ? data FROM tb_SHP_ChinaCity";
		String buildquery2 = "SELECT DISTINCT unit FROM tb_STAT_City WHERE English = ? ";
		//String buildquery3 = "SELECT DISTINCT Type year FROM tb_STAT_Trget_Country WHERE Second_Trget= ? ";
		String changequery = "SELECT City, ? data, geom FROM tb_SHP_ChinaCity ";
		public String buildup1(String type) {//分割的四個數字和 min max
			List<String> strlist= new ArrayList<String>();
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
//			StringBuilder sb = new StringBuilder();
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				String tmpquery = "SELECT "+ type +" data FROM tb_SHP_ChinaCity";
				pstmt = con.prepareStatement(tmpquery);
				//pstmt.setString(1, type);
				//pstmt.setString(2, type);
				rs = pstmt.executeQuery();
				int min=1000000000,max=-1000000000;
				while (rs.next()) {
					int tmp=Math.round(Float.parseFloat(rs.getString("data")));
					if(tmp>max)max=tmp;
					if(tmp<min)min=tmp;
					strlist.add(rs.getString("data"));
					//System.out.println(max+" : "+min);
				}
				if(strlist.isEmpty()){ return "";}
				String tag="";
				for(int i=1;i<5;i++){
					String tmp;
					if(max>10000){
						tmp =  "" + Math.round(( (max-min) * 0.2 * i + min)/100) * 100 ;
						//System.out.println("2"+tmp+" : "+max+" : "+min);
					}else{
						tmp =  "" + Math.round(( (max-min) * 0.2 * i + min) *10) * 0.1 ;
						//System.out.println("3"+tmp+" : "+max+" : "+min);
					}
					//tag+=tmp.substring(0, tmp.indexOf(".") + 1);
					int tmp_comma=tmp.indexOf(".");
					if(tmp_comma!=-1 && (tmp_comma+2)<=tmp.length()){
						tag+=tmp.substring(0, tmp_comma+2);
					}else{
						tag+=tmp;
					}
					if(i!=5)tag+=",";
				}
				
				if(strlist.size()>10){
					return String.join(",", Quantile_GetBreaks(strlist,5))+"|"+min+"|"+max;
					//上面是原本商發院的版本 因為資料量不多 暫時先改成Ben的版本
				}else{
					return tag+"|"+min+"|"+max;
				}
//				System.out.println("123 "+String.join(",", strlist));
//				System.out.println("456 "+sb.toString());
				//Gson gson = new Gson();
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
			} finally {
				// Clean up JDBC resources
				if (rs != null) {try {rs.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (pstmt != null) {try {pstmt.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
		}
		public String buildup2(String type) {//unit
			List<String> strlist= new ArrayList<String>();
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(buildquery2);
				pstmt.setString(1, type);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					strlist.add(rs.getString("unit"));
				}
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
			} finally {
				// Clean up JDBC resources
				if (rs != null) {try {rs.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (pstmt != null) {try {pstmt.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
			return String.join(",", strlist);
		}
//		public String buildup3(String type) {//年份列表
//			List<String> strlist= new ArrayList<String>();
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			ResultSet rs = null;
//			try {
//				Class.forName("com.mysql.jdbc.Driver");
//				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
//				pstmt = con.prepareStatement(buildquery3);
//				pstmt.setString(1, type);
//				rs = pstmt.executeQuery();
//				while (rs.next()) {
//					strlist.add(rs.getString("year"));
//				}
//			} catch (SQLException se) {
//				// Handle any driver errors
//				throw new RuntimeException("A database error occured. " + se.getMessage());
//			} catch (ClassNotFoundException cnfe) {
//				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
//			} finally {
//				// Clean up JDBC resources
//				if (rs != null) {try {rs.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
//				if (pstmt != null) {try {pstmt.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
//				if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
//			}
//			return String.join(",", strlist);
//		}
		public String change_select(String type) {
			List<Country> countrylist= new ArrayList<Country>();
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String jsonList = "";
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				//System.out.println(changequery+" "+year+" "+type);
				String tmpquery="SELECT City, "+type+" data, geom FROM tb_SHP_ChinaCity ";
				pstmt = con.prepareStatement(tmpquery);
				//pstmt.setString(1, type);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Country country =new Country();
					country.country_name=rs.getString("City");
					country.data=rs.getString("data");
					country.geom=rs.getString("geom");
					countrylist.add(country);
					//System.out.println(rs.getString("City")+" # "+rs.getString("data")+" # "+rs.getString("geom").substring(0, 30));
				}
				Gson gson = new Gson();
				jsonList = gson.toJson(countrylist);
				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
			} finally {
				// Clean up JDBC resources
				if (rs != null) {try {rs.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (pstmt != null) {try {pstmt.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
			//System.out.println(jsonList);
			return jsonList;
		}
		public String[] Quantile_GetBreaks(List<String> list, int count) {//小功能
			int i;
	        Collections.sort(list,
	        new Comparator<String>() {
	            public int compare(String o1, String o2) {
	            	return (int) (Float.parseFloat(o1) - Float.parseFloat(o2));
	            }
	        });
	        if(count==0 || list.size() == 0)return null;
	        String[] result = new String[count-1];
	        int jumprate = list.size()/count;
	        for ( i = 1; i < count; i++)
            {
	        	//System.out.println((count-1)+"  "+jumprate*count);
	        	if(Float.parseFloat(list.get(jumprate*i))>10000){
	        		result[i-1]= "" + Math.round(Float.parseFloat(list.get(jumprate*i))/100) * 100 ;
	        	}else{
	        		result[i-1]=list.get(jumprate*i);
	        	}
            }
	        return result;
//	        for (Object o:list) {
//	            System.out.println(o);
//	        }
//	        System.out.println(String.join(",", list));
//			
//			return null;
		}
		class Country {
			String country_name;
			String data;
			String geom;
		}
	}
}