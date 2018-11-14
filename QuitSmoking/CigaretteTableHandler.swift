import Foundation
import SQLite

class CigaretteTableHandler: TableHandler {
    
    // Mögliche Tabelenspalten Zigaretten Tabelle
    var datum = Expression<String>("Datum")
    var uhrzeit = Expression<String>("Uhrzeit")
    var userID = Expression<Int64>("UserID")
    
    //MARK: Properties
    var db: Connection
    let cigarettes: Table = Table("Zigaretten")
    init(){
        //Datenbankkommunikation aufbauen
        let tablePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        //let tablePath = "/Volumes/Extreme 900/Project 05/QuitSmoking/Database/cigarettes.db"
        do{db = try Connection(tablePath)
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
        let columnKeyExpressions: [Expressible] = getColumnKeyExpressions(columnKeys: columnKeys)
        let query = cigarettes.select(columnKeyExpressions).where(userID == ID)
        var returnDictionary: [String: String] = [:]
        do{
            for cigaretteRow in try db.prepare(query){
                for columnKey in columnKeys{
                    switch(columnKey){
                    case "UserID":
                        returnDictionary["userID"] = "\(cigaretteRow[userID])"
                    case "Datum":
                        returnDictionary["Datum"] = "\(cigaretteRow[datum])"
                    case "Uhrzeit":
                        returnDictionary["Uhrzeit"] = "\(cigaretteRow[uhrzeit])"
                    default:
                        fatalError("Not able to retrieve RowData for the following: " + columnKey)
                    }
                }
            }
            return returnDictionary
        }
        catch{
            fatalError("Not able to read from table.")
        }
    }
    
    private func getColumnKeyExpressions(columnKeys: [String]) -> [Expressible]{
        var columnKeyExpressions: [Expressible] = []
        for columnKey in columnKeys{
            switch(columnKey){
            case "UserID":
                columnKeyExpressions.append(Expression<Int64>(columnKey))
            case "Datum", "Uhrzeit":
                columnKeyExpressions.append(Expression<String>(columnKey))
            default:
                fatalError("Not able to cast " + columnKey + " to any type of Expression")
            }
        }
        return columnKeyExpressions
    }
    
}
