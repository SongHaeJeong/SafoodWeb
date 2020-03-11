package com.safood.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.safood.vo.Allergy;
import com.safood.vo.Food;

public class XMLLoader {
	private SafoodParser parser;

	XMLLoader() {
		parser = new SafoodParser();
	}

	public static void main(String[] args) {
		XMLLoader loader = new XMLLoader();
		loader.loadXMLToDB();
	}

	/**
	 * 식품 영양학 정보와 식품 정보를 xml 파일에서 읽어서 DB에 넣는다.
	 */
	private void loadXMLToDB() {
		String url = "jdbc:mysql://127.0.0.1:3306/safood?serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "manager";

		Connection con;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pass);
			
			loadAllergies(con);
			loadFoods(con);
			loadFoodHasAllergy(con);
			System.out.println(3);

			con.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	private String qInsertAllergy = "INSERT into allergy(name) values (?)";
	private void loadAllergies(Connection con) throws SQLException {
		List<String> allergies = parser.getAllergies();
		PreparedStatement pInsertAllergy = con.prepareStatement(qInsertAllergy);
		
		for (String allergy : allergies) {
			pInsertAllergy.setString(1, allergy);
			
			System.out.println(pInsertAllergy);
			pInsertAllergy.executeUpdate();
		}
		
		pInsertAllergy.close();
	}
	private String qInsertFood = "INSERT into food values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private void loadFoods(Connection con) throws SQLException {
		List<Food> foods = parser.getFoods();
		PreparedStatement pInsertFood = con.prepareStatement(qInsertFood);

		for (Food food : foods) {
			pInsertFood.setInt(1, food.getCode());
			pInsertFood.setString(2, food.getName());
			pInsertFood.setDouble(3, food.getSupportpereat());
			pInsertFood.setDouble(4, food.getCalory());
			pInsertFood.setDouble(5, food.getCarbo());
			pInsertFood.setDouble(6, food.getProtein());
			pInsertFood.setDouble(7, food.getFat());
			pInsertFood.setDouble(8, food.getSugar());
			pInsertFood.setDouble(9, food.getNatrium());
			pInsertFood.setDouble(10, food.getChole());
			pInsertFood.setDouble(11, food.getFattyacid());
			pInsertFood.setDouble(12, food.getTransfat());
			pInsertFood.setString(13, food.getMaker());
			pInsertFood.setString(14, food.getMaterial());
			pInsertFood.setString(15, food.getImg());

			System.out.println(pInsertFood.toString());
//			pInsertFood.executeUpdate();
		}

		pInsertFood.close();
	}
	
	private String qSelectAllergies = "SELECT * from allergy order by aid";
	private String qSelectFoods = "SELECT * from food order by code";
	private String qInsertFHA = "INSERT into food_has_allergy(food_code, allergy_aid) VALUES (?, ?)";
	private void loadFoodHasAllergy(Connection con) throws SQLException {
		PreparedStatement pInsertFHA = con.prepareStatement(qInsertFHA);
		
		ResultSet rs = con.createStatement().executeQuery(qSelectAllergies);
		List<Allergy> allergies = new ArrayList<>();
		while (rs.next())
			allergies.add(new Allergy(rs.getInt("aid"), rs.getString("name")));
		
		rs = con.createStatement().executeQuery(qSelectFoods);
		List<Food> foods = new ArrayList<>();
		while (rs.next())
			foods.add(new Food(rs.getInt("code"), rs.getString("material")));
		
		System.out.println(foods.size());
		for (int fidx = 0; fidx < foods.size(); fidx++) {
			String material = foods.get(fidx).getMaterial();
			for (int aidx = 0; aidx < allergies.size(); aidx++) {
				if (material.contains(allergies.get(aidx).getName())) {
					System.out.println(fidx + " | " + aidx);
					pInsertFHA.setInt(1, foods.get(fidx).getCode());
					pInsertFHA.setInt(2, allergies.get(aidx).getAid());
					pInsertFHA.executeUpdate();
				}
			}
		}
		
		pInsertFHA.close();
	}
}

