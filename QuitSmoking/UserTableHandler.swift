import Foundation
import SQLite

class UserTableHandler: TableHandler {

    // Mögliche Tabelenspalten User Tabelle
    var userID = Expression<Int64>("id")
    var userGeburtsdatum = Expression<String>("Geburtsdatum")
    var userName = Expression<String>("Name")
    var userGewicht = Expression<Int64>("Gewicht")
    var userRaucherSeit = Expression<String>("Raucheranfangsjahr")
    var userDurchschnitt = Expression<Int64>("Durchschnitt")
    var userSchachtelpreis = Expression<Int64>("Schachtelpreis")
    
    //MARK: Properties
    var db: Connection
    let user: Table = Table("User")
    init(){
        //Datenbankkommunikation aufbauen
        let tablePath = "/Volumes/Extreme 900/Project 05/QuitSmoking/Database/cigarettes.db"
        //let tablePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        do{db = try Connection(tablePath)
        } catch { fatalError("Cannot connect to database")}
    }
    
    func writeToTable(valueDictionary: [String: String]) {
        do{
            try db.run(user.insert(or: .replace, userID <- 1, userGeburtsdatum <- valueDictionary["Geburtstdatum"]!, userName <- valueDictionary["Name"]!, userGewicht <- Int64(valueDictionary["Gewicht"]!)!, userRaucherSeit <- valueDictionary["Raucheranfangsjahr"]!, userDurchschnitt <- Int64(valueDictionary["Durchschnitt"]!)!, userSchachtelpreis <- Int64(valueDictionary["Schachtelpreis"]!)!))
        }
        catch{
            fatalError("Failed to write into Table: User")
        }
    }

    func getRowFromTable(columnKeys: [String], identificators: [Expressible]) -> [String: String] {
        let columnKeyExpressions: [Expressible] = getColumKeyExpressions(columnKeys: columnKeys)
        let query = user.select(columnKeyExpressions).where(userID == Expression<Int64>(getStandardString(expression: identificators[0])))
        var returnDictionary: [String: String] = [:]
        do{
            for userRow in try db.prepare(query){
                for columnKey in columnKeys {
                    switch(columnKey){
                    case "id":
                        returnDictionary["id"] = "\(userRow[userID])"
                    case "Gewicht":
                        returnDictionary["Gewicht"] = "\(userRow[userGewicht])"
                    case "Durchschnitt":
                        returnDictionary["Durchschnitt"] = "\(userRow[userDurchschnitt])"
                    case "Schachtelpreis":
                        returnDictionary["Schachtelpreis"] = "\(userRow[userSchachtelpreis])"
                    case "Geburtsdatum":
                        returnDictionary["Geburtsdatum"] =  "\(userRow[userGeburtsdatum])"
                    case "Name":
                        returnDictionary["Name"] = "\(userRow[userName])"
                    case "Raucheranfangsjahr":
                        returnDictionary["Raucheranfangsjahr"] = "\(userRow[userID])"
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
        let returnString: String = expression.expression.template.trimmingCharacters(in: CharacterSet.init(charactersIn: " \""))
        return returnString
    }
    
    private func getColumKeyExpressions(columnKeys: [String]) -> [Expressible]{
        var columnKeyExpressions: [Expressible] = []
        for columnKey in columnKeys{
            switch(columnKey){
            case "id", "Gewicht", "Durchschnitt", "Schachtelpreis":
                columnKeyExpressions.append(Expression<Int64>(columnKey))
            case "Geburtsdatum", "Name", "Raucheranfangsjahr":
                columnKeyExpressions.append(Expression<String>(columnKey))
            default:
                fatalError("Not able to cast " + columnKey + " to any type of Expression")
            }
        }
        return columnKeyExpressions
    }
}
