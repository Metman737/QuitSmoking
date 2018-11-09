//
//  WriteStrategy.swift
//  QuitSmoking
//
//  Created by Leon Burmeister on 09.11.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import SQLite

protocol WriteStrategy{
    
    func writeToDatabase(databaseConnection: Connection,tableName: String, columnKey: WriteDataHolder, value: String) throws
    
}
