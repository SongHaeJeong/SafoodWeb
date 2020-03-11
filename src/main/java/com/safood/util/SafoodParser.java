package com.safood.util;

import java.util.List;
import java.util.Map;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import com.safood.vo.Food;

/**
 * FoodNutritionSAXHandler와 FoodSAXHandler를 이용해서 식품 정보를 load하는 SAX Parser 프로 그램
 *
 */
public class SafoodParser {
	private String allergyFilePath = "http://localhost:12345/data/allergies.xml";
	private String foodFilePath = "http://localhost:12345/data/foodInfo.xml";
	private String nutritionFilePath = "http://localhost:12345/data/FoodNutritionInfo.xml";
	private List<Food> foods;
	private List<String> allergies;

	public SafoodParser() {
		System.out.println("Loading data...");
		loadData();
	}

	/**
	 * FoodNutritionSAXHandler와 FoodSAXHandler를 이용 파싱한 식품 정보와 식품 영양 정보를 Food에 병합한다.
	 */
	private void loadData() {
		SAXParserFactory factory = SAXParserFactory.newInstance();
		try {
			SAXParser parser = factory.newSAXParser();
			FoodSAXHandler handler = new FoodSAXHandler();
			FoodNutritionSAXHandler nHandler = new FoodNutritionSAXHandler();
			AllergySAXHandler aHandler = new AllergySAXHandler();
			
			System.out.println(0);
			parser.parse(foodFilePath, handler);
			parser.parse(nutritionFilePath, nHandler);
			parser.parse(allergyFilePath, aHandler);
			System.out.println(0);
			
			Map<String, Food> foodMap = handler.getFoods();
			allergies = aHandler.getAllergies(); 
			foods = nHandler.getList();
			Food find;
			for (Food food : foods) {
				find = foodMap.get(food.getName());
				if (find != null) {
					food.setCode(find.getCode());
					food.setName(find.getName());
					food.setMaker(find.getMaker());
					food.setMaterial(find.getMaterial());
					food.setImg(find.getImg());
				}
			}
//			System.out.println(foods);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Food> getFoods() {
		return foods;
	}

	public List<String> getAllergies() {
		return allergies;
	}
}