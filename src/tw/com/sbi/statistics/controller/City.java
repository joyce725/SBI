package tw.com.sbi.statistics.controller;

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

import tw.com.sbi.vo.CityVO;

public class City extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final Logger logger = LogManager.getLogger(City.class);

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		CityService cityService = null;

		String action = request.getParameter("action");
		
		logger.debug("Action: " + action);

		if ("getCity".equals(action)) {
			try {								
				cityService = new CityService();
				List<CityVO> list = cityService.selectCity();
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("getStructure".equals(action)) {
			try {
				String city = request.getParameter("city");
				
				CityVO paramVO = new CityVO();
				paramVO.setCity(city);
				
				cityService = new CityService();
				List<CityVO> list = cityService.selectStructure(paramVO);
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("getDimensions".equals(action)) {
			try {
				String city = request.getParameter("city");
				String structure = request.getParameter("structure");
				
				CityVO paramVO = new CityVO();
				paramVO.setCity(city);
				paramVO.setStructure(structure);
				
				cityService = new CityService();
				List<CityVO> list = cityService.selectDimensions(paramVO);
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("getTarget".equals(action)) {
			try {
				String city = request.getParameter("city");
				String structure = request.getParameter("structure");
				String dimensions = request.getParameter("dimensions");
				
				CityVO paramVO = new CityVO();
				paramVO.setCity(city);
				paramVO.setStructure(structure);
				paramVO.setDimensions(dimensions);
				
				cityService = new CityService();
				List<CityVO> list = cityService.selectTarget(paramVO);
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("getSecondTarget".equals(action)) {
			try {
				String city = request.getParameter("city");
				String structure = request.getParameter("structure");
				String dimensions = request.getParameter("dimensions");
				String target = request.getParameter("target");
				
				CityVO paramVO = new CityVO();
				paramVO.setCity(city);
				paramVO.setStructure(structure);
				paramVO.setDimensions(dimensions);
				paramVO.setTarget(target);
				
				cityService = new CityService();
				List<CityVO> list = cityService.selectSecondTarget(paramVO);
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("getType".equals(action)) {
			try {
				String city = request.getParameter("city");
				String structure = request.getParameter("structure");
				String dimensions = request.getParameter("dimensions");
				String target = request.getParameter("target");
				String secondTarget = request.getParameter("second_target");
				
				CityVO paramVO = new CityVO();
				paramVO.setCity(city);
				paramVO.setStructure(structure);
				paramVO.setDimensions(dimensions);
				paramVO.setTarget(target);
				paramVO.setSecondTarget(secondTarget);
				
				cityService = new CityService();
				List<CityVO> list = cityService.selectType(paramVO);
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if ("getChart".equals(action)) {
			try {
				String city = request.getParameter("city");
				String structure = request.getParameter("structure");
				String dimensions = request.getParameter("dimensions");
				String target = request.getParameter("target");
				String secondTarget = request.getParameter("second_target");
				String type = request.getParameter("type");
				
				CityVO paramVO = new CityVO();
				paramVO.setCity(city);
				paramVO.setStructure(structure);
				paramVO.setDimensions(dimensions);
				paramVO.setTarget(target);
				paramVO.setSecondTarget(secondTarget);
				paramVO.setType(type);
				
				logger.debug("City :" + city);
				logger.debug("Structure :" + structure);
				logger.debug("Dimensions :" + dimensions);
				logger.debug("Target :" + target);
				logger.debug("Second Target :" + secondTarget);
				logger.debug("Type :" + type);
				
				cityService = new CityService();
				List<CityVO> list = cityService.selectChart(paramVO);
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				response.getWriter().write(jsonStrList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/*************************** 處理業務邏輯 ****************************************/
	public class CityService {
		private city_interface dao;

		public CityService() {
			dao = new CityDAO();
		}
		
		public List<CityVO> selectCity() {
			return dao.selectCity();
		}

		public List<CityVO> selectStructure(CityVO paramVO) {
			return dao.selectStructure(paramVO);
		}

		public List<CityVO> selectDimensions(CityVO paramVO) {
			return dao.selectDimensions(paramVO);
		}

		public List<CityVO> selectTarget(CityVO paramVO) {
			return dao.selectTarget(paramVO);
		}

		public List<CityVO> selectSecondTarget(CityVO paramVO) {
			return dao.selectSecondTarget(paramVO);
		}

		public List<CityVO> selectType(CityVO paramVO) {
			return dao.selectType(paramVO);
		}

		public List<CityVO> selectChart(CityVO paramVO) {
			return dao.selectChart(paramVO);
		}

	}
	
	/*************************** 制定規章方法 ****************************************/
	interface city_interface {
		public List<CityVO> selectCity();
		public List<CityVO> selectStructure(CityVO paramVO);
		public List<CityVO> selectDimensions(CityVO paramVO);
		public List<CityVO> selectTarget(CityVO paramVO);
		public List<CityVO> selectSecondTarget(CityVO paramVO);
		public List<CityVO> selectType(CityVO paramVO);
		public List<CityVO> selectChart(CityVO paramVO);
		
	}
	
	/*************************** 操作資料庫 ****************************************/
	class CityDAO implements city_interface {
		private final String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL")
				+ "?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		private final String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		private final String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");
		private final String wsPath = getServletConfig().getServletContext().getInitParameter("pythonwebservice");

		// 會使用到的Stored procedure
		private static final String sp_STAT_City = "call sp_STAT_City()";
		private static final String sp_STAT_City_Structure = "call sp_STAT_City_Structure(?)";
		private static final String sp_STAT_City_Dimensions = "call sp_STAT_City_Dimensions(?,?)";
		private static final String sp_STAT_City_Target = "call sp_STAT_City_Target(?,?,?)";
		private static final String sp_STAT_City_SecondTarget = "call sp_STAT_City_SecondTarget(?,?,?,?)";
		private static final String sp_STAT_City_TYPE = "call sp_STAT_City_TYPE(?,?,?,?,?)";
		private static final String sp_STAT_City_Chart = "call sp_STAT_City_Chart(?,?,?,?,?,?)";

		@Override
		public List<CityVO> selectCity() {
			List<CityVO> list = new ArrayList<CityVO>();
			CityVO cityVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_STAT_City);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					cityVO = new CityVO();
					
					cityVO.setCity(rs.getString("City") == null?"":rs.getString("City"));
					
					list.add(cityVO); // Store the row in the list
				}				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
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
		public List<CityVO> selectStructure(CityVO paramVO) {
			List<CityVO> list = new ArrayList<CityVO>();
			CityVO cityVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_STAT_City_Structure);
				pstmt.setString(1, paramVO.getCity());
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					cityVO = new CityVO();
					
					cityVO.setStructure(rs.getString("Structure") == null?"":rs.getString("Structure"));
					
					list.add(cityVO); // Store the row in the list
				}				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
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
		public List<CityVO> selectDimensions(CityVO paramVO) {
			List<CityVO> list = new ArrayList<CityVO>();
			CityVO cityVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_STAT_City_Dimensions);
				pstmt.setString(1, paramVO.getCity());
				pstmt.setString(2, paramVO.getStructure());
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					cityVO = new CityVO();
					
					cityVO.setDimensions(rs.getString("Dimensions") == null?"":rs.getString("Dimensions"));
					
					list.add(cityVO); // Store the row in the list
				}				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
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
		public List<CityVO> selectTarget(CityVO paramVO) {
			List<CityVO> list = new ArrayList<CityVO>();
			CityVO cityVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_STAT_City_Target);
				pstmt.setString(1, paramVO.getCity());
				pstmt.setString(2, paramVO.getStructure());
				pstmt.setString(3, paramVO.getDimensions());
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					cityVO = new CityVO();
					
					cityVO.setTarget(rs.getString("Target") == null?"":rs.getString("Target"));
					
					list.add(cityVO); // Store the row in the list
				}				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
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
		public List<CityVO> selectSecondTarget(CityVO paramVO) {
			List<CityVO> list = new ArrayList<CityVO>();
			CityVO cityVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_STAT_City_SecondTarget);
				pstmt.setString(1, paramVO.getCity());
				pstmt.setString(2, paramVO.getStructure());
				pstmt.setString(3, paramVO.getDimensions());
				pstmt.setString(4, paramVO.getTarget());
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					cityVO = new CityVO();
					
					cityVO.setSecondTarget(rs.getString("Second_Target") == null?"":rs.getString("Second_Target"));
					
					list.add(cityVO); // Store the row in the list
				}				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
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
		public List<CityVO> selectType(CityVO paramVO) {
			List<CityVO> list = new ArrayList<CityVO>();
			CityVO cityVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_STAT_City_TYPE);
				pstmt.setString(1, paramVO.getCity());
				pstmt.setString(2, paramVO.getStructure());
				pstmt.setString(3, paramVO.getDimensions());
				pstmt.setString(4, paramVO.getTarget());
				pstmt.setString(5, paramVO.getSecondTarget());
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					cityVO = new CityVO();
					
					cityVO.setType(rs.getString("TYPE") == null?"":rs.getString("TYPE"));
					
					list.add(cityVO); // Store the row in the list
				}				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
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
		public List<CityVO> selectChart(CityVO paramVO) {
			List<CityVO> list = new ArrayList<CityVO>();
			CityVO cityVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(sp_STAT_City_Chart);
				pstmt.setString(1, paramVO.getCity());
				pstmt.setString(2, paramVO.getStructure());
				pstmt.setString(3, paramVO.getDimensions());
				pstmt.setString(4, paramVO.getTarget());
				pstmt.setString(5, paramVO.getSecondTarget());
				pstmt.setString(6, paramVO.getType());
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					cityVO = new CityVO();
					
					cityVO.setSecondTarget(rs.getString("Second_Target") == null?"":rs.getString("Second_Target"));
					cityVO.setType(rs.getString("Type") == null?"":rs.getString("Type"));
					cityVO.setData(rs.getString("Data") == null?"":rs.getString("Data"));
					
					list.add(cityVO); // Store the row in the list
				}				
			} catch (SQLException se) {
				// Handle any driver errors
				throw new RuntimeException("A database error occured. " + se.getMessage());
			} catch (ClassNotFoundException cnfe) {
				throw new RuntimeException("A database error occured. " + cnfe.getMessage());
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
