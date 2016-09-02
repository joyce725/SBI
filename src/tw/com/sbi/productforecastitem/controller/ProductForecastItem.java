package tw.com.sbi.productforecastitem.controller;

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

import tw.com.sbi.productforecast.controller.productForecast.ProductForecastBean;
import tw.com.sbi.productforecast.controller.productForecast.ProductForecastService;

public class ProductForecastItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Logger logger = LogManager.getLogger(ProductForecastItem.class);
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.debug("product forecast item doPost.");
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		ProductForecastItemService productForecastItemService = null;
		
		String action = request.getParameter("action");
		
		if ("getGroupAndKind".equals(action)) {
			/*************************** 1.接收請求參數 **************************************/
			String group_id = request.getParameter("group_id");
			String item_kind = request.getParameter("item_kind");
			
			logger.debug("group_id:" + group_id);
			logger.debug("item_kind:" + item_kind);
			
			productForecastItemService = new ProductForecastItemService();
			List<ProductForecastItemBean> productForecastItemList = productForecastItemService.selectByGroupAndKind(group_id, item_kind);
			
			List<ProductForecastBean> list = new ArrayList<ProductForecastBean>();
			Gson gson = new Gson();
			String jsonStrList = gson.toJson(productForecastItemList);
			logger.debug("jsonStrList:" + jsonStrList);
			response.getWriter().write(jsonStrList);
			
		}
	}
	
	/************************* 對應資料庫表格格式 **************************************/
	@SuppressWarnings("serial")
	public class ProductForecastItemBean implements java.io.Serializable {

		private String item_id;
		private String group_id;
		private String item_kind;
		private String item_name;
		
		public String getItem_id() {
			return item_id;
		}
		public void setItem_id(String item_id) {
			this.item_id = item_id;
		}
		public String getGroup_id() {
			return group_id;
		}
		public void setGroup_id(String group_id) {
			this.group_id = group_id;
		}
		public String getItem_kind() {
			return item_kind;
		}
		public void setItem_kind(String item_kind) {
			this.item_kind = item_kind;
		}
		public String getItem_name() {
			return item_name;
		}
		public void setItem_name(String item_name) {
			this.item_name = item_name;
		}
	}

	/*************************** 制定規章方法 ****************************************/
	interface productForecastItem_interface {
//		public String insertDB(ProductForecastBean productForecastBean);
//
//		public void updateDB(ProductForecastBean productForecastBean);
//
//		public void deleteDB(String product_id, String user_id);
		
		public List<ProductForecastItemBean> selectByGroupAndKind(String group_id, String item_kind);
	}

	/*************************** 處理業務邏輯 ****************************************/
	public class ProductForecastItemService {
		private productForecastItem_interface dao;

		public ProductForecastItemService() {
			dao = new ProductForecastItemDAO();
		}
		
		public List<ProductForecastItemBean> selectByGroupAndKind(String group_id, String item_kind) {
			return dao.selectByGroupAndKind(group_id, item_kind);
		}
	
	}

	/*************************** 操作資料庫 ****************************************/
	class ProductForecastItemDAO implements productForecastItem_interface {
		private final String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL")
				+ "?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		private final String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		private final String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");

		// 會使用到的Stored procedure
		private static final String sp_select_product_forecast_by_group_kind = "call sp_select_product_forecast_by_group_kind(?, ?)";
				
		@Override
		public List<ProductForecastItemBean> selectByGroupAndKind(String group_id, String item_kind) {
			List<ProductForecastItemBean> list = new ArrayList<ProductForecastItemBean>();
			ProductForecastItemBean productForecastItemBean = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_select_product_forecast_by_group_kind);
				pstmt.setString(1, group_id);
				pstmt.setString(2, item_kind);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					productForecastItemBean = new ProductForecastItemBean();
					
					productForecastItemBean.setGroup_id(rs.getString("group_id"));
					productForecastItemBean.setItem_id(rs.getString("item_id"));
					productForecastItemBean.setItem_kind(rs.getString("item_kind"));
					productForecastItemBean.setItem_name(rs.getString("item_name"));
					
					list.add(productForecastItemBean); // Store the row in the list
				}
				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
				
			} finally {
				// Clean up JDBC resources
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
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
