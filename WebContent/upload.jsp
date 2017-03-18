<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="import.jsp" flush="true"/>
<style>
	h2.ui-list-title {
		border-bottom: 1px solid #ccc;
		color: #307CB0;
	}
	section {
		margin-bottom: 60px;
	}
</style>
	
<script>
	function setV(){
		
		if($("#file").val()<1){
			alert("請選擇檔案");
			return false;
		}
		var i=0;
		while(!document.getElementsByName("db_name")[i].checked){
			i++;
		}
		document.getElementById("form1").action+="?db_name="+document.getElementsByName("db_name")[i].value;
		if(window.scenario_record){scenario_record("上傳資料表-產業分析資料庫","上傳 '"+$("#file").val()+"' 至"+$(document.getElementsByName("db_name")[i]).parent().text());} 
		return true;
	};
	$(function(){
		$("td").css("border","0px solid #aaa");
		$("td img").css("width","30px");	
	});
</script>
<%
	String str=(String)request.getAttribute("action");
	if(str!=null){
		if("success".equals(str)){
			out.println("<script>alert('傳輸成功');$('body').css('cursor', 'default');window.location.href = './upload.jsp';</script>");
		}else{
			out.println("<script>alert('傳輸失敗 ');$('body').css('cursor', 'default');window.location.href = './upload.jsp';</script>");
		}
	}
%>
<jsp:include page="header.jsp" flush="true"/>
	<div class="content-wrap">
		<h2 class="page-title">產業分析基礎資料庫</h2>
		<div class="search-result-wrap">
			<section>
				<h2 class="ui-list-title">選擇欲上傳資料表</h2>
				<form action="upload.do" id="form1" method="post" enctype="multipart/form-data">
					<table class="result-table">
<!-- 				<table class="formTable aCenter" style="width: 80%; margin:auto"> -->
			           	<tbody>
							<tr>
								<td><input type="radio" name="db_name" id="City" value="City" /><label for="City"><span class="form-label">城市資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityCivilCar" value="CityCivilCar" /><label for="CityCivilCar"><span class="form-label">城市民用汽車擁有量資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityConsumptionExpenditure" value="CityConsumptionExpenditure" /><label for="CityConsumptionExpenditure"><span class="form-label">城市消費支出資料表</span></label></td>
							</tr>
							<tr>						
								<td><input type="radio" name="db_name" id="CityEstateAvgSale" value="CityEstateAvgSale" /><label for="CityEstateAvgSale"><span class="form-label">城市房地產平均銷售價格資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityEstateCompletion" value="CityEstateCompletion" /><label for="CityEstateCompletion"><span class="form-label">城市房地產竣工面積資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityEstateSaleAmount" value="CityEstateSaleAmount" /><label for="CityEstateSaleAmount"><span class="form-label">城市房地產銷售額資料表</span></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="db_name" id="CityEstateSaleArea" value="CityEstateSaleArea" /><label for="CityEstateSaleArea"><span class="form-label">城市房地產銷售面積資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityGender" value="CityGender" /><label for="CityGender"><span class="form-label">城市性別人口數資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityGoodsTraffic" value="CityGoodsTraffic" /><label for="CityGoodsTraffic"><span class="form-label">城市貨運量資料表</span></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="db_name" id="CityIncome" value="CityIncome" /><label for="CityIncome"><span class="form-label">城市所得資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityPassengerTraffic" value="CityPassengerTraffic" /><label for="CityPassengerTraffic"><span class="form-label">城市客運量資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityPractitioners" value="CityPractitioners" /><label for="CityPractitioners"><span class="form-label">城市從業人員數資料表</span></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="db_name" id="CityRetailExponent" value="CityRetailExponent" /><label for="CityRetailExponent"><span class="form-label">城市商品零售價格指數資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CitySocialConsume" value="CitySocialConsume" /><label for="CitySocialConsume"><span class="form-label">城市社會消費品零售總額資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityStaff" value="CityStaff" /><label for="CityStaff"><span class="form-label">城市國有單位職工人數資料表</span></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="db_name" id="CityTertiaryIncrease" value="CityTertiaryIncrease" /><label for="CityTertiaryIncrease"><span class="form-label">城市第三產業增加趨勢資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityTertiaryIndustry" value="CityTertiaryIndustry" /><label for="CityTertiaryIndustry"><span class="form-label">城市第三產業GDP比重資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CityWholesaleRetail" value="CityWholesaleRetail" /><label for="CityWholesaleRetail"><span class="form-label">城市批發零售社會消費品零售總額資料表</span></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="db_name" id="consumer_intelligence" value="consumer_intelligence" /><label for="consumer_intelligence"><span class="form-label">消費力情報資料表</span></label></td>
								<td><input type="radio" name="db_name" id="Country" value="Country" /><label for="Country"><span class="form-label">國家資料表</span></label></td>
								<td><input type="radio" name="db_name" id="CountryAge" value="CountryAge" /><label for="CountryAge"><span class="form-label">國家年齡人口數資料表</span></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="db_name" id="CountryLaborForce" value="CountryLaborForce" /><label for="CountryLaborForce"><span class="form-label">國家勞動力結構資料表</span></label></td>
								<td><input type="radio" name="db_name" id="Gender" value="Gender" /><label for="Gender"><span class="form-label">國家性別人口數資料表</span></label></td>
								<td><input type="radio" name="db_name" id="MarketSize" value="MarketSize" /><label for="MarketSize"><span class="form-label">國家產業數據資料表</span></label></td>
							</tr>
							<tr>
								<td><input type="radio" name="db_name" id="Variables" value="Variables" /><label for="Variables"><span class="form-label">變數資料表</span></label></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
					<div style="text-align:center; margin:20px auto;">   
						<input type="file" id="file" name="file" size="40" class="ifile" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" style="display:none;" onchange="this.form.upload_name.value=this.value;"	/>
						<input type="text" id="upload_name" name="upload_name" size="40" readonly/>
						<input type="button" class="btn btn-exec btn-wide" value="開啟檔案" style="color: #fff" onclick="this.form.file.click();"> 
						<input type="submit" class="btn btn-exec btn-wide" onclick="$('body').css('cursor', 'wait');return setV();" value="檔案匯入" style="color: #fff;margin-left:20px"/>
					</div> 
				</form>
			</section>
		</div>
	</div>
<jsp:include page="footer.jsp" flush="true"/>