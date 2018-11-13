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
        do{db = try Connection("/Users/Leon/Development/XCode/Git_repository/QuitSmoking/Database/cigarettes.db")
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
    
    func readFromTable(columnKeys: [String], ID: Expression<Int64>) -> [String: String] {
        let columnKeyExpressions: [Expressible]
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
        let query = user.select(columnKeyExpressions).where(userID == ID)
        var returnDictionary: [String: String]
        do{
            for user in try db.prepare(user.select(query)){
                for columnKey in columnKeys{
                    switch(columnKey){
                    case "id":
                        returnDictionary["id"] = "\(user[userID])"
                    case "Gewicht":
                            returnDictionary["Gewicht"] = "\(user[userGewicht])"
                    case "Durchschnitt":
                        returnDictionary["Durchschnitt"] = "\(user[userDurchschnitt])"
                    case "Schachtelpreis":
                        returnDictionary["Schachtelpreis"] = "\(user[userSchachtelpreis])"
                    case "Geburtsdatum":
                        returnDictionary["Geburtsdatum"] =  "\(user[userGeburtsdatum])"
                    case "Name":
                        returnDictionary["Name"] = "\(user[userName])"
                    case "Raucheranfangsjahr":
                        returnDictionary["Raucheranfangsjahr"] = "\(user[userID])"
                    default:
                        fatalError("Not able to print the following" + columnKey + " to any type of Expression")
                        }
                    }
                }
            return returnDictionary
            }
        catch{
            fatalError("Not able to read from table.")
        }
    
    }
}
