//
//  DatabaseWriter.swift
//  QuitSmoking
//
//  Created by Leon Burmeister on 06.11.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHandler {
    
    //MARK: Properties
    var db: Connection

    // Mögliche Tabelenspalten User Tabelle
    var userID = Expression<Int64>("id")
    var userGeburtsdatum = Expression<String>("Geburtsdatum")
    var userName = Expression<String>("Name")
    var userGewicht = Expression<Int64>("Gewicht")
    var userRaucherSeit = Expression<String>("Raucheranfangsjahr")
    var userDurchschnitt = Expression<Int64>("Durchschnitt")
    var userSchachtelpreis = Expression<Int64>("Schachtelpreis")
    
    // Mögliche Tabelenspalten Zigaretten Tabelle
    var cigaretteDatum = Expression<String>("Datum")
    var cigaretteUhrzeit = Expression<String>("Uhrzeit")
    var cigaretteUserID = Expression<Int64>("UserID")
    
    
    
    init(){
        //Datenbankkommunikation aufbauen
        do{db = try Connection("./Database/cigarettes.db")
        } catch { fatalError("Can not connect to database")}
    }

   
}


