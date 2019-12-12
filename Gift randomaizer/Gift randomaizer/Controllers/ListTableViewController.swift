//
//  ListTableViewController.swift
//  Gift randomaizer
//
//  Created by Александра Легостаева on 26/06/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    private var isBtnForNextPage: Bool = false
    private var listNames = List()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNameToList))]
        
        navigationItem.title = "\(listNames.countNames()) names in list"
    }
    
    func checkBtnToNextPage() {
        if (listNames.countNames() > 1) && !isBtnForNextPage {
            isBtnForNextPage = true
            navigationItem.rightBarButtonItems?.insert(UIBarButtonItem(title: "Random it!", style: .plain, target: self, action: #selector(goRandomize)), at: 1)
        }
        if (listNames.countNames() < 2) && isBtnForNextPage {
            isBtnForNextPage = false
            navigationItem.rightBarButtonItems?.remove(at: 0)
        }
    }


    @objc func addNameToList() {
        let ac = UIAlertController(title: "Write a new name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak ac] _ in
            
            guard let newName = ac?.textFields?[0].text else { return }
            self?.listNames.addName(newName)
            self?.checkBtnToNextPage()
            self?.tableView.reloadData()
            }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (listNames.countNames())
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NameInList", for: indexPath)
        cell.textLabel?.text = listNames.readName(at: indexPath.row)
        cell.backgroundColor = listNames.colorForName(at: indexPath.row)

        return cell
        
    }
    
    // swap - delete gesture
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listNames.removeName(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade)
            checkBtnToNextPage()
        }
    }

    @objc func goRandomize() {
        if let rvc = storyboard?.instantiateViewController(withIdentifier: "RandomizerView") as? RandomizerViewController {
            rvc.names = listNames
            navigationController?.pushViewController(rvc, animated: true)
        }
    }

}
