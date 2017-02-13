//
//  MainViewController.swift
//  RCI
//
//  Created by Impulse on 13.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import SVProgressHUD

class QuestionariesTest : UIViewController {
    
    @IBOutlet weak var testNumber: UILabel!
    @IBOutlet weak var testTitleLabel: UILabel!
    @IBOutlet weak var answersCollectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var testName: Questionnaires?
    var questions:[SingleQuestion] = []
    var currevaruestionIndex:Int = 0

//MARK: - Actions
    
    @IBAction func prevAction(_ sender: UIButton) {
        guard currevaruestionIndex > 0 else {
            return
        }
        currevaruestionIndex -= 1
        reloadQuestion()
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        guard questions[currevaruestionIndex].selected != -1 else {
            return
        }
        currevaruestionIndex += 1
        guard currevaruestionIndex < questions.count else {
            
            nextButton.isUserInteractionEnabled = false
            getTestResult()
            SVProgressHUD.show()
            return
        }
        
        reloadQuestion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setTitle(titleString: (testName?.title)!)
        reloadQuestion()
    }
    
    func getTestResult() {
        var answers:[Any] = []
        for question in questions {
            answers.append(["question_id":question.id, "answer_id":question.answers[question.selected].id])
        }
        APIManager.sharedInstance.postQuestionnariesResult(id: (testName?.id)!, answers: answers) { (result, success) in
            let controller:QuestionnariesResult = self.storyboard?.instantiateViewController(withIdentifier: "QuestionnariesResult") as! QuestionnariesResult
            controller.setupController(questionsList: self.questions, questionTitle: self.testName!, resultTest: result as! [String: Any])
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func reloadQuestion() {
        nextButton.backgroundColor = questions[currevaruestionIndex].selected == -1 ? .white : .defaultBlueColor
        nextButton.setTitleColor(questions[currevaruestionIndex].selected == -1 ? .defaultBlueColor : .white , for: .normal)
        pageControll.currentPage = currevaruestionIndex
        testNumber.text = "\(currevaruestionIndex+1)/\(questions.count)"
        testTitleLabel.text = questions[currevaruestionIndex].text
        answersCollectionView.reloadData()

    }
    
    func setupController(questionsList:[SingleQuestion], questionTitle:Questionnaires) {
        testName = questionTitle
        questions = questionsList
    }
    
}

extension QuestionariesTest : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: QuestionnairesListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionnairesListCell", for: indexPath) as! QuestionnairesListCell
        let answer = questions[currevaruestionIndex].answers[indexPath.row]
        if (questions[currevaruestionIndex].selected == indexPath.row) {
            cell.titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        }
        cell.titleLabel.text = answer.text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard questions.count != 0   else {
            return 0
        }
        return questions[currevaruestionIndex].answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard currevaruestionIndex < questions.count else {
            return
        }
        questions[currevaruestionIndex].selected = indexPath.row
        reloadQuestion()
    }
    
//MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 30, height: 80)
    }
}
