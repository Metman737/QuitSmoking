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
    
    func testReadFromDatabase(){
        let columns: [String] = ["Datum", "Uhrzeit"]
        var keys: [Expressible] = []
        keys.append(Expression<String>("18.11.2018"))
        keys.append(Expression<String>("22:30"))
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler()
        
        let results: [String: String] = cigaretteTableHandler.getRowFromTable(columnKeys: columns, identificators: keys)
        XCTAssertEqual(results["Uhrzeit"], "22:30")
        XCTAssertEqual(results["Datum"], "18.11.2018")
    }
    
    func testWriteAndRead(){
        
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler()
        let columns: [String] = ["Datum", "Uhrzeit"]
        var keys: [Expressible] = []
        
        keys.append(Expression<String>("23.11.2017"))
        keys.append(Expression<String>("18:00"))
        
        let writeArray = ["Datum":"23.11.2017","Uhrzeit":"18:00","UserID":"2"]
        cigaretteTableHandler.writeToTable(valueDictionary: writeArray)
        
        let results: [String: String] = cigaretteTableHandler.getRowFromTable(columnKeys: columns, identificators: keys)
        
        XCTAssertEqual(results["Uhrzeit"], "18:00")
        XCTAssertEqual(results["Datum"], "23.11.2017")
        
    }
    
    func testReadRowsOfDateSpan(){
        
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler()
        
        let todayDate = Date().asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        let startDate = Date(timeIntervalSince1970: 0).asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        let time = "16:00"
        
        let writeArray = ["Datum": todayDate,"Uhrzeit": time,"UserID":"2"]
        cigaretteTableHandler.writeToTable(valueDictionary: writeArray)
        
        let results: [[String:String]] = cigaretteTableHandler.getRowsOfDateSpan(startDate: startDate, endDate: todayDate)
        for result in results{
            print(result["Datum"]!)
            print(result["Uhrzeit"]!)
            print(result["userID"]!)
        }
        
        
        XCTAssertEqual(results[0]["Uhrzeit"], time)
        XCTAssertEqual(results[0]["Datum"], todayDate)
    }
    
    func testReadRowsOfDay(){
        
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler()
        
        let todayDate = Date().asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        let time = "14:00"
        
        let writeArray = ["Datum": todayDate,"Uhrzeit": time,"UserID":"2"]
        cigaretteTableHandler.writeToTable(valueDictionary: writeArray)
        
        let results: [[String:String]] = cigaretteTableHandler.getRowsOfDay(date: todayDate)
        
        XCTAssertEqual(results[0]["Uhrzeit"], time)
        XCTAssertEqual(results[0]["Datum"], todayDate)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
