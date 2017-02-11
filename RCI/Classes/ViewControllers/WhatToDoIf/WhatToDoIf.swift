//
//  WhatToDoIf.swift
//  RCI
//
//  Created by Impulse on 11.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import SVProgressHUD


class WhatToDoIfController : UIViewController {
    
    var HTMLText:[String] = []
    var infoTitle = ""
    var instruction:AccidentInstructions?
    
    @IBOutlet weak var segmentControll: CustomSegmentControll!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setTitle(titleString: infoTitle)
        setupSegmentControll()
        webView.delegate = self
        updateInstruction()
    }
    
    func setupSegmentControll() {
        segmentControll.delegate = self
        if  (instruction?.tabs)! {
            segmentControll.setupSegmentController(titles: [(instruction?.firstTitle)!,(instruction?.secondTitle)!])
            HTMLText = [(instruction?.firstContent)!,(instruction?.secondContent)!]
        } else {
            segmentControll.setupSegmentController(titles: [(instruction?.firstTitle)!])
            HTMLText = [(instruction?.firstContent)!]
        }
    }
    
    func updateInstruction() {
        let formatedText = HTMLText[segmentControll.selectedSegmentIndex].htmlFormattedString(font: UIFont(name: "SFUIText-Regular", size: 16)!, color: .defaultBlueColor)
        webView.loadHTMLString(formatedText, baseURL: nil)
        SVProgressHUD.show()
    }
}

extension WhatToDoIfController : UIWebViewDelegate, CustomSegmentControllProtocol {
//MARK: - UIWebViewDelegate
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
//MARK: - CustomSegmentControllProtocol
    
    func selectedItem(atIndex: Int) {
        self.updateInstruction()
    }
}
