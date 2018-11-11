//
//  WriteDataHolder.swift
//  QuitSmoking
//
//  Created by Leon Burmeister on 09.11.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import SQLite

class ColumnNameWrapper{
    
    var writeInt64Exp: Expression<Int64>?
    var writeStringExpr: Expression<String>?
    
    init(){}
}

