package com.wirebarley.currencyConverter.controller;


import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CurrencyConverterController {
	
	@RequestMapping("/main.do")
	public ModelAndView goMain() {
		ModelAndView mv = new ModelAndView("main");
		return mv;
	}
	
//환율조회
	@RequestMapping(value="/currencyLive.do", method=RequestMethod.GET)
	public ModelAndView getCurrency(ModelAndView mv) {
		mv = new ModelAndView("jsonView");
		final String accessKey = "06382c005c29e97d25145ab7ad7982b2"; //홈페이지에서 얻은 키값
		final String endpoint = "live"; //실시간으로 가져오기
		String [] currency = {"USDKRW", "USDJPY", "USDPHP"}; //세가지 국가 가져올 것
		
		CloseableHttpClient httpClient = HttpClients.createDefault();
//		HttpGet getUrl = new HttpGet("http://apilayer.net/api/" + endpoint + "?access_key=" + accessKey + "&currencies=KRW,JPY,PHP&source=USD");
		HttpGet getUrl = new HttpGet("http://apilayer.net/api/" + endpoint + "?access_key=" + accessKey);
		
		try {
			CloseableHttpResponse response = httpClient.execute(getUrl);
			HttpEntity httpEntity = (HttpEntity) response.getEntity();
			JSONObject objResult = new JSONObject(EntityUtils.toString(httpEntity));
			for (int i = 0 ; i < currency.length ; i++) {
				mv.addObject(currency[i], objResult.getJSONObject("quotes").get(currency[i]));
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("환율확인: " + mv.getModelMap());
		return mv;
	}

}
