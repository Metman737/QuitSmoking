//
//  QuitSmokingUITests.swift
//  QuitSmokingUITests
//
//  Created by Leon Burmeister on 20.08.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import XCTest
@testable import QuitSmoking

class QuitSmokingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testAddButtonClicked(){
        // Button test
        
        let app = XCUIApplication()
        
        app.buttons["AddCigarrette"].tap()
        app.staticTexts["Add Cigarette"].tap()
        
        XCTAssertEqual(app.buttons["AddCigarrette"].index(ofAccessibilityElement: 1), app.buttons["AddCigarrette"].index(ofAccessibilityElement: 1))
        
        
    }
    
    func testSubmitButton(){
        
        let app = XCUIApplication()
        let textField = app.textFields["Name"]
        
        //testet ob Textfield existiert
        XCTAssertTrue(textField.exists, "Text field doesn't exist")
        
        app.buttons["Bestätigen"].tap()
        
        //Checkt den Wert des Textfields
        XCTAssertEqual(textField.value as! String, "Joey und Leon", "Text field value is not correct")

    }
    
    func testSwitchBetweenViews(){
        
        let app = XCUIApplication()
        let usersettingsimageButton = app.buttons["UserSettingsImage"]
        usersettingsimageButton.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).buttons["BackImage"].tap()
        
    }
    
    func testTextfields() {
        
        let app = XCUIApplication()
        app.textFields["Name"].tap()
        
        let element = app.otherElements.containing(.button, identifier:"AddCigarrette").children(matching: .other).element
        let textField = element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        
        textField.tap()
        textField.tap()
        element.children(matching: .other).element(boundBy: 2).children(matching: .textField).element.tap()
        
    }
}
