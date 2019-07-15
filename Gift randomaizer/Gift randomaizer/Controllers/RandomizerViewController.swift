//
//  RandomizerViewController.swift
//  Gift randomaizer
//
//  Created by Александра Легостаева on 01/07/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit
import AudioToolbox

class RandomizerViewController: UIViewController {

    var names: List!
    private var listForRandom: List!
    private var labelForName: UILabel!
    private var labelForClue: UILabel!
    private var labelForPreviousNames: UILabel!
    private var labelForLastName:UILabel!
    private var previousNameIndex: Int?
    private var removeNames: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.becomeFirstResponder()
        
        loadNames()
        setupView()
    }
    
    func setupView() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(nextRandomName))
        
//        MARK - changing functionality of back button
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back to menu", style: .plain, target: self, action: #selector(backToMenu))
        
//        MARK - adding a label for a name
        labelForName = UILabel()
        labelForName.translatesAutoresizingMaskIntoConstraints = false
        labelForName.text = "SHAKE ME!"
        labelForName.textAlignment = .center
        labelForName.font = UIFont(name: "Party LET", size: 50.0)
        labelForName.isUserInteractionEnabled = true
        view.addSubview(labelForName)
        
        labelForName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedOnName)))
        
//        MARK - adding 2 actions: no, try next name and yep! This is good name
        labelForClue = UILabel()
        labelForClue.translatesAutoresizingMaskIntoConstraints = false
        labelForClue.text =
        """
        Shake for a next name.
        If you want another name - tap on the name.
        """
        labelForClue.textAlignment = .center
        labelForClue.font = UIFont.systemFont(ofSize: 13.0)
        labelForClue.textColor = .darkGray
        labelForClue.numberOfLines = 2
        view.addSubview(labelForClue)
        
        labelForLastName = UILabel()
        labelForLastName.translatesAutoresizingMaskIntoConstraints = false
        labelForLastName.textAlignment = .center
        labelForLastName.numberOfLines = 1
        labelForLastName.font = UIFont.systemFont(ofSize: 14.0)
        labelForLastName.textColor = .lightGray
        labelForLastName.text = ""
        view.addSubview(labelForLastName)
        
        labelForPreviousNames = UILabel()
        labelForPreviousNames.translatesAutoresizingMaskIntoConstraints = false
        labelForPreviousNames.textAlignment = .center
        labelForPreviousNames.numberOfLines = .max
        labelForPreviousNames.font = UIFont.systemFont(ofSize: 13.0)
        labelForPreviousNames.textColor = .darkGray
        labelForPreviousNames.text = ""
        view.addSubview(labelForPreviousNames)
        
        
        NSLayoutConstraint.activate([
            labelForName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelForName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelForClue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelForClue.topAnchor.constraint(equalTo: labelForName.bottomAnchor, constant: 20.0),
            labelForLastName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelForLastName.bottomAnchor.constraint(equalTo: labelForName.topAnchor, constant: -30.0),
            labelForPreviousNames.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelForPreviousNames.bottomAnchor.constraint(equalTo: labelForLastName.topAnchor, constant: 0.0)
            ])
        
    }
    
    
    func loadNames() {
        listForRandom = names ?? List(["List of names is empty"])
    }

    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion. If mobile was shaked - current name from the screen is removed from the list, randoming next name
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            debugPrint("in motionEnded", listForRandom.getAll())
            labelForName.text = randomName()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    @objc func nextRandomName() {
        debugPrint("tapped nextRandomName", listForRandom.getAll())
        labelForName.text = randomName()
    }
    
// If label with name was tapped - current name from the screen is not removed from the list, just randoming next name
    @objc func tappedOnName(sender:UITapGestureRecognizer) {
        debugPrint("Label was tapped ", listForRandom.getAll())
        removeNames = false
        labelForName.text = randomName()
    }
    
    @objc func randomName() -> String {
        //        MARK: The check if names in the list are more than 1. A name is removed from the list in the next iteration (it was done for a user's ability to skip the name without removing it from the list).
        //        If the list contains only 1 name, list will be clean up in ELSE section, because the last name already been shown.
        if listForRandom.countNames() > 1 {
            
            debugPrint("in random ", removeNames)
            
            if removeNames {
                if let j = previousNameIndex {
                    debugPrint("remove name  ", listForRandom.readName(at: j))
                    labelForPreviousNames.text?.append((labelForLastName.text ?? "") + "\n")
                    labelForLastName.text = listForRandom.readName(at: j)
                    listForRandom.removeName(at: j)
                }
            } else {
                removeNames = true
            }
            
            let i = Int.random(in: 0...listForRandom.countNames()-1)

            previousNameIndex = i
            randomColor()
            
            debugPrint("random finished ", listForRandom.getAll())
            
            return listForRandom.readName(at: i)
            
        } else {
            if !listForRandom.isListEmpty() {
                labelForPreviousNames.text?.append(listForRandom.readName(at: 0) + "\n")
                listForRandom.cleanList()
                removeNames = false
            }
            return "Names ended"
        }
    }
    
    func randomColor() {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        view.backgroundColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 0.6)
        labelForName.textColor = UIColor(displayP3Red: (1 - red), green: (1 - green), blue: (1 - blue), alpha: 0.9)
    }
    
    @objc func backToMenu() {
        if let mvc = storyboard?.instantiateViewController(withIdentifier: "MenuView") as? MenuViewController {
            listForRandom.cleanList()
            navigationController?.pushViewController(mvc, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
