package tw.com.sbi.user.controller;

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

//@SuppressWarnings("serial")
public class Usertmp extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String group_id = request.getSession().getAttribute("group_id").toString();
		UserService userService = null;
		String action = request.getParameter("action");
		//System.out.println(action);
		
		if ("search".equals(action)) {
			try {
				userService = new UserService();
				List<UserBean> list = userService.getSearchAllDB();
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {e.printStackTrace();}
		}else if ("insert".equals(action)) {
			try {
				String user_name = request.getParameter("user_name");
				String email = request.getParameter("email");
				String administrator = request.getParameter("administrator");
				userService = new UserService();
				userService.insertDB(group_id,user_name,email,administrator);
				List<UserBean> list = userService.getSearchAllDB();
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {e.printStackTrace();}
		}else if ("update".equals(action)) {
			try {
				String user_id = request.getParameter("user_id");
				String username = request.getParameter("username");
				String email = request.getParameter("email");
				String administrator = request.getParameter("administrator");
				userService = new UserService();
				
				
				userService.updateDB(user_id,username,email,administrator);
				List<UserBean> list = userService.getSearchAllDB();
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {e.printStackTrace();}
		}else if ("delete".equals(action)) {
			try {
				String user_id = request.getParameter("user_id");
				userService = new UserService();
				userService.deleteGroup(user_id);
				List<UserBean> list = userService.getSearchAllDB();
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {e.printStackTrace();}
		}
	}

	/************************* 對應資料庫表格格式 **************************************/
	public class UserBean implements java.io.Serializable {
		private String  user_id;
		private String  group_id;
		private String  user_name;
		private String  email;
		private String  password;
		private String  administrator;
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
		public String getGroup_id() {
			return group_id;
		}
		public void setGroup_id(String group_id) {
			this.group_id = group_id;
		}
		public String getUser_name() {
			return user_name;
		}
		public void setUser_name(String user_name) {
			this.user_name = user_name;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getAdministrator() {
			return administrator;
		}
		public void setAdministrator(String administrator) {
			this.administrator = administrator;
		}
		
	}

	/*************************** 制定規章方法 ****************************************/
	interface User_interface {
		public void updateDB(String user_id,String username,String email,String administrator);
		public void deleteDB(String user_id);
		public void insertDB(String group_id,String user_name,String email,String administrator);
		public List<UserBean> searchAllDB();
	}

	/*************************** 處理業務邏輯 ****************************************/
	class UserService {
		private User_interface dao;

		public UserService() {
			dao = new UserDAO();
		}

		public void updateDB(String user_id,String username,String email,String administrator) {
			dao.updateDB(user_id,username,email,administrator);
		}
		public void insertDB(String group_id,String user_name,String email,String administrator) {
			dao.insertDB(group_id,user_name,email,administrator);
		}
		public void deleteGroup(String group_id) {
			dao.deleteDB(group_id);
		}
	
		public List<UserBean> getSearchAllDB() {
			return dao.searchAllDB();
		}
	}

	/*************************** 操作資料庫 ****************************************/
	class UserDAO implements User_interface {
		// 會使用到的Stored procedure	
		private static final String selectall = "select * from tb_user";
		private static final String insert = "insert into tb_user (user_id,group_id,user_name,email,password,administrator) VALUES (UUID(),?,?,?,?,?)";
		private static final String update = "update tb_user set user_name = ?,email = ?,administrator = ? where user_id = ?";
		private static final String delete = "delete from tb_user where user_id = ?";

//		private final String dbURL = "jdbc:mysql://192.168.112.164/cdri"
//				+ "?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		private final String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL")
				+ "?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		private final String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		private final String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");
		
		@Override
		public void insertDB(String group_id,String user_name,String email,String administrator) {
			// TODO Auto-generated method stub
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(insert);

				pstmt.setString(1, group_id);
				pstmt.setString(2, user_name);
				pstmt.setString(3, email);
				pstmt.setString(4,"*A4B6157319038724E3560894F7F932C8886EBFCF");
				pstmt.setString(5, administrator);
				pstmt.executeUpdate();
				// Handle any SQL errors
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
				// Clean up JDBC resources
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
			} finally {
				if (pstmt != null) {try {pstmt.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
		}
		
		@Override
		public void deleteDB(String user_id) {
			// TODO Auto-generated method stub
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(delete);

				pstmt.setString(1, user_id);
				pstmt.executeUpdate();
				// Handle any SQL errors
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
				// Clean up JDBC resources
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
			} finally {
				if (pstmt != null) {try {pstmt.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
		}

		@Override
		public void updateDB(String user_id,String username,String email,String administrator) {
			// TODO Auto-generated method stub
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(update);
				//System.out.println(group_name+"  "+group_id);
				pstmt.setString(1, username);
				pstmt.setString(2, email);
				pstmt.setString(3, administrator);
				pstmt.setString(4, user_id);
				pstmt.executeUpdate();
				// Handle any SQL errors
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
				// Clean up JDBC resources
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
			} finally {
				if (pstmt != null) {try {pstmt.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
		}
		
		@Override
		public List<UserBean> searchAllDB() {
			// TODO Auto-generated method stub
			List<UserBean> list = new ArrayList<UserBean>();
			UserBean userBean = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(selectall);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					userBean = new UserBean();
					userBean.setUser_id(rs.getString("user_id"));
					userBean.setGroup_id(rs.getString("group_id"));
					userBean.setUser_name(rs.getString("user_name"));
					userBean.setEmail(rs.getString("email"));
					userBean.setPassword(rs.getString("password"));
					userBean.setAdministrator(rs.getString("administrator"));
					list.add(userBean); // Store the row in the list
				}

				// Handle any driver errors
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
				// Clean up JDBC resources
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
			} finally {
				if (pstmt != null) {try {pstmt.close();} catch (SQLException se) {se.printStackTrace(System.err);}}
				if (con != null) {try {con.close();} catch (Exception e) {e.printStackTrace(System.err);}}
			}
			return list;
		}

	}

}
