//
//  QuestionnariesResult.swift
//  RCI
//
//  Created by Impulse on 13.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import SVProgressHUD

class QuestionnariesResult: UIViewController {
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultDescriptionWebView: UIWebView!

    var testName: Questionnaires?
    var questions:[SingleQuestion] = []
    var resultTest:[String:Any] = [:]
    
    @IBAction func tryAgainAction(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
        _ = navigationController?.popViewController(animated: true)
        let controller:QuestionariesTest = self.storyboard?.instantiateViewController(withIdentifier: "QuestionariesTest") as! QuestionariesTest
        controller.setupController(questionsList: questions , questionTitle: testName!)
        self.customPushController(controller: controller)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestionariesResultBar()
        setTitle(titleString: (testName?.title)!)
        guard let result:String = resultTest["score"] as? String else {
            return
        }
        guard let message:String = resultTest["message"] as? String else {
            return
        }
        resultTitleLabel.text = "Your results: \(result)"
        resultDescriptionWebView.loadHTMLString(message.htmlFormattedString(font: UIFont(name: "SFUIText-Regular", size: 16)!, color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)), baseURL: nil)
        SVProgressHUD.show()
        resultDescriptionWebView.delegate = self
    }
    
    func setupController(questionsList:[SingleQuestion], questionTitle:Questionnaires, resultTest:[String:Any]) {
        testName = questionTitle
        questions = questionsList
        self.resultTest = resultTest
    }
}

extension QuestionnariesResult : UIWebViewDelegate {
    //MARK: - UIWebViewDelegate
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func setupQuestionariesResultBar () {
        let rigthButton = UIBarButtonItem(image: #imageLiteral(resourceName: "MainMenuButton"), style: .plain, target: self, action:#selector(UIViewController.rigthButtonAction))
        self.navigationItem.rightBarButtonItem = rigthButton
        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "BackButton"), style: .plain, target: self, action: #selector(UIViewController.rigthButtonAction))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    
}
