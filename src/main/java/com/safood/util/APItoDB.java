package com.safood.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.safood.vo.Food;

public class APItoDB {
	private ApiParser parser;  
	
	APItoDB() {
		parser = new ApiParser();
	}
	
	public static void main(String[] args) {
		APItoDB loader = new APItoDB();
		loader.loadAPItoDB();
	}
	
	private void loadAPItoDB() {
		String url = "jdbc:mysql://127.0.0.1:3306/safood?serverTimezone=Asia/Seoul";
		String user = "root";
		String pass = "manager";

		Connection con;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pass);

			loadFoods(con);

			con.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private String qInsertFood = "INSERT into food values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private void loadFoods(Connection con) throws SQLException {
		PreparedStatement pInsertFood = con.prepareStatement(qInsertFood);
		
		for (int i = 1; i <= 91; i++) {
			parser.loadData(100, i);
			List<Food> foods = parser.getFoods();
			
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
				
//				System.out.println(food.toString());
				pInsertFood.executeUpdate();
			}
			System.out.println(i + "th 100 statements processed: " + pInsertFood.toString());
		}

		pInsertFood.close();
	}
}
