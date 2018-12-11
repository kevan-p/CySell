package com.cysell.repository;

import java.util.List;

import org.springframework.data.jpa.repository.*;

import com.cysell.model.Item;
import com.cysell.model.User;

/**
 * the repository that allows access to the User Table in the DB
 * @author mbknoth
 *
 */
public interface UserRepository extends JpaRepository<User, Integer> {
	public User findUserById(String userId);
}
