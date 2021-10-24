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
    var isAuthenticationDone:Bool = false
    var streamStatusTitle = ""
    weak var delegate: XMPPUpdateStatus?
    init() {
        setup()
    }
    
    private func setup(){
        stream = XMPPStream()
        
        stream?.addDelegate(self, delegateQueue: DispatchQueue.main)
        stream?.myJID = XMPPJID(string: "mahendra1@hell.la")
        
        do {
            try stream?.connect(withTimeout: XMPPStreamTimeoutNone)
        }
        catch {
            print("error occured in connecting")
        }
        self.streamStatusTitle = "initiating connection"
        
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
            try stream?.authenticate(withPassword: "mahendra@123")
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
        print("auth done")
        self.streamStatusTitle = "auth Done"
        self.isAuthenticationDone = true
        delegate?.updateConnectionStatus()
        
        sender.send(XMPPPresence())
    }
    func xmppStreamDidDisconnect(_ sender: XMPPStream, withError error: Error?) {
        print("stream disconnect")
        self.streamStatusTitle = "stream disconnected"
        self.isAuthenticationDone = false
        delegate?.updateConnectionStatus()
    }
    func xmppStream(_ sender: XMPPStream, didReceiveError error: DDXMLElement) {
        print("error")
        self.isAuthenticationDone = false
        self.streamStatusTitle = "error occured"
        delegate?.updateConnectionStatus()
    }
    
    func xmppStream(_ sender: XMPPStream, didNotRegister error: DDXMLElement) {
        self.isAuthenticationDone = false
        self.streamStatusTitle = "error occured"
        delegate?.updateConnectionStatus()
    }
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        print("auth failed")
        self.streamStatusTitle = "stream failed"
        self.isAuthenticationDone = false
        delegate?.updateConnectionStatus()
    }
}

protocol XMPPUpdateStatus:AnyObject {
    func updateConnectionStatus()
}
