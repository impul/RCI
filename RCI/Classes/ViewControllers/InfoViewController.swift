//
//  infoViewController.swift
//  RCI
//
//  Created by Impulse on 08.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import SVProgressHUD

class InfoViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var titleService: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var infoTitle = ""
    var serviceTitle = ""
    var HTMLText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setTitle(titleString: infoTitle)
        if serviceTitle == "" { topConstraint.constant = 0 }
        titleService?.text = serviceTitle
        let formatedText = HTMLText.htmlFormattedString(font: UIFont(name: "SFUIText-Regular", size: 16)!, color: .defaultBlueColor)
        webView.loadHTMLString(formatedText, baseURL: nil)
        webView.delegate = self
        SVProgressHUD.show()
    }
    
//MARK: - UIWebViewDelegate
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
