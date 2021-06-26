var exchangeRate;//환율
var exchangeName;//환율명(국가명만)
var exchangeNames;//환율명(USD포함)

function calculate() {
	var total = (exchangeRate * $("#remittanceAmount").val()).toFixed(2);
	total = insertComma(total);
	$("#calResult").empty();
	$("#calResult").append("수취금액은 " + total + " " + exchangeName + " 입니다.");
}

//금액에 대한 유효성검사
function chkRemittance() {
	var remittanceAmount = $("#remittanceAmount").val();
	if (remittanceAmount > 0 && remittanceAmount <= 10000) {
		calculate();
	} else {
		alert("송금액이 바르지 않습니다.");
	}
}

// KRW/USD형식으로 만들기
function currency(currency) {
	exchangeNames = currency.slice(3, 6) + " / " + currency.slice(0, 3);
	name_without_usd = currency.slice(3, 6);
	$("#current").append(exchangeNames);
}

// 세 자리수 당 콤마 넣기
function insertComma(number) {
	var split = number.toString().split(".");
	split[0] = split[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	return parts.join(".");
}
