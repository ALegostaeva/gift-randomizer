//
//  ListTableViewController.swift
//  Gift randomaizer
//
//  Created by Александра Легостаева on 26/06/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNameToList))
        
        navigationItem.title = "\(listNames.count) names in list"
        navigationItem.rightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .done, target: self)
        
    }
    
    @objc func addNameToList() {
        let ac = UIAlertController(title: "Write a new name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak self, weak ac] _ in
                
                guard let newName = ac?.textFields?[0].text else { return }
                addName(newName)
                addColorForName()
                self?.tableView.reloadData()
            }))
    
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (listNames.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "NameInList", for: indexPath)
            cell.textLabel?.text = listNames[indexPath.row]
            cell.backgroundColor = colorForName[indexPath.row]
            return cell
        
    }
    
    // swap - delete gesture
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listNames.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}
