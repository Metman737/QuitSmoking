//
//  QuitSmokingTests.swift
//  QuitSmokingTests
//
//  Created by Leon Burmeister on 20.08.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import XCTest
import SQLite
import Foundation
@testable import QuitSmoking

class QuitSmokingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

    }
    
    func testReadRowsOfDateSpan(){
        
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler(path: "/Users/Leon/Development/XCode/Git_repository/QuitSmoking/QuitSmoking/Library/Database/cigarettes.db")
        
        let todayDate = Date().asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        let startDate = Date(timeIntervalSince1970: 0).asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        
        let writeArray = ["Datum": todayDate,"UserID":"2"]
        cigaretteTableHandler.writeToTable(valueDictionary: writeArray)
        
        let results: [[String:String]] = cigaretteTableHandler.getRowsOfDateSpan(startDate: startDate, endDate: todayDate)
        for result in results{
            print(result["Datum"]!)
            print(result["userID"]!)
        }
        
        XCTAssertEqual(results[results.count-1]["Datum"], todayDate)
    }
    
    func testReadRowsOfDay(){
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler(path: "/Users/Leon/Development/XCode/Git_repository/QuitSmoking/QuitSmoking/Library/Database/cigarettes.db")
        
        let todayDate = Date().asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        let writeArray = ["Datum": todayDate,"UserID":"2"]
        cigaretteTableHandler.writeToTable(valueDictionary: writeArray)
        let results: [[String:String]] = cigaretteTableHandler.getRowsOfDay(date: todayDate)
        
        XCTAssertEqual(results[results.count-1]["Datum"], todayDate)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
