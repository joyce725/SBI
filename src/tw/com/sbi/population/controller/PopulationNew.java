package tw.com.sbi.population.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.google.gson.Gson;

import java.util.Date; 
import java.text.SimpleDateFormat;

public class PopulationNew extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL")
				+"?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String[] result=new String[1];
		String[] result_id=new String[1];
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
			String action= request.getParameter("action");
//		#####################################################
		
			if("search_county".equals(action)){
				pstmt = con.prepareStatement("SELECT DISTINCT COUNTY, COUNTY_ID FROM tb_population");
				rs = pstmt.executeQuery();
				int count,k=0;if (rs.last()){count = rs.getRow();}else{count = 0;}rs.beforeFirst();
				result=new String[count];
				result_id=new String[count];
			    while (rs.next()) {
			    	result[k]=rs.getString("COUNTY");
			    	result_id[k]=rs.getString("COUNTY_ID");
			    	k++;
				}
			}else if("search_town".equals(action)){
				String county= request.getParameter("county");
				pstmt = con.prepareStatement("SELECT DISTINCT TOWN,TOWN_ID FROM tb_population WHERE COUNTY_ID = ?");
				pstmt.setString(1,county);
				rs = pstmt.executeQuery();
				int count,k=0;if (rs.last()){count = rs.getRow();}else{count = 0;}rs.beforeFirst();
				result=new String[count];
				result_id=new String[count];
			    while (rs.next()) {
			    	result[k]=rs.getString("TOWN");
			    	result_id[k]=rs.getString("TOWN_ID");
			    	k++;
				}
			}else if("search_village".equals(action)){
				String town= request.getParameter("town");
				pstmt = con.prepareStatement("SELECT DISTINCT VILLAGE,V_ID FROM tb_population WHERE TOWN_ID = ?");
				pstmt.setString(1,town);
				rs = pstmt.executeQuery();
				int count,k=0;if (rs.last()){count = rs.getRow();}else{count = 0;}rs.beforeFirst();
				result=new String[count];
				result_id=new String[count];
			    while (rs.next()) {
			    	result[k]=rs.getString("VILLAGE");
			    	result_id[k]=rs.getString("V_ID");
			    	k++;
				}
			}
//			}else if("search_result".equals(action)){
//				String county= request.getParameter("county");
//				String town= request.getParameter("town");
//				String village= request.getParameter("village");
//				pstmt = con.prepareStatement("SELECT DISTINCT VILLAGE FROM tb_population WHERE COUNTY= ? AND TOWN = ? AND VILLAGE = ? ");
//				pstmt.setString(1,county);
//				pstmt.setString(2,town);
//				pstmt.setString(3,village);
//				rs = pstmt.executeQuery();
//				int count,k=0;if (rs.last()){count = rs.getRow();}else{count = 0;}rs.beforeFirst();
//				result=new String[count];
//			    while (rs.next()) {
//			    	result[k++]=rs.getString("VILLAGE");
//				}
//			}
			
		} catch (SQLException se) {System.out.println("ERROR WITH: "+se);
		} catch (ClassNotFoundException cnfe) {
			throw new RuntimeException("A database error occured. " + cnfe.getMessage());
		}
		Gson gson = new Gson();
		String jsonStrList = gson.toJson(result);
		response.getWriter().write("{\"result\":"+jsonStrList+",\"result_id\":"+gson.toJson(result_id)+"}");
		return;
		//###########################################
	}

}
