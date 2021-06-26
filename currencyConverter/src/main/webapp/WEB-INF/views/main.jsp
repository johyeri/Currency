<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>환율 계산</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="resources/js/bootstrap.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- jQuery -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="resources/js/currencyCal.js"></script>
</head>
<body>
	<div class="container">
		<div class="wrap">
			<h1>환율 계산</h1>
			<div class="form-group">
				<h4>송금국가: 미국(USD)</h4>
				<h4>수취국가:
					<select id="selectCountry">
						<option selected title="USDKRW">한국(KRW)</option>
						<option title="USDJPY">일본(JPY)</option>
						<option title="USDPHP">태국(PHP)</option>
					</select> 
				</h4>
			</div>
			<div class="form-group">
				<h4>환율: </h4>
				<a class="exchangeResult"></a> 
			</div>
			<div class="form-group">
				<h4>송금액:
					<input type="number" id="remittanceAmount" name="remittanceAmount"> USD
				</h4>
			</div>
			<br>
			<div class="submit-btn">
				<button type="button" id="submitBtn">Submit</button>
			</div>
			<div class="form-group row">
				<a id="calResult"></a>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			currencyImport();
			//국가선택
			$("#country").change(function() {
				currencyImport();
				$("#calResult").empty();
			});
			
			//송금액입력
			$("#remittanceAmount").on("keyup", function() {
				if(e.which == 13) {
					chkRemittance();
				}
			});
			
			//submit버튼
			$("#submitBtn").on("click", function() {
				chkRemittance();
			});
		});
		
		//API로 금액 불러오기
		function currencyImport() {
			var selectedCurrency = $("selectCountry option:selected").attr("value");
			$.ajax({
				url : "/currencyLive.do",
				type : "get",
				async : false,
				success : function(data, status) {
					$.each(data, function(key, value) {
						if(selectedCurrency === key) {
							exchangeRate = value.toFixed(2); //소수점 둘 째 자리
							$("#selectCountry option:selected").val(value);
							$(".exchangeResult").empty();
							$(".exchangeResult").append("환율: " + numberComma(exchangeRate));
							currency(key);
						}
					});
				},
				error: function(e) {
					alert(e.responseText);
				}
			})
		}
			
			
	</script>
</body>
</html>
