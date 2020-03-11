package com.safood.util;

import java.util.ArrayList;
import java.util.List;

import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;

/**
 * allergies.xml 파일에서 식품 정보를 읽어 파싱하는 핸들러 클래스
 */
public class AllergySAXHandler extends DefaultHandler {
	private List<String> allergies;
	
	/** 태그 바디 정보를 임시로 저장 */
	private String temp;

	public AllergySAXHandler() {
		allergies = new ArrayList<>();
	}

	public void startElement(String uri, String localName, String qName, Attributes att) {
		if (qName.equals("allergy")) {
			temp = "";
		}
	}

	public void endElement(String uri, String localName, String qName) {
		if (qName.equals("allergy")) {
			allergies.add(temp);
		}
	}

	public void characters(char[] ch, int start, int length) {
		temp = new String(ch, start, length);
	}

	public List<String> getAllergies() {
		return allergies;
	}

	public void setAllergies(List<String> allergies) {
		this.allergies = allergies;
	}
}