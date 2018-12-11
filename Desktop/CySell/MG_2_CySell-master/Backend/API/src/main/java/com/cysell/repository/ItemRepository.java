package com.cysell.repository;

import java.util.List;

import org.springframework.data.jpa.repository.*;

import com.cysell.model.Item;

/**
 * @author mbknoth
 * the repository for the item table in the DB
 */
public interface ItemRepository extends JpaRepository<Item, Integer> {
	
	/**
	 * the query for getting items by certain type
	 * @param type
	 * the specified type of the item
	 * @return
	 * a list of the items of that type
	 */
	public List<Item> findAllByType(String type);
	
	
}
