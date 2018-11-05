//
//  UserInformationViewController.swift
//  QuitSmoking
//
//  Created by Leon Burmeister on 05.11.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit

class UserInformationViewController: UIViewController {
    
 
    //MARK: Properties
    var nameLabel: UILabel
    var birthdayLabel: UILabel
    var weightLabel: UILabel
    var startyearLabel: UILabel
    var averageLabel: UILabel
    var packagePriceLabel: UILabel
    
    var nameTextfield: UITextInput
    var birthdayTextfield: UITextInput
    var weightTextfield: UITextInput
    var startyearTextfield: UITextInput
    var averagePriceTextfield: UITextInput
    var packegePriceTextfield: UITextInput

 
    //MARK: Initialization
    init() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
    First Name Label.Leading = Superview.LeadingMargin
    Middle Name Label.Leading = Superview.LeadingMargin
    Last Name Label.Leading = Superview.LeadingMargin
    First Name Text Field.Leading = First Name Label.Trailing + Standard
    Middle Name Text Field.Leading = Middle Name Label.Trailing + Standard
    Last Name Text Field.Leading = Last Name Label.Trailing + Standard
    First Name Text Field.Trailing = Superview.TrailingMargin
    Middle Name Text Field.Trailing = Superview.TrailingMargin
    Last Name Text Field.Trailing = Superview.TrailingMargin
    First Name Label.Baseline = First Name Text Field.Baseline
    Middle Name Label.Baseline = Middle Name Text Field.Baseline
    Last Name Label.Baseline = Last Name Text Field.Baseline
    First Name Text Field.Width = Middle Name Text Field.Width
    First Name Text Field.Width = Last Name Text Field.Width
    First Name Label.Top >= Top Layout Guide.Bottom + 20.0
    First Name Label.Top = Top Layout Guide.Bottom + 20.0 (Priority 249)
    First Name Text Field.Top >= Top Layout Guide.Bottom + 20.0
    First Name Text Field.Top = Top Layout Guide.Bottom + 20.0 (Priority 249)
    Middle Name Label.Top >= First Name Label.Bottom + Standard
    Middle Name Label.Top = First Name Label.Bottom + Standard (Priority 249)
    Middle Name Text Field.Top >= First Name Text Field.Bottom + Standard
    Middle Name Text Field.Top = First Name Text Field.Bottom + Standard (Priority 249)
    Last Name Label.Top >= Middle Name Label.Bottom + Standard
    Last Name Label.Top = Middle Name Label.Bottom + Standard (Priority 249)
    Last Name Text Field.Top >= Middle Name Text Field.Bottom + Standard
    Last Name Text Field.Top = Middle Name Text Field.Bottom + Standard (Priority 249)
    **/
    
}

