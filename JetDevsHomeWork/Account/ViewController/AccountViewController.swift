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
        
        let loginVc: UIViewController = LoginViewController()
        loginVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVc, animated: true)
        
	}
	
}
