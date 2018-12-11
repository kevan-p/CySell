package com.cysell.model;

import javax.annotation.Generated;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


/**
 * @author mbknoth
 * The modal for an Item object
 */
@Entity
public class Item {
	
	/**
	 * an abstract constructor for Item
	 */
	public Item() {
		
	}

	/**
	 * the constructor for Item
	 * @param id
	 * the id to the given item
	 * @param name
	 * the name of the item
	 * @param price
	 * the price of the item
	 * @param type
	 * the type of the item 
	 * @param description
	 * the description of the item
	 */
	public Item(int id, String name, String price, String type,
			String description, String userId, String seller_name) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.type = type;
		this.description = description;
		//this.address = address;
		this.postedByUserID = userId;
		this.seller_name = seller_name;
	}
	
	/**
	 * id for the item
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	/**
	 * the name of the item
	 */
	private String name;
	
	/**
	 * the price of the item
	 */
	private String price;
	
	/**
	 * the type of the item
	 */
	public String type;

	/**
	 * the description of the item
	 */
	private String description;
	
	//private String address;
	
	/**
	 * the user id for the associated posting user
	 */
	private String postedByUserID;
	
	private String seller_name;
	
	public String getSeller_name() {
		return seller_name;
	}

	public void setSeller_name(String seller_name) {
		this.seller_name = seller_name;
	}

	/**
	 * the getter for the item name
	 * @return
	 * returns the item name
	 */
	public String getName() {
		return this.name;
	}
	
	/**
	 * sets the items name
	 * @param name
	 * the name that will be assigned to the item
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * the getter for the item id
	 * @return
	 * returns the item id
	 */
	public int getId() {
		return this.id;
	}
	
	/**
	 * the setter for the id
	 * @param id
	 * the id that will be assigned to the item
	 */
	public void setId(int id) {
		this.id = id;
	}
	
	/**
	 * the getter for the price
	 * @return
	 * the price of the item
	 */
	public String getPrice() {
		return price;
	}
	
	/**
	 * the setter for the price
	 * @param price
	 * the price that will be assigned to the item
	 */
	public void setPrice(String price) {
		this.price = price;
	}
	
	/**
	 * the getter for the description of the item
	 * @return
	 * the description of the item
	 */
	public String getDescription() {
		return description;
	}
	
	/**
	 * the setter for the item
	 * @param description
	 * the description that will be assigned to the item
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	
//	public String getAddress() {
//		return address;
//	}
//	
//	public void setAddress(String address) {
//		this.address = address;
//	}
	/**
	 * the getter for the type of the item
	 * @return
	 * the type of the item
	 */
	public String getType() {
		return type;
	}
	
	/**
	 * the setter for the type of the item
	 * @param type
	 * the type of the item that will be assigned to the item
	 */
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * the getter for the userId that is associated with the item
	 * @return
	 * the userid
	 */
	public String getPostedByUserID() {
		return this.postedByUserID;
	}
	
	/**
	 * the setter for the user id for the item
	 * @param userId
	 * the posting user of the item's id
	 */
	public void setUserIdforItemPosted(String userId) {
		this.postedByUserID = userId;
	}
	
}
