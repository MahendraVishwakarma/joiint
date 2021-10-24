//
//  XMPPConfigureManager.swift
//  XMMPAuth
//
//  Created by Mahendra Vishwakarma on 23/10/21.
//

import Foundation
import XMPPFramework

class XMPPConfigureManager:XMPPStreamDelegate{
    var stream:XMPPStream?
    
    var streamStatusTitle = ""
    weak var delegate: XMPPUpdateStatus?
    private var password = ""
    private let hostName = "hell.la"
    
    
    init(_delegate:XMPPUpdateStatus?) {
        self.delegate = _delegate
        setup()
    }
    
    private func setup() {
        stream = XMPPStream()
        stream?.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    func login(userName:String,password:String) {
        self.password = password
        let jID = userName + "@" + self.hostName
        stream?.myJID = XMPPJID(string: jID)
        self.streamStatusTitle = "initiating connection"
        
        do {
            try stream?.connect(withTimeout: XMPPStreamTimeoutNone)
        }
        catch {
            print("error occured in connecting")
            self.streamStatusTitle = "invalid username"
        }
       
        delegate?.updateConnectionStatus()
    }
    
    func xmppStreamWillConnect(_ sender: XMPPStream) {
        print("will connect")
        self.streamStatusTitle = "will connect"
        delegate?.updateConnectionStatus()
    }
    
    func xmppStreamConnectDidTimeout(_ sender: XMPPStream) {
        print("timeout")
        self.streamStatusTitle = "time out"
        delegate?.updateConnectionStatus()
    }
    
    func xmppStreamDidStartNegotiation(_ sender: XMPPStream) {
        print("xmppStreamDidStartNegotiation:")
        self.streamStatusTitle = "xmppStreamDidStartNegotiation"
        delegate?.updateConnectionStatus()
    }
    
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        do {
            try stream?.authenticate(withPassword: self.password)
        }
        catch(_) {
            print("catch")
            
        }
        self.streamStatusTitle = "auth started"
        delegate?.updateConnectionStatus()
        print("Stream: Connecting...")
        
    }
    func xmppStream(_ sender: XMPPStream, socketDidConnect socket: GCDAsyncSocket) {
        print("socketDidConnect:")
        
    }
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("authenticate done")
        self.streamStatusTitle = "Authenticate Done"
       
        delegate?.updateConnectionStatus()
        
        sender.send(XMPPPresence())
    }
    func xmppStreamDidDisconnect(_ sender: XMPPStream, withError error: Error?) {
        print("stream disconnect")
        self.streamStatusTitle = "stream disconnected"
       
        delegate?.updateConnectionStatus()
    }
    func xmppStream(_ sender: XMPPStream, didReceiveError error: DDXMLElement) {
        print("error")
       
        self.streamStatusTitle = "error occured"
        delegate?.updateConnectionStatus()
    }
    
    func xmppStream(_ sender: XMPPStream, didNotRegister error: DDXMLElement) {
       
      
        delegate?.updateConnectionStatus()
    }
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        print("auth failed")
        self.streamStatusTitle = "stream failed"
        delegate?.updateConnectionStatus()
    }
}

protocol XMPPUpdateStatus:AnyObject {
    func updateConnectionStatus()
}
