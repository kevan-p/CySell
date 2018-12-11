package com.cysell.model;

import java.sql.Date;


/**
 * @author mbknoth
 * the modal for the message object
 */
public class Message {
	
	/**
	 * the sender's id of the message
	 */
	String senderId;
	/**
	 * the name of the sender
	 */
	String name;
	/**
	 * the date when the message was sent
	 */
	Date date;
	/**
	 * the actual text message that is being sent
	 */
	String textMessage;
	/**
	 * the receiver's id of the message
	 */
	String receiverId;
	/**
	 * the item under discussion in the messages
	 */
	int itemId;
	
	/**
	 * the getter for the item id
	 * @return
	 * the item id
	 */
	public int getItemId() {
		return itemId;
	}

	/**
	 * the setter for the item id
	 * @param itemId
	 * the new item id
	 */
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	/**
	 * the constructor for the message
	 * @param senderId
	 * the sender's id
	 * @param name
	 * the name of the sender
	 * @param date
	 * the date of when the message was sent
	 * @param textMessage
	 * the message that is being sent
	 * @param receiverId
	 * the receiver's id of the message
	 */
	public Message(String senderId, String name, Date date, String textMessage, String receiverId, int itemId) {
		this.senderId = senderId;
		this.name = name;
		this.date = date;
		this.textMessage = textMessage;
		this.receiverId = receiverId;
		this.itemId = itemId;
	}
	
	/**
	 * the abstract constructor for message
	 */
	public Message() {
		
	}
	
	/**
	 * the getter of the sender's id
	 * @return
	 * the sender's id
	 */
	public String getSenderID() {
		return this.senderId;
	}
	
	/**
	 * the setter for the sender's id
	 * @param userId1
	 * the id that will be assigned to the sender
	 */
	public void setSenderID(String userId1) {
		this.senderId = userId1;
	}
	
	/**
	 * the getter for the name of the sender
	 * @return
	 * the name of the sender
	 */
	public String getName() {
		return this.name;
	}
	
	/**
	 * the setter for the name of the sender
	 * @param name
	 * the name that will be assigned to the sender
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * the getter of the message's date when sent
	 * @return
	 * the date of the message
	 */
	public Date getDateofMessage() {
		return this.date;
	}

	/**
	 * the getter of the text message
	 * @return
	 * the text message
	 */
	public String getTextMessage() {
		return this.textMessage;
	}
	
	/**
	 * the setter of the text message
	 * @param textMessage
	 * the message that wants to be set to
	 */
	public void setTextMessage(String textMessage) {
		this.textMessage = textMessage;
	}
	
	/**
	 * the getter for the receiver's id
	 * @return
	 * the receiver's id
	 */
	public String getReceiverId() {
		return this.receiverId;
	}
	
	/**
	 * the setter of the receiver's id
	 * @param receiverId
	 * the receiver's id that will be set
	 */
	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}
}

