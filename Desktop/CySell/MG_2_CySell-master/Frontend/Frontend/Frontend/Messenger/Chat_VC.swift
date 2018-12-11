import UIKit
import JSQMessagesViewController
import SwiftWebSocket
import Alamofire

/// To access User Defaults
let defaults = UserDefaults.standard
/// an array of message_t
var SavedArr = [message_t]()
///an array of message_t
var LoadedArr = [JSQMessage]()
/// To access an array of messages
var MessageArr_test = [message_t]()
/// To use Notifaction center
var notification = NotificationCenter.default


/// To access the receiver's ID
var receiverId : String!

/// struct of type message_t that could be coded and decoded from data and JSON
struct message_t: Codable{
    var id: String?
    var name: String?
    var text: String?
    var date: Int?
    //var receiverId: String?
    
    private enum CodingKeys: String, CodingKey {
        case  id = "id", name = "name",text = "text", date = "date" //, receiverId = "receiverId"
    }
    //init(id: String? = nil, name: String? = nil, text: String? = nil, date : Int? = nil)
    init(id: String? = nil, name: String? = nil, text: String? = nil) {
        self.id = id
        self.name = name
        self.text = text
        //self.date = date
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        text = try container.decode(String.self, forKey: .text)
        //the correct code to use is the if else block, commented to demo a 2 client connection
        // This id demos as if the message is coming from the server with a sender id = ccc
        //date = try container.decode(Int.self, forKey: .date)
        //id = "ccc"
        if let value = try? container.decode(Int.self, forKey: .id) {
            id = String(value)
        } else {
            id = try container.decode(String.self, forKey: .id)
        }
    }
}

/// A class to display the chat view
class Chat_VC: JSQMessagesViewController {
        /// an array of type JSQMessage
    var messages  = [JSQMessage]()
    

    ///To intiitlaize a websocket between the client side and the server
    let socket = WebSocket("ws://proj309-mg-02.misc.iastate.edu:8080/websocket/\(senderId)/\(receiverId)")
    ///To access the ShowMore_ViewController and use it's variables
    let ShowMore_VC = ShowMore_ViewController()
    ///To access the Profile_ViewController and use it's variables

    override func viewDidLoad() {
        
        super.viewDidLoad()
        receiverId = id_i
        print(receiverId)
        /// To access the sender's ID
        senderId = profileID
        /// To accesss the sender's Display name
        senderDisplayName = firstName
        /// To hide incoming message avatar view
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        /// To hide outgoing message avatar view
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        SetSocket()
    }
    
    /// Called right before the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        save(MessageArr_test)
        print("saved")
    }
    /// called right before the view appears
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    /// To save the array in the parameter locally using user defaults
    ///
    /// - Parameter MessageArr_test: an array of messages
    func save(_ MessageArr_test : [message_t]){
        //Arr = Arr + MessageArr_test
        let data = MessageArr_test.map { try? JSONEncoder().encode($0) }
        defaults.set(data, forKey: "history")
        defaults.synchronize()
        print(data)
        print("using Arr")
    }
    
    
    
    /// returns an array of messages after retreiving it from the UserDefaults using a Key.
    ///
    /// - Returns: returns an array of messages after being loaded back from the User Defaults
    func load() -> [message_t]{
        guard let encodedData = defaults.array(forKey: "history") as? [Data] else {
            return []
        }
        return encodedData.map { try! JSONDecoder().decode(message_t.self, from: $0) }
    }
    
    /// Handles all the events related to the websocket
    func SetSocket(){
        /// Handles the socket open event
        socket.event.open = {
            print("opened")
        }
        /// Handles the socket close event
        socket.event.close = { code, reason, clean in
            print("closed")
        }
        /// Handles the socket on error event
        socket.event.error = { error in
            print("error \(error)")
        }
        /// Handles the socket on recieveing a message event
        socket.event.message = { message in
            let result = message as! String
            let data = Data(result.utf8)
            do {
                let message = try JSONDecoder().decode(message_t.self, from: data)
                self.messages.append(JSQMessage(senderId: message.id, displayName: message.name, text: message.text))
                MessageArr_test.append(message_t(id: message.id, name: message.name, text: message.text))
            } catch {
                print(error)
            }
            self.collectionView.reloadData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        
        return messages[indexPath.item]
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
        
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        let message = messages[indexPath.item]
        if message.senderId == self.senderId{
            
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .red)
        }
        else{
            return bubbleFactory?.incomingMessagesBubbleImage(with: .black)
            
        }
    }
    
    ///struct of type parameters that could be coded and decoded from data and JSON
    /// only used to display the data being decoded from the message being sent
    struct parameters : Codable {
        var name : String
        var id : String
        var receiverID : String
        var text: String
        //var date: Date
        
        init(name: String,id: String, receiverID: String, text:String ) {
            self.name = name
            self.id = id
            self.receiverID = receiverID
            self.text = text
            //self.date = date
        }
    }

    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            //
            let data = try encoder.encode(parameters(name: senderDisplayName, id: senderId, receiverID: receiverId, text: text))
            MessageArr_test.append(message_t(id: senderId, name: senderDisplayName, text: text ))
            socket.send(String(data: data, encoding: .utf8)!)
        }
        catch{
            print("error here")
        }
        self.messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
        finishSendingMessage(animated : true)
        self.collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
}
