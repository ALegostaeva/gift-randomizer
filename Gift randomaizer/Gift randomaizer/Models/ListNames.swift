//
//  ModelNames.swift
//  Gift randomaizer
//
//  Created by Александра Легостаева on 27/06/2019.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation
import UIKit


class List: NSObject {
    
    private var listNames: [String]
    private var colorForName: [UIColor] = []
    
    override init() {
        self.listNames = []
        self.colorForName = []
    }
    
    init(_ list: [String]) {
        self.listNames = list
        self.colorForName = []
    }

    func getAll() ->  [String] {
        return listNames
    }
    
    func addName(_ name: String) {
        if checkName(name) {
            listNames.append(name)
            addColorForName()
        } else {
            
        }
    }
    
    private func checkName(_ name: String) -> Bool {
        
        return true
    }
    
    private func addColorForName() {
        colorForName.append(UIColor(displayP3Red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 0.6))
    }
    
    func colorForName(at i: Int) -> UIColor{
        return colorForName[i]
    }
    
    func countNames() -> Int {
        return listNames.count
    }
    
    func readName(at i: Int) -> String{
        return listNames[i]
    }
    
    func removeName(at index: Int) {
        listNames.remove(at: index)
        colorForName.remove(at: index)
    }
    
    func cleanList() {
        listNames.removeAll()
        colorForName.removeAll()
    }
    
    func isListEmpty() -> Bool{
        return listNames.isEmpty
    }
    
}


