import Foundation
import SQLite

class CigaretteTableHandler: TableHandler {
    
    // Mögliche Tabelenspalten Zigaretten Tabelle
    var datum = Expression<String>("Datum")
    var userID = Expression<Int64>("UserID")
    
    //MARK: Properties
    var db: Connection
    let cigarettes: Table = Table("Zigaretten")
    init(){
        //Datenbankkommunikation aufbauen
        // let tablePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        //let tablePath = "/Volumes/Extreme 900/Project 05/QuitSmoking/Database/cigarettes.db"
        //let tablePath = "(application_home)/Library/Database/cigarettes.db"
        let tablePath = "/Users/Leon/Development/XCode/Git_repository/QuitSmoking/Library/Database/cigarettes.db"
        
        do{db = try Connection(tablePath)
        } catch { fatalError("Cannot connect to database")}
    }
    
    func writeToTable(valueDictionary: [String: String]) {
        do{
            try db.run(Table("Zigaretten").insert(or: .replace, datum <- valueDictionary["Datum"]!,  userID <- Int64(valueDictionary["UserID"]!)!))
        }
        catch{
            fatalError("Failed to write into Table: Zigarettes")
        }
    }

    func getRowFromTable(columnKeys: [String], identificators: [Expressible]) -> [String: String]  {
        let columnKeyExpressions: [Expressible] = getColumnKeyExpressions(columnKeys: columnKeys)
        let query = cigarettes.select(columnKeyExpressions).where(datum == Expression<String>(getStandardString(expression: identificators[0])))
        var returnDictionary: [String: String] = [:]
        do{
            for cigaretteRow in try db.prepare(query){
                for columnKey in columnKeys{
                    switch(columnKey){
                    case "UserID":
                        returnDictionary["userID"] = "\(cigaretteRow[userID])"
                    case "Datum":
                        returnDictionary["Datum"] = "\(cigaretteRow[datum])"
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
    
    private func getStandardString(expression: Expressible) -> String{
       return expression.expression.template.trimmingCharacters(in: CharacterSet.init(charactersIn: " \""))
    }
    
    private func getColumnKeyExpressions(columnKeys: [String]) -> [Expressible]{
        var columnKeyExpressions: [Expressible] = []
        for columnKey in columnKeys{
            switch(columnKey){
            case "UserID":
                columnKeyExpressions.append(Expression<Int64>(columnKey))
            case "Datum":
                columnKeyExpressions.append(Expression<String>(columnKey))
            default:
                fatalError("Not able to cast " + columnKey + " to any type of Expression")
            }
        }
        return columnKeyExpressions
    }
    
    func getRowsOfDateSpan(startDate: String, endDate: String) -> [[String:String]] {

        //let stmt = try db.prepare("SELECT * FROM Zigaretten WHERE Datum BETWEEN startDate AND endDate")
        return self.getStatementRows(query: cigarettes.filter(startDate...endDate ~= datum))
      
    }
    
    func getRowsOfDay(date: String) -> [[String:String]] {

        //let stmt = try db.prepare("SELECT * FROM Zigaretten WHERE Datum = '\(date)'")
        return self.getStatementRows(query: cigarettes.filter(datum == date))
    }
    
    private func getStatementRows(query: Table) -> [[String:String]]{
        var result: [[String:String]] = []
        do{
            let stmt = try db.prepare(query)
            for (row) in stmt {
                var rowDictionary: [String:String] = [:]
                rowDictionary["Datum"] = try row.get(datum)
                rowDictionary["userID"] = String(try row.get(userID))
                result.append(rowDictionary)
            }
        }catch{
            fatalError("Failed to read from Table: Zigarettes")
        }
        return result
    }
    
}
