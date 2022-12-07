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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: user.createdAt) {
            let diff = (Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0)
            daysLabel.text = "Created \(diff) days ago"
        }
        
    }
	
}

extension AccountViewController: LoginDelegate {
    
    func loginDidSucceed(forUser: User) {

        loginView.isHidden = false
        nonLoginView.isHidden = true
        setupUserDetails(forUser)
        
    }
    
}
