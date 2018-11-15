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
    @IBOutlet weak var addCigarette: UIButton!
    
    @IBAction func addCigaretteButtonTapped(_ sender: Any) {
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler()
        let currentDate = Date().asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        
        cigaretteTableHandler.writeToTable(valueDictionary: ["Datum":currentDate,"UserID":"1"])
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

