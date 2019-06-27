//
//  ModelNames.swift
//  Gift randomaizer
//
//  Created by Александра Легостаева on 27/06/2019.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation
import UIKit

    
var listNames: [String] = []
var colorForName:[UIColor] = []


    func addName(_ name: String) {
        if checkName(name) {
            listNames.append(name)
        } else {
            
        }
    }

func addColorForName() {
    colorForName.append(UIColor(displayP3Red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 0.6))
}

    
    private func checkName(_ name: String) -> Bool {
        
        return true
    }
    
    func removeName(at index: Int) {
        listNames.remove(at: index)
    }
    
    func randomName() -> String{
        
        return "You"
    }
    
    func cleanList() {
        listNames.removeAll()
        colorForName.removeAll()
    }

