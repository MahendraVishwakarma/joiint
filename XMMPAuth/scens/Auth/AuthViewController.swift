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
    var xmppConfigure:XMPPConfigureManager!
    override func viewDidLoad() {
        super.viewDidLoad()

        xmppConfigure = XMPPConfigureManager()
        xmppConfigure.delegate = self
        statusLabel.text = xmppConfigure.streamStatusTitle
        if !xmppConfigure.isAuthenticationDone {
            activity.startAnimating()
            btnHome.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func homeScreen(_ sender: Any) {
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}

extension AuthViewController: XMPPUpdateStatus {
    func updateConnectionStatus() {
        statusLabel.text = xmppConfigure.streamStatusTitle
        if xmppConfigure.isAuthenticationDone {
            activity.stopAnimating()
            btnHome.isHidden = false
        }
    }
    
    
}
