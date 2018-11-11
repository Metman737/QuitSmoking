//
//  StringWriter.swift
//  QuitSmoking
//
//  Created by Joey Martin on 10.11.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import SQLite

class StringWriter: WriteStrategy {
    
    func writeToDatabase(databaseConnection: Connection, tableName: String, columnKey: ColumnNameWrapper, value: String) {
        do{
            try databaseConnection.run(Table(tableName).insert(or: .replace, columnKey.writeStringExpr! <- value))
        }
        catch{}
    }
}
