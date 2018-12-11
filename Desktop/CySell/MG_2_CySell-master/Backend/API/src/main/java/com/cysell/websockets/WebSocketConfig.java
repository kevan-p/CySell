package com.cysell.websockets;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;


/**
 * @author mbknoth
 * what starts the websocket and configurations
 */
@Configuration 
public class WebSocketConfig {  
    /**
     * Starts up the endpoints for the websockets
     * @return
     * the new server endpoint exporter
     */
    @Bean  
    public ServerEndpointExporter serverEndpointExporter(){  
        return new ServerEndpointExporter();  
    }  
} 

