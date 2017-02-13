//
//  QuestionnairesList.swift
//  RCI
//
//  Created by Impulse on 13.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import SVProgressHUD

class QuestionnairesList : UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var questionariesList:[Questionnaires] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setTitle(titleString: "Questionnaires")
        getQuestionnaries()
    }
    
    func getQuestionnaries() {
        SVProgressHUD.show()
        APIManager.sharedInstance.getQuestionnaries { [unowned self] (result, success) in
            SVProgressHUD.dismiss()
            guard success else {
                SVProgressHUD.showError(withStatus: result as? String)
                return
            }
            self.questionariesList = result as! [Questionnaires]
            self.collectionView.reloadData()
        }
    }
    
}

extension QuestionnairesList : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SVProgressHUD.show()
        APIManager.sharedInstance.getQuestionnariesList(withId: questionariesList[indexPath.row].id) { (result, success) in
            SVProgressHUD.dismiss()
            guard success else {
                SVProgressHUD.showError(withStatus: result as! String)
                return
            }
            let controller:QuestionariesTest = self.storyboard?.instantiateViewController(withIdentifier: "QuestionariesTest") as! QuestionariesTest
            controller.setupController(questionsList: result as! [SingleQuestion], questionTitle: self.questionariesList[indexPath.row])
            self.customPushController(controller: controller)
        }
    }
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: QuestionnairesListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionnairesListCell", for: indexPath) as! QuestionnairesListCell
        cell.titleLabel.text = questionariesList[indexPath.row].title
        cell.descriptionLabel.text = questionariesList[indexPath.row].description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionariesList.count
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 30, height: 103)
    }
    
}
