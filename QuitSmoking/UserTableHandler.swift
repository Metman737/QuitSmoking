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
    
    init(){
        //Datenbankkommunikation aufbauen
        do{db = try Connection("/Users/Leon/Development/XCode/Git_repository/QuitSmoking/Database/cigarettes.db")
        } catch { fatalError("Cannot connect to database")}
    }
    
    func writeToTable(valueDictionary: [String: String]) {
        do{
            try db.run(Table("User").insert(or: .replace, userID <- 1, userGeburtsdatum <- valueDictionary["Geburtstdatum"]!, userName <- valueDictionary["Name"]!, userGewicht <- Int64(valueDictionary["Gewicht"]!)!, userRaucherSeit <- valueDictionary["Raucheranfangsjahr"]!, userDurchschnitt <- Int64(valueDictionary["Durchschnitt"]!)!, userSchachtelpreis <- Int64(valueDictionary["Schachtelpreis"]!)!))
        }
        catch{
            fatalError("Failed to write into Table: User")
        }
    }
    
    func readFromTable(valueArray: String) {
    }
}
