//
//  UserInformationViewController.swift
//  QuitSmoking
//
//  Created by Leon Burmeister on 05.11.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit
import SQLite

class UserInformationViewController: UIViewController {
    
 
    //MARK: Properties
    
    //Name
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    //Geburtstag
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    //Gewicht in Kg
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    
    //Raucher seit ... Jahr
    @IBOutlet weak var startYearLabel: UILabel!
    @IBOutlet weak var startYearTextField: UITextField!
    
    //Durchschnitt Zigaretten pro Tag
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var averageTextFIeld: UITextField!
    
    //Schachtelpreis
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!

    @IBOutlet weak var submitButton: UIButton!
    
    let tablePath = "/Volumes/Extreme 900/Project 05/QuitSmoking/Database/cigarettes.db"
    let tableName = "User"
    let columnNames: [String] = ["id", "Geburtstdatum", "Name", "Gewicht", "Raucheranfangsjahr", "Durchschnitt", "Schachtelpreis"]
    let uiTextFieldStartValues: [String] = ["Name", "Geburtsdatum", "Anfangsjahr", "Durchschnitt"]
    
    @IBAction func onSubmitClick() {
        if areTextFieldsFilled(uiTextFields: getUITextFields()){
            let writeStrategy = StringWriter()
            let columnNameWrapper = ColumnNameWrapper()
            columnNameWrapper.writeStringExpr = Expression<String>("Name")
            do{
                try
                    writeStrategy.writeToDatabase(databaseConnection: Connection(tablePath), tableName: tableName, columnKey: columnNameWrapper, value: nameTextField.text!)
                 }
                catch{
                    fatalError("Can not connect to database")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getUITextFields() -> [UITextField]{
        let uiTextFields: [UITextField] = [nameTextField, birthdayTextField, weightTextField, startYearTextField, averageTextFIeld]
        return uiTextFields
    }
    
    private func areTextFieldsFilled(uiTextFields: [UITextField]) -> Bool{
        for uiTextField in uiTextFields {
            if uiTextField.text!.isEmpty || uiTextFieldStartValues.contains(uiTextField.text!){
                return false
            }
        }
        return true
    }
    
    
}

