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
    
    
    let tablePath = "/Users/Leon/Development/XCode/Git_repository/QuitSmoking/Database/cigarettes.db"
    let tableName = "User"
    let columnNames: [String] = ["Name", "Geburtstdatum", "Gewicht", "Raucheranfangsjahr", "Durchschnitt", "Schachtelpreis"]
    let uiTextFieldStartValues: [String] = ["Name", "Geburtsdatum", "Anfangsjahr", "Durchschnitt"]
    
    @IBAction func onSubmitTap() {
        let valueDictionary: [String: String] = getValueDictionary()
        if arePreconditionsFulfilled(valueArray: valueDictionary){
            let userTableHandler = UserTableHandler()
            userTableHandler.writeToTable(valueDictionary: valueDictionary)
        }
    }
    
    //MARK: Override
    
    override func viewDidLoad() {
        
        //Datapicker
        let datapicker = UIDatePicker()
        datapicker.datePickerMode = UIDatePicker.Mode.date
        datapicker.addTarget(self, action: #selector(UserInformationViewController.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        birthdayTextField.inputView = datapicker
        
        super.viewDidLoad()  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    //MARK: Functions
    
    //Datapicker Funktion
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        birthdayTextField.text = formatter.string(from: sender.date)
    }
    
    private func getValueDictionary() -> [String: String] {
        let uiTextFields = getUITextFields()
        var resultDictionary: [String: String] = [:]
        for (index, columnName) in columnNames.enumerated(){
            resultDictionary[columnName] = uiTextFields[index].text ?? ""
        }
        return resultDictionary
    }
    
    private func getUITextFields() -> [UITextField]{
        let uiTextFields: [UITextField] = [nameTextField, birthdayTextField, weightTextField, startYearTextField, averageTextFIeld, priceTextField]
        return uiTextFields
    }
    
    private func arePreconditionsFulfilled(valueArray: [String: String]) -> Bool{
        if checkRequiredFields(valueArray: valueArray).isEmpty{
                return true
        }
        return false
    }
    
    private func checkRequiredFields(valueArray: [String: String]) -> [String]{
        var resultKeys: [String] = []
        let requiredFieldKeys: [String] = ["Name", "Raucheranfangsjahr", "Durchschnitt", "Schachtelpreis"]
        for requiredFieldKey in requiredFieldKeys{
            if valueArray[requiredFieldKey] == "" {
                resultKeys.append(requiredFieldKey)
            }
        }
        return resultKeys
    }

    /**
    private func checkFormatting(valueArray: [String: String]) -> [String]{
        var resultKeys: [String]
        for key in valueArray.keys {
            switch (key){
                case ""
            }
            
        }
  
        return true
    }
     **/
}

