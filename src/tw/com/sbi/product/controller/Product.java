package tw.com.sbi.product.controller;

import java.io.IOException;
import java.sql.CallableStatement;
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

import tw.com.sbi.vo.ProductVO;

public class Product extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Logger logger = LogManager.getLogger(Product.class);
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		ProductService productService = null;

		String groupId = request.getSession().getAttribute("group_id").toString();
		String action = request.getParameter("action");
		
		if ("selectAll".equals(action)) {
			try {								
				productService = new ProductService();
				List<ProductVO> list = productService.selectByGroupId(groupId);
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("insert".equals(action)) {
			try {
				String productSpec = request.getParameter("product_spec");
				String photo = request.getParameter("photo");
				String seed = request.getParameter("seed");
								
				productService = new ProductService();
				List<ProductVO> list = productService.addProduct(groupId, productSpec, photo, seed);
			
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("update".equals(action)) {
			logger.debug("enter product update method");
			try {				
				String productId = request.getParameter("product_id");
				String productSpec = request.getParameter("product_spec");
				String photo = request.getParameter("photo");
				String seed = request.getParameter("seed");
				
				productService = new ProductService();
				
				List<ProductVO> list = productService.updateProduct(groupId, productId, productSpec, photo, seed);

				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				logger.debug("jsonStrList: " + jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("delete".equals(action)) {
			try {
				String productId = request.getParameter("product_id");
				
				productService = new ProductService();
				
				List<ProductVO> list = productService.deleteProduct(groupId, productId);

				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/*************************** 處理業務邏輯 ****************************************/
	public class ProductService {
		private product_interface dao;

		public ProductService() {
			dao = new ProductDAO();
		}

		public List<ProductVO> selectByGroupId(String groupId) {
			return dao.selectByGroupId(groupId);
		}
		
		public List<ProductVO> addProduct(String groupId, String productSpec, String photo, String seed) {
			ProductVO productVO = new ProductVO();
			
			productVO.setGroup_id(groupId);
			productVO.setProduct_spec(productSpec);
			productVO.setPhoto(photo);
			productVO.setSeed(seed);

			dao.insertDB(productVO);
			return dao.selectByGroupId(groupId);
		}
		
		public List<ProductVO> updateProduct(String groupId, String productId, String productSpec, String photo, String seed){
			ProductVO productVO = new ProductVO();

			productVO.setGroup_id(groupId);
			productVO.setProduct_id(productId);
			productVO.setProduct_spec(productSpec);
			productVO.setPhoto(photo);
			productVO.setSeed(seed);
			
			logger.debug("groupId: " + productVO.getGroup_id());
			logger.debug("productId: " + productVO.getProduct_id());
			logger.debug("productSpec: " + productVO.getProduct_spec());
			logger.debug("photo: " + productVO.getPhoto());
			logger.debug("seed: " + productVO.getSeed());
			
			dao.updateDB(productVO);
			return dao.selectByGroupId(groupId);
		}
		
		public List<ProductVO> deleteProduct(String groupId, String productId){
			dao.deleteDB(groupId, productId);
			return dao.selectByGroupId(groupId);
		}
	}
	
	/*************************** 制定規章方法 ****************************************/
	interface product_interface {
		public void insertDB(ProductVO productVO);

		public void updateDB(ProductVO productVO);

		public void deleteDB(String groupId, String productId);
		
		public List<ProductVO> selectByGroupId(String groupId);
	}
	
	/*************************** 操作資料庫 ****************************************/
	class ProductDAO implements product_interface {
		private final String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL")
				+ "?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		private final String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		private final String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");

		// 會使用到的Stored procedure
		private static final String sp_get_product_by_group = "call sp_get_product_by_group(?)";
		private static final String sp_insert_product = "call sp_insert_product(?,?,?,?)";
		private static final String sp_update_product = "call sp_update_product(?,?,?,?,?)";
		private static final String sp_delete_product = "call sp_delete_product(?,?)";

		@Override
		public List<ProductVO> selectByGroupId(String groupId) {
			List<ProductVO> list = new ArrayList<ProductVO>();
			ProductVO productVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_get_product_by_group);
				pstmt.setString(1, groupId);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					productVO = new ProductVO();
					
					productVO.setGroup_id(groupId);
					productVO.setPhoto(rs.getString("photo"));
					productVO.setProduct_id(rs.getString("product_id"));
					productVO.setProduct_spec(rs.getString("product_spec"));
					productVO.setSeed(rs.getString("seed"));
					
					list.add(productVO); // Store the row in the list
				}				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
				// Clean up JDBC resources
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

		@Override
		public void insertDB(ProductVO productVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				
				CallableStatement cs = null;
				cs = con.prepareCall(sp_insert_product);

				cs.setString(1, productVO.getGroup_id());
				cs.setString(2, productVO.getProduct_spec());
				cs.setString(3, productVO.getPhoto());
				cs.setString(4, productVO.getSeed());

				cs.execute();
			
			} catch (SQLException se) {
				// Handle any SQL errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} finally {
				// Clean up JDBC resources
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
		}
		
		@Override
		public void updateDB(ProductVO productVO) {
			logger.debug("enter updateDB method");
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				
				CallableStatement cs = null;
				cs = con.prepareCall(sp_update_product);

				cs.setString(1, productVO.getGroup_id());
				cs.setString(2, productVO.getProduct_id());
				cs.setString(3, productVO.getProduct_spec());
				cs.setString(4, productVO.getPhoto());
				cs.setString(5, productVO.getSeed());

				cs.execute();
			
			} catch (SQLException se) {
				// Handle any SQL errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} finally {
				// Clean up JDBC resources
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
		}
		
		@Override
		public void deleteDB(String groupId, String productId) {
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				
				CallableStatement cs = null;
				cs = con.prepareCall(sp_delete_product);

				cs.setString(1, groupId);
				cs.setString(2, productId);

				cs.execute();
			
			} catch (SQLException se) {
				// Handle any SQL errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} finally {
				// Clean up JDBC resources
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
		}		
	}

}