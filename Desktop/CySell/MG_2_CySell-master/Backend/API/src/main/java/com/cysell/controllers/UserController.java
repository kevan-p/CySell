package com.cysell.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cysell.model.User;
import com.cysell.repository.UserRepository;

/**
 * @author mbknoth
 * Controller in charge of managing the user entities on the backend
 */
@RestController
public class UserController {
		
		/**
		 * Access to the DB for the User Table
		 */
		@Autowired
		UserRepository userRepository;
		

		
		//the POST methods
		
	    /**
	     * @param user
	     * The current user that has logged in and has had their information recorded 
	     * @return
	     * Returns a string that signifies that the function was a success
	     */
	    @RequestMapping(method = RequestMethod.POST , path = "/login/{user}")
	    public String postUserThroughLogin(@PathVariable User user) {
	    	userRepository.save(user);
	    	return "successfully posted user";
	    }
	    
	    /**
	     * Allows a user to be posted in the DB.
	     * @param user
	     * @return one user
	     */
	    @RequestMapping(method = RequestMethod.POST, path = "/user") 
	    public String postUser(@RequestBody User user) {
	    	userRepository.save(user);
	    	return "successfully posted user";
	    	
	    }
	    
	   
	    
	    
	    //the GET methods
	    
	    /**
	     * @param id
	     * the id of the user that is being attempted to be found
	     * @return
	     * Returns the specified user
	     */
	    @RequestMapping(path = "/user/{user.id}")
	    public User getUserById(@PathVariable("user.id") String id) {
	        return userRepository.findUserById(id);
	    }

	    
	    /**
	     * A method to get all the users in the DB
	     * @return
	     * List of all users
	     */
	    @RequestMapping(path = "/users")
	    public List<User> getAllUsers(){
	    	return userRepository.findAll();
	    }
	    
	   
}
