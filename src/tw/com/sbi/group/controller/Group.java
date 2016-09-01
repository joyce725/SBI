package tw.com.sbi.group.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;

import tw.com.sbi.login.controller.Login.LoginService;
import tw.com.sbi.login.controller.Login.LoginVO;

public class Group extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LogManager.getLogger(Group.class);

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.debug("Group doPost");
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		String action = request.getParameter("action");

		GroupService groupService = null;
		Gson gson = null;
		
		if ("getGroupAll".equals(action)) {
			groupService = new GroupService();
			List<GroupBean> list = groupService.getGroupAllDB();
			gson = new Gson();
			String jsonStrList = gson.toJson(list);
			logger.debug("getGroupAll" + jsonStrList);
			response.getWriter().write(jsonStrList);
		}
	}

	/************************* 對應資料庫表格格式 **************************************/
	@SuppressWarnings("serial")
	public class GroupBean implements java.io.Serializable {

		private String group_id;
		private String group_name;
		
		public String getGroup_id() {
			return group_id;
		}
		public void setGroup_id(String group_id) {
			this.group_id = group_id;
		}
		public String getGroup_name() {
			return group_name;
		}
		public void setGroup_name(String group_name) {
			this.group_name = group_name;
		}
	}

	/*************************** 制定規章方法 ****************************************/

	interface Group_interface {
		public List<GroupBean> getGroupAllDB();
	}
	
	/*************************** 處理業務邏輯 ****************************************/
	public class GroupService {
		private Group_interface dao;

		public GroupService() {
			dao = new GroupDAO();
		}

		public List<GroupBean> getGroupAllDB() {
			return dao.getGroupAllDB();
		}
	}
	
	/*************************** 操作資料庫 ****************************************/
	class GroupDAO implements Group_interface {
		// 會使用到的Stored procedure
		private static final String sp_getGroupAll = "call sp_getGroupAll";
		private final String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL");
		private final String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		private final String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");

		@Override
		public List<GroupBean> getGroupAllDB() {
			List<GroupBean> list = new ArrayList<GroupBean>();
			GroupBean groupBean = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_getGroupAll);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					groupBean = new GroupBean();
					groupBean.setGroup_id(rs.getString("group_id"));
					groupBean.setGroup_name(rs.getString("group_name"));
					
					list.add(groupBean);
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
	}
}
