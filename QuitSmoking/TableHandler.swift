protocol TableHandler {
    
    func writeToTable(valueDictionary: [String: String])
    func readFromTable(columnKeys: [String], ID: Expression<Int64>) -> [String: String]
    
}


