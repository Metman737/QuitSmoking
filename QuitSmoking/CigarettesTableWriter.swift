import Foundation
import SQLite

class CigaretteTableHandler: TableHandler {
    
    // Mögliche Tabelenspalten Zigaretten Tabelle
    var datum = Expression<String>("Datum")
    var uhrzeit = Expression<String>("Uhrzeit")
    var userID = Expression<Int64>("UserID")
    
    //MARK: Properties
    var db: Connection
    
    init(){
        //Datenbankkommunikation aufbauen
        do{db = try Connection("/Users/Leon/Development/XCode/Git_repository/QuitSmoking/Database/cigarettes.db")
        } catch { fatalError("Cannot connect to database")}
    }
    
    func writeToTable(valueDictionary: [String: String]) {
        do{
            try db.run(Table("Zigaretten").insert(or: .replace, datum <- valueDictionary["Datum"]!, uhrzeit <- valueDictionary["Uhrzeit"]!, userID <- Int64(valueDictionary["UserID"]!)!))
        }
        catch{
            fatalError("Failed to write into Table: Zigarettes")
        }
    }
    
    func readFromTable(columnKeys: [String], ID: Expression<Int64>) -> [String: String]  {
        return [:]
    }
    
    
}
