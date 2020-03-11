package com.safood.vo;

public class SafeFoodException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public SafeFoodException(String msg) {
		super(msg);
	}
}