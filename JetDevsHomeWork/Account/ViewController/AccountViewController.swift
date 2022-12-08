//
//  AccountViewController.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit
import Kingfisher

class AccountViewController: UIViewController {

	@IBOutlet private weak var nonLoginView: UIView!
	@IBOutlet private weak var loginView: UIView!
	@IBOutlet private weak var daysLabel: UILabel!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var headImageView: UIImageView!
    
	override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
		nonLoginView.isHidden = false
		loginView.isHidden = true
    }
	
	@IBAction func loginButtonTap(_ sender: UIButton) {
        
        // Will present login modal
        let loginVc = LoginViewController()
        loginVc.delegate = self
        self.present(loginVc, animated: true)
        
	}
    
    /// Will setup the user details
    /// - Parameter user: user model object
    func setupUserDetails(_ user: User) {
        
        nameLabel.text = user.userName
        daysLabel.text = user.getAccountSince()
        
    }
	
}

extension AccountViewController: LoginDelegate {
    
    func loginDidSucceed(withUser: User?) {
        if let user = withUser {
            loginView.isHidden = false
            nonLoginView.isHidden = true
            setupUserDetails(user)
        } else {
            loginView.isHidden = true
            nonLoginView.isHidden = false
        }
    }
}
