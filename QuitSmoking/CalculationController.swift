//
//  CalculationController.swift
//  QuitSmoking
//
//  Created by Leon Burmeister on 16.11.18.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation
import SQLite

class CalculationController{
    
    func getCigarettesOfToday(cigaretteTableHandler: CigaretteTableHandler) -> String {
        
        let today = Date().asSQL().trimmingCharacters(in: CharacterSet.init(charactersIn: "\'"))
        
        if !cigaretteTableHandler.getRowsOfDay(date: today).isEmpty{
            return String(cigaretteTableHandler.getRowsOfDay(date: today).count)
        }else{
            return "0"
        }
    }
    
    func getTotalCigarettes(cigaretteTableHandler: CigaretteTableHandler) -> String {
        
        if !cigaretteTableHandler.getAllRows().isEmpty {
            let totalCigarettes = cigaretteTableHandler.getAllRows().count
            return String(totalCigarettes)
          
        }else{
            return "0"
        }
    }
    
    func getMoneySpend(cigaretteTableHandler: CigaretteTableHandler) -> String {
        let userTableHandler = UserTableHandler(path: "/Users/Leon/Development/XCode/Git_repository/QuitSmoking/QuitSmoking/Library/Database/cigarettes.db")
        let price = Int(userTableHandler.getRowFromTable(columnKeys: ["Schachtelpreis"], identificators: [Expression<Int64>("1")])["Schachtelpreis"]!)
        
        let pricePerCigarette: Double = Double(price!)/21.0
        let result: Double = Double(self.getTotalCigarettes(cigaretteTableHandler: cigaretteTableHandler))!*pricePerCigarette
        
        
        if !self.getTotalCigarettes(cigaretteTableHandler: cigaretteTableHandler).isEmpty{
            return String(result.rounded())
        }else{
            return "0"
        }
    }
    
    func getAverageSmokedPerDay(cigaretteTableHandler: CigaretteTableHandler) -> String {
        
        let total = self.getTotalCigarettes(cigaretteTableHandler: cigaretteTableHandler)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        guard let firstCigaretteDate = dateFormatter.date(from: cigaretteTableHandler.getFirstEntry()["Datum"]!) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: firstCigaretteDate)
        let date2 = calendar.startOfDay(for: Date())
        let days = calendar.dateComponents([.day], from: date1, to: date2).day
        
        let average = Int(total)!/days!
        return String(average)
    }
}
