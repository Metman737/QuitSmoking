//
//  DatabaseWriter.swift
//  QuitSmoking
//
//  Created by Leon Burmeister on 06.11.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import SQLite

class Int64Writer: WriteStrategy {
 
    func writeToDatabase(databaseConnection: Connection, tableName: String, columnKey: ColumnNameWrapper, value: String) {
        do{
            try databaseConnection.run(Table(tableName).insert(or: .replace, columnKey.writeInt64Exp! <- Int64(value)!))
        }
        catch{
            fatalError("Shit sucks yo") 
        }
    }
}
