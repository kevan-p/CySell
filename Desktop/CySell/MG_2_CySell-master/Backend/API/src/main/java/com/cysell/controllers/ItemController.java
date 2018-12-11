package com.cysell.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cysell.model.Item;
import com.cysell.model.User;
import com.cysell.repository.ItemRepository;
import com.cysell.repository.UserRepository;

/**
 * @author mbknoth
 *
 * This Controller is in charge of the endpoints for the Items and controls where and how to get
 * the items
 * 
 */
@RestController
public class ItemController {
		
		/**
		 * this is the way to talk to the DB table of Items and Users
		 */
		@Autowired
		ItemRepository itemRepository;
		UserRepository userRepository;
		UserController userController;

	    /**
	     * @return
	     * Returns all the items in the DB regardless of its type
	     */
	    @RequestMapping(path = "/item")
	    public List<Item> getAllItems() {
	        return itemRepository.findAll();
	    }
	    
	    @RequestMapping(path = "/item/user/{item}")
	    public String getUserByItem(@PathVariable Item item) {
	    	String userId = item.getPostedByUserID();
	    	User user = userRepository.findUserById(userId);
	    	return user.getFullName();
	    }
	    
	    /**
	     * @param id
	     * the item's id
	     * @return
	     * Returns the item with the specified id given
	     */
	    @RequestMapping(path = "/item/{itemId}")
	    public Optional<Item> getItemById(@PathVariable("itemId") int id) {
	        return itemRepository.findById(id);
	    }
	    
	    /**
	     * @param item
	     * Given item to be posted in the DB
	     * @return
	     * Returns a string letting the user know that it was successfully posted to the DB
	     */
	    @RequestMapping(method = RequestMethod.POST, path = "/item/{user.id}") 
	    public String postItem(@RequestBody Item item,@PathVariable("user.id") String userId) {
	    	item.setUserIdforItemPosted(userId);
	    	itemRepository.save(item);
	    	return "successfully posted item";
	    	
	    }
	    
	    /**
	     * @return
	     * Returns all the items of type Electronics
	     */
	    @RequestMapping(path = "/item/elec")
	    public List<Item> getAllElecItems() {
	    	List<Item> items = itemRepository.findAllByType("Electronics");
	    	return items;
 	    }
	    
	    /**
	     * @return
	     * Returns all the items of type Books
	     */
	    @RequestMapping(path = "/item/book")
	    public List<Item> getAllBookItems() {
	    	List<Item> items = itemRepository.findAllByType("Books");
	    	return items;
 	    }
	    
	    /**
	     * @return
	     * Returns all the items of type Furniture
	     */
	    @RequestMapping(path = "/item/furn")
 	    public List<Item> getAllFurnItems() {
	    	List<Item> items = itemRepository.findAllByType("Furniture");
	    	return items;
 	    }
	    
	    /**
	     * @return
	     * Returns all the items of type Tickets
	     */
	    @RequestMapping(path = "/item/ticket")
	    public List<Item> getAllTicketItems() {
	    	List<Item> items = itemRepository.findAllByType("Tickets");
	    	return items;
 	    }
	    	    
	
}
