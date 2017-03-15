package tw.com.sbi.scenariojob.controller;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import tw.com.sbi.productforecast.controller.ProductForecast.ProductForecastBean;
import tw.com.sbi.productforecastpoint.controller.ProductForecastPoint.ProductForecastPointBean;
import tw.com.sbi.productforecastpoint.controller.ProductForecastPoint.ProductForecastPointService;
import tw.com.sbi.vo.ScenarioJobVO;
import tw.com.sbi.vo.ScenarioResultVO;

public class ScenarioJob extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final Logger logger = LogManager.getLogger(ScenarioJob.class);

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		ScenarioService caseService = null;

		String action = request.getParameter("action");
		
		logger.debug("Action: " + action);
		
		if ("getJobInfo".equals(action)) {
			try {
				String group_id = request.getSession().getAttribute("group_id").toString();
				caseService = new ScenarioService();
				List<ScenarioJobVO> list = caseService.get_all_job(group_id);
				
				Gson gson = new Gson();
				String jsonStrList = gson.toJson(list);
				logger.debug(jsonStrList);
				response.getWriter().write(jsonStrList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if("select_all_scenario".equals(action)){
			try {
				caseService = new ScenarioService();
				List<ScenarioJobVO> list = caseService.select_all_scenario();
				String jsonStrList = new Gson().toJson(list);
				logger.debug(jsonStrList);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if("insert_job".equals(action)){
			try {
				caseService = new ScenarioService();
				String group_id = request.getSession().getAttribute("group_id").toString();
				String scenario_id = request.getParameter("scenario_id");
				String job_name = request.getParameter("job_name");
				logger.debug("scenario_id:" + scenario_id);
				logger.debug("job_name:" + job_name);
				
				caseService.insert_job(group_id,scenario_id,job_name);
				List<ScenarioJobVO> list = caseService.get_all_job(group_id);
				String jsonStrList = new Gson().toJson(list);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if("delete_job".equals(action)){
			try {
				caseService = new ScenarioService();
				String group_id = request.getSession().getAttribute("group_id").toString();
				String job_id = request.getParameter("job_id");
				logger.debug("job_id:" + job_id);
				
				caseService.delete_job(job_id);
				List<ScenarioJobVO> list = caseService.get_all_job(group_id);
				String jsonStrList = new Gson().toJson(list);
				
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if("update_job".equals(action)){
			try {
				caseService = new ScenarioService();
				String group_id = request.getSession().getAttribute("group_id").toString();
				String job_id = request.getParameter("job_id");
				String job_name = request.getParameter("job_name");
				logger.debug("job_id:" + job_id);
				logger.debug("job_name:" + job_name);
				
				caseService.update_job(job_id,job_name);
				
				List<ScenarioJobVO> list = caseService.get_all_job(group_id);
				String jsonStrList = new Gson().toJson(list);
				response.getWriter().write(jsonStrList);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if("click_next_step".equals(action)){
			HttpSession session = request.getSession(true);
			String scenario_job_id = request.getParameter("scenario_job_id");
			String scenario_job_page = request.getParameter("scenario_job_page");
			session.setAttribute("scenario_job_id", scenario_job_id);
			session.setAttribute("scenario_job_page", scenario_job_page);
			System.out.println("session: "+scenario_job_id+" ### "+scenario_job_page);
			response.getWriter().write("");
			return;
		}else if("set_scenario_result".equals(action)){
			String group_id = request.getSession().getAttribute("group_id").toString();
			String job_id = request.getParameter("job_id");
			String category = request.getParameter("category");
			String result = request.getParameter("result");
			logger.debug("job_id:" + job_id);
			logger.debug("category:" + category);
			logger.debug("result:" + result);
			caseService = new ScenarioService();
			//List<ScenarioResultVO> result_list =  caseScenarioService.dealing_job_load_result(job_id);
			//ScenarioResultVO a = new ScenarioResultVO(result, result, result, result, result, result);
			//result_list.add(e);
			caseService.dealing_job_save_result(group_id,job_id,category,result);
			
		}
	
	}
	
	/*************************** 處理業務邏輯 ****************************************/
	public class ScenarioService {
		private case_interface dao;

		public ScenarioService() {
			dao = new ScenarioDAO();
		}
		public List<ScenarioJobVO> get_all_job(String group_id) {
			return dao.get_all_job(group_id);
		}
		public void insert_job(String group_id ,String scenario_id, String job_name) {
			dao.insert_job(group_id , scenario_id,job_name);
		}
		public void update_job(String job_id, String job_name) {
			dao.update_job(job_id,job_name);
		}
		public void delete_job(String job_id) {
			dao.delete_job(job_id);
		}
		
		public List<ScenarioJobVO> select_all_scenario(){
			return dao.select_all_scenario();
		}
		public void dealing_job_save_result(String group_id,String job_id, String category, String result){
			dao.dealing_job_save_result(group_id,job_id,category,result);
		}
		
		//######################################
		//######################################
		//######################################
		
	}

	/*************************** 制定規章方法 ****************************************/
	interface case_interface {
		public List<ScenarioJobVO> get_all_job(String group_id);
		public void insert_job(String group_id, String scenario_id, String job_name);
		public void update_job(String job_id, String job_name);
		public void delete_job(String job_id);
		public List<ScenarioJobVO> select_all_scenario();
		public void dealing_job_save_result(String group_id,String job_id, String category, String result);
		//######################################
		//######################################
		//######################################
		
		
//		public List<ScenarioJobVO> selectCity(String country);
//		public List<ScenarioJobVO> selectBD(String city);
//		
//		public String insertCase(ScenarioJobVO caseVO);
	}
	
	/*************************** 操作資料庫 ****************************************/
	class ScenarioDAO implements case_interface {
		private final String dbURL = getServletConfig().getServletContext().getInitParameter("dbURL")
				+ "?useUnicode=true&characterEncoding=utf-8&useSSL=false";
		private final String dbUserName = getServletConfig().getServletContext().getInitParameter("dbUserName");
		private final String dbPassword = getServletConfig().getServletContext().getInitParameter("dbPassword");
		
		// 會使用到的Stored procedure
		private static final String select_job_info = "SELECT * FROM tb_scenario_job "
				+ " LEFT JOIN tb_scenario_flow this ON tb_scenario_job.flow_id = this.flow_id "
				+ " LEFT JOIN tb_scenario ON this.scenario_id = tb_scenario.scenario_id "
				+ " LEFT JOIN tb_scenario_flow next ON next.scenario_id = this.scenario_id AND next.flow_seq = this.flow_seq +1 "
				+ " WHERE tb_scenario_job.group_id = ? ORDER BY job_time ASC";
		private static final String max_seq = "SELECT MAX( flow_seq ) max_seq FROM tb_scenario_flow WHERE scenario_id = ? " ;
		private static final String scenario_job_insert = "call sp_insert_scenario_job (?,?,?)";
		private static final String scenario_job_update = "UPDATE tb_scenario_job SET job_name = ? where job_id = ? ";
		private static final String scenario_job_delete = "DELETE FROM tb_scenario_job WHERE job_id = ?";
		
		private static final String update_result ="update tb_scenario_job set result = ? where job_id = ?";
		private static final String select_all_scenario = "select * from tb_scenario";
		
		@Override
		public List<ScenarioJobVO> get_all_job(String group_id){
			List<ScenarioJobVO> list = new ArrayList<ScenarioJobVO>();
			ScenarioJobVO scenarioJob = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(select_job_info);
				pstmt.setString(1, group_id);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					scenarioJob = new ScenarioJobVO();
					scenarioJob.setId(null2Str(rs.getString("id")));
					scenarioJob.setJob_id(null2Str(rs.getString("job_id")));
					scenarioJob.setJob_name(null2Str(rs.getString("job_name")));
					scenarioJob.setGroup_id(null2Str(rs.getString("group_id")));
					scenarioJob.setFlow_id(null2Str(rs.getString("flow_id")));
					scenarioJob.setFlow_name(null2Str(rs.getString("this.flow_name")));
					scenarioJob.setFlow_function(null2Str(rs.getString("this.flow_function")));
					
					scenarioJob.setScenario_id(null2Str(rs.getString("this.scenario_id")));
					scenarioJob.setScenario_name(null2Str(rs.getString("scenario_name")));
					scenarioJob.setPage(null2Str(rs.getString("this.page")));
					scenarioJob.setFlow_seq(null2Str(rs.getString("this.flow_seq")));
					scenarioJob.setJob_time(null2Str(rs.getString("job_time")));
					scenarioJob.setResult(null2Str(rs.getString("result")));
					scenarioJob.setFinished(null2Str(rs.getString("finished")));
					scenarioJob.setFinish_time(null2Str(rs.getString("finish_time")));
					scenarioJob.setNext_flow_id(null2Str(rs.getString("next.flow_id")));
					scenarioJob.setNext_flow_name(null2Str(rs.getString("next.flow_name")));
					scenarioJob.setNext_flow_page(null2Str(rs.getString("next.page")));
					scenarioJob.setNext_flow_explanation(null2Str(rs.getString("next.explanation")));
					scenarioJob.setNext_flow_guide(null2Str(rs.getString("next.guide")));
					
					scenarioJob.setMax_flow_seq(
							get_max_seq(scenarioJob.getScenario_id())
					);
					list.add(scenarioJob);
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
		public void insert_job(String group_id, String scenario_id, String job_name){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(scenario_job_insert);
//				System.out.println(group_id+"####"+scenario_id+"####"+job_name);
				pstmt.setString(1, group_id);
				pstmt.setString(2, scenario_id);
				pstmt.setString(3, job_name);
				
				pstmt.executeUpdate();
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
		}
		public void update_job(String job_id, String job_name){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(scenario_job_update);
				pstmt.setString(1, job_name);
				pstmt.setString(2, job_id);
				
				pstmt.executeUpdate();
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
		}
		
		public void delete_job(String job_id){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(scenario_job_delete);
				pstmt.setString(1, job_id);
				pstmt.executeUpdate();
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
		}
		public String get_max_seq(String scenario_id){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String ret = "";
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(max_seq);
				pstmt.setString(1, scenario_id);
				rs = pstmt.executeQuery();
				while (rs.next()) {	
					ret = null2Str(rs.getString("max_seq"));
				}
				return ret;
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
		}
		public List<ScenarioJobVO> select_all_scenario(){
			List<ScenarioJobVO> list = new ArrayList<ScenarioJobVO>();
			ScenarioJobVO scenarioJobVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(select_all_scenario);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					scenarioJobVO = new ScenarioJobVO();
					scenarioJobVO.setScenario_id(null2Str(rs.getString("scenario_id")));
					scenarioJobVO.setScenario_name(null2Str(rs.getString("scenario_name")));
					list.add(scenarioJobVO);
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
		public void dealing_job_save_result(String group_id, String job_id, String category, String result){
			ScenarioResultVO new_one= new ScenarioResultVO();
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String old_result = "[]";
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(select_job_info);
				
				pstmt.setString(1, group_id);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					if(job_id.equals(null2Str(rs.getString("job_id")))){
						new_one.setScenario_name(null2Str(rs.getString("scenario_name")));
						new_one.setStep(null2Str(rs.getString("flow_seq")));
						new_one.setFlow_name(null2Str(rs.getString("this.flow_name")));
						new_one.setPage(null2Str(rs.getString("this.page")));
						new_one.setCategory(category);
						new_one.setResult(result);
						old_result=null2Str(rs.getString("result"));
					}
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
			System.out.print("1: "+new Gson().toJson(old_result));
			
			//#########################################################
			//String json_result="";
			List<ScenarioResultVO> old_json_result = new Gson().fromJson(old_result, new TypeToken<List<ScenarioResultVO>>() {}.getType());
			
			System.out.print("2: "+new Gson().toJson(old_json_result));
			old_json_result.add(new_one);
			System.out.print("3: "+new Gson().toJson(new_one));
			Gson gson = new Gson();
			String jsonStrList = gson.toJson(old_json_result);
			this.dealing_job_update_result(job_id,jsonStrList);
			
			//###########################################
			//###########################################
			//##############檢查使用起來的樣子#################
			//###########################################
			//###########################################
			
		}
		public void dealing_job_update_result(String job_id,String json_result){
//			List<ScenarioResultVO> list = new ArrayList<ScenarioResultVO>();
//			ScenarioJobVO ScenarioResultVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUserName, dbPassword);
				pstmt = con.prepareStatement(update_result);
				
				pstmt.setString(1, json_result);
				pstmt.setString(2, job_id);
				pstmt.executeUpdate();
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
		}
	}
	private String null2Str(Object object) {
		if (object instanceof Timestamp)
			return object == null ? "" : new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(object);
		return object == null ? "" : object.toString().trim();
	}

	private Integer null2Int(Object object) {
		String s = object == null ? "0" : String.valueOf(object);
		return object == null ? 0 : Integer.valueOf(s);
	}
}
