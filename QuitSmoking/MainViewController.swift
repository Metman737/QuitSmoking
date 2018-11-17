//
//  ViewController.swift
//  QuitSmoking
//
//  Created by Leon Burmeister on 20.08.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var addCigarette: UIButton!
    
    @IBOutlet weak var cigarettesToday: UILabel!
    @IBOutlet weak var cigarettesTotal: UILabel!
    @IBOutlet weak var moneySpend: UILabel!
    
    
    
    @IBAction func addCigaretteButtonTapped(_ sender: Any) {
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler(path: "/Users/Leon/Development/XCode/Git_repository/QuitSmoking/QuitSmoking/Library/Database/cigarettes.db")
        let currentDate = Date().asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        
        cigaretteTableHandler.writeToTable(valueDictionary: ["Datum":currentDate,"UserID":"1"])
        self.refreshCigerettesLabels()
        
    }

    override func viewDidLoad() {
        self.refreshCigerettesLabels()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refreshCigerettesLabels(){
        let calculationController = CalculationController()
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler(path: "/Users/Leon/Development/XCode/Git_repository/QuitSmoking/QuitSmoking/Library/Database/cigarettes.db")
        
        cigarettesToday.text = calculationController.getCigarettesOfToday(cigaretteTableHandler: cigaretteTableHandler)
        cigarettesTotal.text = calculationController.getTotalCigarettes(cigaretteTableHandler: cigaretteTableHandler)
        moneySpend.text = calculationController.getMoneySpend(cigaretteTableHandler: cigaretteTableHandler)
        print(calculationController.getAverageSmokedPerDay(cigaretteTableHandler: cigaretteTableHandler))
    }
}
