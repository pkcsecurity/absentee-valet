//
//  ViewController.swift
//  AbsenteeValet
//
//  Created by Kenneth Kantzer on 9/20/19.
//  Copyright © 2019 PKC Security. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100));
    let labelBig = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100));
    let labelPretext = "Small lot vacancies: "
    let labelBigPretext = "Big lot vacancies: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // add a button
        let button = UIButton(frame: CGRect(x: 50, y: 200, width: 250, height: 75))
        button.backgroundColor = UIColor(red:0.22, green:0.45, blue:0.95, alpha:1.0)
        button.setTitle("Update Parking", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        button.center = CGPoint(x: self.view.frame.size.width  / 2,
                                y: self.view.frame.size.height / 2 - 100)
        self.view.addSubview(button)
        
        // add small lot label
        label.textAlignment = .center
        label.text = labelPretext
        label.textColor = .darkGray
        label.font = label.font.withSize(22)
        label.center = CGPoint(x: self.view.frame.size.width  / 2,
                               y: self.view.frame.size.height / 2 + 100)
        self.view.addSubview(label)
        
        // add big lot label
        labelBig.textAlignment = .center
        labelBig.text = labelBigPretext
        labelBig.textColor = .darkGray
        labelBig.font = labelBig.font.withSize(22)
        labelBig.center = CGPoint(x: self.view.frame.size.width  / 2,
                               y: self.view.frame.size.height / 2 + 150)
        self.view.addSubview(labelBig)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        if let url = URL(string: "https://axryf1np09.execute-api.us-east-1.amazonaws.com/dev/parking") {
            // Create Request
            let request = URLRequest(url: url)

            // Create Data Task
            let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                guard let dataResponse = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return }
                do{
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        dataResponse, options: [])
                    print(jsonResponse) //Response result
                    let jsonDict = jsonResponse as! [String: Any]
                    let carCountArray = jsonDict["carCount"] as! [Int]
                    let smallLot = carCountArray[0]
                    let smallLotVacancy = 4 - smallLot
                    let bigLot = carCountArray[1]
                    let bigLotVacancy = 6 - bigLot
                    //print(jsonDict)
                    
                    DispatchQueue.main.async {
                        self.label.text = self.labelPretext + String(smallLotVacancy)
                        self.labelBig.text = self.labelBigPretext + String(bigLotVacancy)
                    }
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
            })
            dataTask.resume()
        }
    }
}

