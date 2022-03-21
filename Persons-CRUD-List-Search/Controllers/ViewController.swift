//
//  ViewController.swift
//  Persons-CRUD-List-Search
//
//  Created by Cihan Çallı on 21.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var personTableView: UITableView!
    
    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = ["Ahmet","Ece","Zeynep","Mehmet","Talat"]
        
        personTableView.delegate = self
        personTableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            
        }
        
        if segue.identifier == "toUpdate" {
            
        }
    }


}

extension ViewController: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell",
                                                 for: indexPath) as! PersonCellTableViewCell
        cell.PersonTextLabel.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {
            (action:UITableViewRowAction,indexPath:IndexPath) -> Void in
            print("Sil Tıklandı \(self.list[indexPath.row])")
        })
        
        let updateAction = UITableViewRowAction(style: .normal, title: "Update", handler: {
            (action:UITableViewRowAction,indexPath:IndexPath) -> Void in
            print("Güncelle Tıklandı \(self.list[indexPath.row])")
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        })
        return [deleteAction,updateAction]
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         print("Arama sonuç \(searchText )")
    }
    
}
