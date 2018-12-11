package com.cysell.websockets;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.cysell.model.Message;
import com.fasterxml.jackson.databind.ObjectMapper;


@ServerEndpoint("/websocket/{senderId}/{receiverID}") 
@Component
public class WebSocketServer {
	// store userid and sessions for all pairs of chatting clients
	private Set<Map<String,Session>> userToSessions = new HashSet<>();
	private Set<Map<Session,String>> sessionsToUser =  new HashSet<>();
	private Set<Map<String,String>> chattingUsers = new HashSet<>();
	
	private static Map<String, Session> usernameSessionMap = new HashMap<>();
	public String rec_id ;
	
	// Store map of users chatting
	
	
    private final Logger logger = LoggerFactory.getLogger(WebSocketServer.class);
    
    //public Message textMessage;

	@OnOpen
    public void onOpen(
    	      Session session,
    	      @PathParam("senderId") String senderId, @PathParam("receiverID") String receiverID) throws IOException {
        logger.info("Entered into Open for session 1");
        usernameSessionMap.put(receiverID, session);
        
		Map<Session,String> sessionMap = new HashMap<>();
		sessionMap.put(session, senderId);
		
		sessionsToUser.add(sessionMap);
		
		Map<String,String> usersMap = new HashMap<>();
		usersMap.put(senderId,  receiverID);
		chattingUsers.add(usersMap);
		
        String message="Users:" + senderId + " " + receiverID + "Have Joined the Chat";
        System.out.println(message);
        
        rec_id = receiverID ;

    }
 
    @OnMessage
    public void onMessage(Session session, String message) throws IOException {
    	logger.info	(message);
    	sendMessageToPArticularUser(rec_id,message);
    }
 
    @OnClose
    public void onClose(Session session){
    	logger.info("Entered into Close");
    	sessionsToUser.remove(session);
    	userToSessions.remove(session);
    	chattingUsers.remove(session);
        usernameSessionMap.remove(rec_id);

    }
 
    @OnError
    public void onError(Session session, Throwable throwable) {
        // Do error handling here
    	logger.info("Entered into Error" + throwable);
    }
    
    
 /**
  * the helper method to send to a particular user
 * @param receiverID
 * the user the message is directed to
 * @param message
 * the text message
 */
private void sendMessageToPArticularUser(String receiverID,String message) {
    	
    	try {
    		usernameSessionMap.get(receiverID).getBasicRemote().sendText(message);
        } catch (IOException e) {
        	logger.info("Exception: " + e.getMessage().toString());
            e.printStackTrace();
        }
    }

}











