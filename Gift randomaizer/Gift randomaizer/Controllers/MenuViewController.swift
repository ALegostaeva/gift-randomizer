//
//  ViewController.swift
//  Gift randomaizer
//
//  Created by Александра Легостаева on 26/06/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak private var btnCreateList: UIButton!
    @IBOutlet weak private var btnSettings: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        // Do any additional setup after loading the view.
    }
    
    func createList() {
        
    }

    private func addView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Help", style: .plain, target: self, action: #selector(showAbout))
        navigationItem.hidesBackButton = true
    }
    
    @objc private func showAbout() {
        let message =
            
        """
        Here you can make a list of your relatives and close people.
        
        Make a list.
        Press "Randome it!".
        Ready to randomize!
        Shake the phone.
        You will see the name of person, whom you will make a present.
        If you want another name - just tap on the name and it will stay in the list and you will see a next random name.

        """
            
        let ac = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

}

