//
//  QuitSmokingTests.swift
//  QuitSmokingTests
//
//  Created by Leon Burmeister on 20.08.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import XCTest
import SQLite
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
        keys.append(Expression<String>("22.10.2018"))
        keys.append(Expression<String>("22:30"))
        let cigaretteTableHandler: CigaretteTableHandler = CigaretteTableHandler()
        let results: [String: String] = cigaretteTableHandler.getRowFromTable(columnKeys: columns, identificators: keys)
        XCTAssertEqual(results["Uhrzeit"], "22:30")
        XCTAssertEqual(results["Datum"], "22.10.2018")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
