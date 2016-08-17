package tw.com.sbi.login.controller;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

import com.google.gson.Gson;

public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	private static final int WIDTH = 120; // 圖片寬度
//	private static final int HEIGHT = 30; // 圖片高度
	
	private static final Logger logger = LogManager.getLogger(Login.class);

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		logger.debug("logger debug");
//		logger.error("logger.error");
//		logger.fatal("logger fatal");
//		logger.info("logger info");
//		logger.trace("logger trace");
//		logger.warn("logger warn");
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		String action = request.getParameter("action");
		HttpSession session = request.getSession(true);
		LoginVO message = null;
		LoginService loginService = null;
		Gson gson = null;

		if ("login".equals(action)) {
			String username = request.getParameter("user_name");
			String password = request.getParameter("pswd");
			loginService = new LoginService();
			List<LoginVO> list = loginService.selectlogin(username, password);
			logger.info(list.get(0).getUser_id());
			logger.info(list.get(0).getUser_name());
			logger.info(list.get(0).getGroup_id());
			logger.info(list.get(0).getRole());
			if (list.size() != 0) {
				session.setAttribute("sessionID", session.getId());
				session.setAttribute("user_id", list.get(0).getUser_id());
				session.setAttribute("group_id", list.get(0).getGroup_id());
				session.setAttribute("user_name", list.get(0).getUser_name());
				session.setAttribute("role", list.get(0).getRole());
			} else {
				message = new LoginVO();
<<<<<<< HEAD
				message.setMessage("failure");
=======
				message.setMessage("code_failure");
				gson = new Gson();
				String jsonStrList = gson.toJson(message);
				response.getWriter().write(jsonStrList);
				return;
			}
			if (checkcode.equals(convertToCapitalString(validateCode))) {
				loginService = new LoginService();
				List<LoginVO> list = loginService.selectlogin(username, password);
				if (list.size() != 0) {
//					 HttpSession session = request.getSession();
					session.setAttribute("sessionID", session.getId());
					session.setAttribute("user_id", list.get(0).getUser_id());
					session.setAttribute("group_id", list.get(0).getGroup_id());
					session.setAttribute("user_name", list.get(0).getUser_name());

					message = new LoginVO();
					message.setMessage("success");
				} else {
					message = new LoginVO();
					message.setMessage("failure");
				}
				gson = new Gson();
				String jsonStrList = gson.toJson(message);
				response.getWriter().write(jsonStrList);
>>>>>>> origin/master
			}
			/*************************   分割線    ************************************/
//			session.setAttribute("sessionID", session.getId());
//			session.setAttribute("user_id", "28423832-6c9e-11e5-ab77-000c29c1d067");
//			session.setAttribute("group_id", "0f74414d-538d-4a49-8d1f-7604153075d0");
//			session.setAttribute("user_name", "Kip");
//			session.setAttribute("role", 0);
//			message = new LoginVO();
//			message.setMessage("success");
			/*************************   分割線    ************************************/
//			logger.info("login function");
//			String username = request.getParameter("user_name");
//			String password = request.getParameter("pswd");
//			String validateCode = request.getParameter("validateCode").trim();
//			Object checkcode = session.getAttribute("checkcode");
//			if (!checkcode.equals(convertToCapitalString(validateCode))) {
//				message = new LoginVO();
//				message.setMessage("code_failure");
//				gson = new Gson();
//				String jsonStrList = gson.toJson(message);
//				response.getWriter().write(jsonStrList);
//				return;
//			}
//			if (checkcode.equals(convertToCapitalString(validateCode))) {
//				loginService = new LoginService();
//				List<LoginVO> list = loginService.selectlogin(username, password);
//				if (list.size() != 0) {
//					session.setAttribute("sessionID", session.getId());
//					session.setAttribute("user_id", list.get(0).getUser_id());
//					session.setAttribute("group_id", list.get(0).getGroup_id());
//					session.setAttribute("user_name", list.get(0).getUser_name());
//					session.setAttribute("role", list.get(0).getRole());
//				} else {
//					message = new LoginVO();
//					message.setMessage("failure");
//				}
//				gson = new Gson();
//				String jsonStrList = gson.toJson(message);
//				response.getWriter().write(jsonStrList);
//			}
		}
		if ("check_user_exist".equals(action)) {
			String username = request.getParameter("user_name");
			loginService = new LoginService();
			if(!loginService.checkuser(username)){
				message = new LoginVO();
				message.setMessage("user_failure");
				gson = new Gson();
				String jsonStrList = gson.toJson(message);
				response.getWriter().write(jsonStrList);
			}
			if(loginService.checkuser(username)){
				message = new LoginVO();
				message.setMessage("success");
				gson = new Gson();
				String jsonStrList = gson.toJson(message);
				response.getWriter().write(jsonStrList);
			}
		}
		if ("logout".equals(action)) {
			session.setAttribute("sessionID", null);
			session.setAttribute("user_id", null);
			session.setAttribute("group_id", null);
			session.setAttribute("user_name", null);
		}
	}

	/**
	 * 將一個字符串中的小寫字母轉換為大寫字母
	 * 
	 * */
	public static String convertToCapitalString(String src) {
		char[] array = src.toCharArray();
		int temp = 0;
		for (int i = 0; i < array.length; i++) {
			temp = (int) array[i];
			if (temp <= 122 && temp >= 97) { // array[i]为小写字母
				array[i] = (char) (temp - 32);
			}
		}
		return String.valueOf(array);
	}

	/************************* 對應資料庫表格格式 **************************************/
	@SuppressWarnings("serial")
	public class LoginVO implements java.io.Serializable {

		private String email;
		private String password;
		private String user_id;
		private String group_id;
		private String user_name;
		private String message;// for set check message

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

		public String getMessage() {
			return message;
		}

		public void setMessage(String message) {
			this.message = message;
		}

	}

	/*************************** 制定規章方法 ****************************************/

	interface login_interface {

		public List<LoginVO> loginDB(String p_user_name, String p_password);

		public Boolean checkuser(String p_user_name);
	}

	/*************************** 處理業務邏輯 ****************************************/
	public class LoginService {
		private login_interface dao;

		public LoginService() {
			dao = new loginDAO();
		}

		public List<LoginVO> selectlogin(String p_user_name, String p_password) {
			return dao.loginDB(p_user_name, p_password);
		}

		public Boolean checkuser(String p_user_name) {
			return dao.checkuser(p_user_name);
		}
	}

	/*************************** 操作資料庫 ****************************************/
	class loginDAO implements login_interface {
		// 會使用到的Stored procedure
		private static final String sp_login = "call sp_login(?,?)";
		private static final String sp_checkuser = "call sp_checkuser(?,?)";
		private final String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL");
//				+ "?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		private final String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		private final String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");

		@Override
		public List<LoginVO> loginDB(String p_user_name, String p_password) {
			List<LoginVO> list = new ArrayList<LoginVO>();
			LoginVO LoginVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_login);
				pstmt.setString(1, p_user_name);
				pstmt.setString(2, p_password);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					LoginVO = new LoginVO();
					LoginVO.setUser_id(rs.getString("uid"));
					LoginVO.setGroup_id(rs.getString("gid"));
					LoginVO.setUser_name(rs.getString("user"));
					
//					logger.info("setUser_id: " + rs.getString("uid"));
//					logger.info("setGroup_id: " + rs.getString("gid"));
//					logger.info("setUser_name: " + rs.getString("user"));
					list.add(LoginVO);
				}
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
				// Clean up JDBC resources
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace(System.err);
					}
				}
			}
			return list;

		}

		@Override
		public Boolean checkuser(String p_user_name) {
			Connection con = null;
			CallableStatement cs = null;
			Boolean rs = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				cs = con.prepareCall(sp_checkuser);
				cs.registerOutParameter(2, Types.BOOLEAN);
				cs.setString(1, p_user_name);
				cs.execute();
				rs = cs.getBoolean(2);
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
				// Clean up JDBC resources
			} finally {
				if (cs != null) {
					try {
						cs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace(System.err);
					}
				}
			}
			return rs;
		}
	}
}