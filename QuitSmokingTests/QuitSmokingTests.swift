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
        
        let todayDate = Date().asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        let startDate = Date(timeIntervalSince1970: 0).asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        
        keys.append(Expression<String>(todayDate))
        keys.append(Expression<String>("22:30"))
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler()
        
        //cigaretteTableHandler.getRowsOfDay(date: "10-22-2018")
        cigaretteTableHandler.getRowsOfDateSpan(startDate: startDate, endDate: todayDate)
        
        let results: [String: String] = cigaretteTableHandler.getRowFromTable(columnKeys: columns, identificators: keys)
        XCTAssertEqual(results["Uhrzeit"], "22:30")
        XCTAssertEqual(results["Datum"], todayDate)
    }
    
    func testWriteAndRead(){
        
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler()
        let columns: [String] = ["Datum", "Uhrzeit"]
        var keys: [Expressible] = []
        
        keys.append(Expression<String>("11-23-2017"))
        keys.append(Expression<String>("18:00"))
        
        let writeArray = ["Datum":"11-23-2017","Uhrzeit":"18:00","UserID":"2"]
        cigaretteTableHandler.writeToTable(valueDictionary: writeArray)
        
        let results: [String: String] = cigaretteTableHandler.getRowFromTable(columnKeys: columns, identificators: keys)
        
        XCTAssertEqual(results["Uhrzeit"], "18:00")
        XCTAssertEqual(results["Datum"], "11-23-2017")
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
