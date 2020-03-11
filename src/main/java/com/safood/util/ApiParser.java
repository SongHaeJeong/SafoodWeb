package com.safood.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import com.safood.vo.Food;

public class ApiParser {
	private List<Food> foods;
	
	private String apiUrl = "http://apis.data.go.kr/1470000/FoodNtrIrdntInfoService/getFoodNtrItdntList";
	
	private String serviceKey = "pIp%2BjfQPg2qAu9ADLtuEN5llmnX1uCfS1iuxuMIRWpCrANajdtBsc8bIg94XkF13MRj3F12gdWCeUpokVnQHNg%3D%3D";
	private String bgn_year = "2017";
	
	public ApiParser() {
		System.out.println("Loading data...");
	}
	
	public void loadData(int numOfRows, int pageNo) {
		SAXParserFactory factory = SAXParserFactory.newInstance();
		try {
			SAXParser parser = factory.newSAXParser();
			FoodNutritionSAXHandler handler = new FoodNutritionSAXHandler();
			
			HttpURLConnection con = (HttpURLConnection) new URL(String.format("%s?serviceKey=%s&bgn_year=%s&numOfRows=%d&pageNo=%d", apiUrl, serviceKey, bgn_year, numOfRows, pageNo)).openConnection();
			con.setRequestMethod("GET");
			System.out.println(con.getURL());
			
			/*BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			while (br.ready())
				System.out.println(br.readLine());*/
			parser.parse(con.getInputStream(), handler);
			
			foods = handler.getList();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<Food> getFoods() {
		return foods;
	}
}
