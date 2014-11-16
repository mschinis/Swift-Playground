//
//  MessagesViewController.swift
//  Playground
//
//  Created by Michael Schinis on 12/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit

class MessagesViewController: JSQMessagesViewController, JSQMessagesCollectionViewDataSource {
    var messages:[JSQMessage] = []
    var incomingBubble:JSQMessagesBubbleImage!
    var outgoingBubble:JSQMessagesBubbleImage!
    
    func senderDisplayName() -> String! {
        return "Michael Schinis"
    }
    func senderId() -> String! {
        return "9339"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderDisplayName = self.senderDisplayName()
        self.senderId = self.senderId()
        self.title = "Recipient name"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        self.incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor( UIColor.jsq_messageBubbleGreenColor() )
        self.outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor( UIColor.jsq_messageBubbleLightGrayColor())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        
        // AFNetworking example
        var manager = AFHTTPRequestOperationManager()
        manager.GET(("[URL to send]" as NSString), parameters: ["from":"SpiKe", "to":"[phone number]", "message": text], success: {
                (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                self.messages.append(message)
                self.finishSendingMessage()
                println(responseObject)
            }, failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            
        })
        
        println(text);
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        return self.messages[indexPath.row]
    }
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let msg = self.messages[indexPath.row]
        if(msg.senderId == self.senderId){
            return self.outgoingBubble
        }else{
            return self.incomingBubble
        }
    }
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as JSQMessagesCollectionViewCell
        var msg = self.messages[indexPath.row]
        if(msg.senderId == self.senderId){
            cell.textView.textColor = UIColor.blackColor()
        }else{
            cell.textView.textColor = UIColor.whiteColor()
        }
        return cell
    }
}
