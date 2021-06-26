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
</head>
<body>
	<div class="container">
		<div class="wrap">
			<h1>환율 계산</h1>
			<div class="form-group">
				<h4>송금국가: 미국(USD)</h4>
				<h4>수취국가:
					<select id="selectCountry">
						<option title="USDKRW" selected>한국(KRW)</option>
						<option title="USDJPY">일본(JPY)</option>
						<option title="USDPHP">태국(PHP)</option>
					</select> 
				</h4>
			</div>
			<div class="form-group">
				<h4 class="exchangeResult"></h4>
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
			<br>
			<div class="form-group">
				<h3 id="calResult"></h3>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			//켬과 동시에 선택된 환율 나타나도록 하기
			currencyImport();
			
			//국가 변경 시 환율 변경되도록 하기
			$("#selectCountry").change(function() {
				currencyImport();
				$("#calResult").empty(); //계산된 금액은 비울 것
			});
			
			//송금액입력
			$("#remittanceAmount").on("keyup", function() {
				if(event.which === 13) { //keyCode: 13=enter
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
			var selectedCurrency = $("#selectCountry option:selected").attr("title");
			console.log(selectedCurrency);
			$.ajax({
				url : "/currencyLive.do",
				type : "get",
				async : false,
				success : function(data, status) {
					$.each(data, function(key, value) {
						var exchange = (" " + key.slice(3,6) + '/USD');
						if(selectedCurrency === key) {
							exchangeRate = value.toFixed(2); //소수점 두번째 자리
							$("#selectCountry option:selected").val(value);
							$(".exchangeResult").empty();
							$(".exchangeResult").append("환율: " + insertComma(exchangeRate)).append(exchange);
						}
					});
				},
				error: function(e) {
					alert("controller 연결실패");
				}
			})
		}
		
		//계산값 나타내기
		function calculate() {
			var exchangeName = ($("#selectCountry option:selected").attr("title")).slice(3,6);
			var total = (exchangeRate * $("#remittanceAmount").val()).toFixed(2);
			total = insertComma(total);
			$("#calResult").empty();
			$("#calResult").append("수취금액은 " + total + " " + exchangeName + " 입니다.");
		}

		//금액에 대한 유효성검사
		function chkRemittance() {
			var remittanceAmount = $("#remittanceAmount").val();
			if (remittanceAmount > 0 && remittanceAmount <= 10000 && !isNaN(remittanceAmount)) {
				calculate();
			} else {
				alert("송금액이 바르지 않습니다.");
				$("#remittanceAmount").val(""); //값 초기화
			}
		}

		// 세 자리수 당 콤마 넣기
		function insertComma(number) {
			var split = number.toString().split(".");
			split[0] = split[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			return split.join(".");
		}
			
			
	</script>
</body>
</html>
