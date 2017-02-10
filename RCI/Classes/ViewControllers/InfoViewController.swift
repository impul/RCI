//
//  infoViewController.swift
//  RCI
//
//  Created by Impulse on 08.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController: BaseViewController,UIWebViewDelegate {
    
    @IBOutlet weak var titleService: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var infoTitle:String = ""
    var serviceTitle:String = ""
    var HTMLText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(titleString: infoTitle)
        self.titleService.text = serviceTitle
        let formatedText = HTMLText.htmlFormattedString(font: UIFont.init(name: "SFUIText-Regular", size: 16)!, color: UIColor.defaultBlueColor())
        webView.loadHTMLString(formatedText, baseURL: nil)
    }
}
