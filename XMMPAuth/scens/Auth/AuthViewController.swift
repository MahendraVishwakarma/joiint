//
//  AuthViewController.swift
//  XMMPAuth
//
//  Created by Mahendra Vishwakarma on 23/10/21.
//

import UIKit

class AuthViewController: UIViewController {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnAuth: UIButton!
    var xmppConfigure:XMPPConfigureManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        setupConfiguration()
        // Do any additional setup after loading the view.
    }
    
    private func setupConfiguration() {
        txtPassword.delegate = self
        txtUsername.delegate = self
        btnHome.isHidden = true
        
        btnAuth.layer.cornerRadius = 8
        xmppConfigure = XMPPConfigureManager(_delegate: self)
        //xmppConfigure.delegate = self
        statusLabel.text = xmppConfigure.streamStatusTitle
    }
    
    @IBAction func authAction(_ sender: Any) {
        btnAuth.isEnabled = false
        xmppConfigure.login(userName: txtUsername.text ?? "", password: txtPassword.text ?? "")
        activity.startAnimating()
    }
    @IBAction func homeScreen(_ sender: Any) {
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}

extension AuthViewController:UITextFieldDelegate {
    //This is for the keyboard to GO AWAYY !! when user clicks anywhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //This is for the keyboard to GO AWAYY !! when user clicks "Return" key  on the keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AuthViewController: XMPPUpdateStatus {
    func updateConnectionStatus() {
        let status = xmppConfigure.stream?.state
        statusLabel.text = xmppConfigure.streamStatusTitle
        if(status == .STATE_XMPP_DISCONNECTED) {
            activity.stopAnimating()
            btnAuth.isEnabled = true
            btnHome.isHidden = true
        } else if status == .STATE_XMPP_CONNECTED {
            activity.stopAnimating()
            btnHome.isHidden = false
            btnAuth.isEnabled = true
        }
        
    }
    
    
}
