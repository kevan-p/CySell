package com.cysell.model;

import java.util.List;

import javax.annotation.Generated;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.cysell.repository.UserRepository;


/**
 * @author mbknoth
 * the modal for a user
 */
@Entity
public class User {

	
	public User() {
		
	}
	/**
	 * the id of the user
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	/**
	 * the fullname of the user
	 */
	private String fullName;
	
//	private String classificiation;
//	
//	private String major;
//	
//	private int phoneNumber;
//	
//	private String description;


	/**
	 *  the getter of the user id
	 * @return
	 * the id of the specified user
	 */
	public int getId() {
		return this.id;
	}
	
	/**
	 * the setter for the user id
	 * @param id
	 * the new user id 
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * the getter of the fullname of the user
	 * @return
	 * the fullname of the user
	 */
	public String getFullName() {
		return this.fullName;
	}
	
	/**
	 * the setter for the new fullname of the user
	 * @param newName
	 * the new fullname for the user
	 */
	public void setFullName(String newName) {
		this.fullName = newName;
	}
	
//	public String getClassification() {
//		return this.classification;
//	}
//	
//	public void setClassification(String newClassification) {
//		this.classification = newClassification
//	}
//	
//	public String getMajor() {
//		return this.major;
//	}
//	
//	public void setMajor(String newMajor) {
//		this.major = newMajor
//	}
//	
//	public int getPhone() {
//		return this.phoneNumber;
//	}
//	
//	public void setPhone(int newPhone) {
//		this.phoneNumber = newPhone
//	}
//	
//	public String getDescription() {
//		return this.description;
//	}
//	
//	public void setDescription(String newDescription) {
//		this.description = newDescription
//	}
}
