package com.sysbench.connection;

public class User {
	
	private String ip;
	private int port;
	private String userName;
	private String password;
	

	//constructor
	public User(String ip, int port, String userName, String password) {
		super();
		this.ip = ip;
		this.port = port;
		this.userName = userName;
		this.password = password;
	}
	
	//IP
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	//Port
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
	}
	
	//User Name
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	//Password
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

}
