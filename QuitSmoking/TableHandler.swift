import SQLite

protocol TableHandler {
    
    func writeToTable(valueDictionary: [String: String])
    func getRowFromTable(columnKeys: [String], identificators: [Expressible]) -> [String: String]
    
}


