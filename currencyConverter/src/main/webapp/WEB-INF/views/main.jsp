<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>환율 계산</title>
  </head>
  <body>
    <h1>환율 계산</h1>
    <br>
    <form action="currency.do">
      <label>송금국가: </label><a>미국(USD)</a>
      <label>수취국가: </label>
      <select name="currencies">
        <option value="USDKRW" title="South Korean Won">한국(KRW)</option>
        <option value="USDJPY" title="Japanese Yen">일본(JPY)</option>
        <option value="USDPHP" title="Philippine Peso">태국(PHP)</option>
      </select>
      <label>환율: </label><a id="currency" name="currency"></a><a id="country" name="country"></a><a>/USD</a>
      <label>송금액: </label><input type="text" id="remittanceAmount" name="remittanceAmount"><a>USD</a>
    </form>
  </body>
</html>
