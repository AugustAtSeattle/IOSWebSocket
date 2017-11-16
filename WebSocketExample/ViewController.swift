//
//  ViewController.swift
//  WebSocketExample
//
//  Created by August on 11/16/17.
//  Copyright © 2017 August. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController ,WebSocketDelegate {
    

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    let socket = WebSocket(url: URL(string: "ws://demos.kaazing.com/echo")!)//WebSocket(url: URL(string: "ws://localhost:1337/")!, protocols: ["chat"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start")
        socket.delegate = self
        socket.connect()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func sendTextToWebSocket(_ sender: UIButton) {
        if(socket.isConnected){
            socket.write(string: textField.text!)
        }
        textField.text = ""
    }
    //  release websocket
    deinit {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  WebSocket Delegate
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
        textView.text = textView.text + "\n" + text
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
    }
    
    func websocketDidReceivePong(socket: WebSocketClient, data: Data?) {
        print("Got pong! Maybe some data: \(data?.count)")
    }
    // WebSocket Delegate Code End
    
    //test
}
