//
//  QuizViewController.swift
//  Koloda
//
//  Created by Daniel Christopher on 8/7/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Alamofire

class Question {
    var question: String?
    var correctAnswer: String?
    var answers: [String]?
}

class QuizViewController: UIViewController {
    private var questions: [Question] = []
    var time: Float = 30.0
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelD: UILabel!
    var timer = NSTimer()
    
    var recordedAnswers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topic = "slavery"
        time = 30
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        Alamofire.request(.GET, "http://172.29.24.174:8080/?topic=\(topic)", encoding: .JSON)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .Success:
                let questions = response.result.value as! Array<Dictionary<String, AnyObject>>
                
                for q in questions {
                    let question = Question()
                    question.answers = q["answers"] as? [String]
                    question.correctAnswer = q["correct_answer"] as? String
                    question.question = q["question"] as? String
                    
                    self.questions.append(question)
                }
                
                if self.questions.count > 0 {
                    self.showQuestion(0)
                }
                
            case .Failure(let error):
                print(error)
            }
        }
    }

    @IBAction func d(sender: AnyObject) {
        recordedAnswers.append(labelD.text!)
        showQuestion(recordedAnswers.count)
    }
    
    @IBAction func c(sender: AnyObject) {
        recordedAnswers.append(labelC.text!)
        showQuestion(recordedAnswers.count)
    }
    
    @IBAction func b(sender: AnyObject) {
        recordedAnswers.append(labelB.text!)
        showQuestion(recordedAnswers.count)
    }
    
    @IBAction func a(sender: AnyObject) {
        recordedAnswers.append(labelA.text!)
        showQuestion(recordedAnswers.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func showQuestion(number: Int) {
        if number >= self.questions.count {
            // done with quiz
            print("done")
            return
        }
        

        print("\(number) out of \(self.questions.count)")
        
        let question = self.questions[number]
        
        self.questionTextView.text = question.question
        
        if question.answers != nil && question.answers?.count >= 4 {
            self.labelA.text = "A) \(question.answers![0])"
            self.labelB.text = "B) \(question.answers![1])"
            self.labelC.text = "C) \(question.answers![2])"
            self.labelD.text = "D) \(question.answers![3])"
        }
    }
    func update() {
        if(time <= 0){
            timeLabel.text = "Time Up!"
            timer.invalidate()
        }
        else{
            time = time-0.1
            timeLabel.text = String(time)+" seconds"
        }
    }
}
