# Spring을 이용한 환율계산 웹 기능
------------
## 개발환경
Category | Detail
---- | ----
Java version | Java 8
API | currencylayer (https://currencylayer.com/)
IDE | Eclipse (2020-12)
Server | Apache-Tomcat v8.5
CI | Github
Framework | Spring Framework, Maven
------------
## 주요 기능
* 송금국가 미국(USD)으로 고정
* 수취국가 한국(KRW), 일본(JPY), 필리핀(PHP) 중 하나를 selectbox에서 선택, 국가 선택 시 1USD에 대응하는 환율 표시
* 송금액 입력 후 submit버튼을 클릭하면 하단에 수취금액이 계산되어 표시
  * 소수점 둘째자리까지 화면에 표시함
  * 천 단위 콤마 삽입(세 자리 이상 시)
* 송금액이 아래와 같은 경우 alert창으로 '송금액이 바르지 않습니다'라는 에러메세지 송출
  * 송금액이 0 또는 10,000 초과일 경우
  * 숫자가 아닌 다른 문자나 기호가 들어간 경우
