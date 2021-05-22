//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Qiuran on 2021/5/18.
//

import UIKit

class ViewController: UIViewController {
    let questionTableView = UITableView()
    let questionReuseIdentifier = "questionReuseIdentifier"
    
    var questionData: [Question] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Daily Check"
        
        createDummyData()
        setupViews()
        setupConstrains()
    }

    func createDummyData() {
        let question1 = Question(question: "In the last 3 days, have you been feeling any different from usual? Have you had any sympotoms linked to COVID-19?")
        let question2 = Question(question: "In the past 2 weeks, have you been around someone who has tested positive for COVID-19 or someone you think might have COVID-19?")
        let question3 = Question(question: "DO you have any reason to think that you might have been exposed to COVID-19?")
        let question4 = Question(question: "Have you ever tested positive for COVID-19?")
        questionData = [question1, question2, question3, question4]
    }
    
    func setupViews() {
        questionTableView.translatesAutoresizingMaskIntoConstraints = false
        questionTableView.delegate = self
        questionTableView.dataSource = self
        questionTableView.register(QuestionTableViewCell.self , forCellReuseIdentifier: questionReuseIdentifier)
        view.addSubview(questionTableView)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            questionTableView.topAnchor.constraint(equalTo: view.topAnchor),
            questionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            questionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            questionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIScreen.main.bounds.height / 2)
         ])
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ceil = tableView.cellForRow(at: indexPath) as! QuestionTableViewCell
        let questionObject = questionData[indexPath.row]
        if let unwrappedAnswer = questionObject.answer {
            questionObject.answer = !unwrappedAnswer
        } else {
            questionObject.answer = true
        }
        ceil.setBackgroundColor(with: questionObject.answer!)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: questionReuseIdentifier, for: indexPath) as! QuestionTableViewCell
        let questionObject = questionData[indexPath.row]
//        cell.questionLabel.text = questionObject.question
        cell.configure(with: questionObject)
        return cell
    }
    
    
}
