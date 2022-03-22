//
//  ViewController.swift
//  Persons-CRUD-List-Search
//
//  Created by Cihan Çallı on 21.03.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var personTableView: UITableView!
    
    var isSearch = false
    var searchWord:String?
    
    var PersonsList = [Persons]()
    
    //uygulama ilk açıldığında çalışır
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // list = ["Ahmet","Ece","Zeynep","Mehmet","Talat"]
        
        personTableView.delegate = self
        personTableView.dataSource = self
        
        searchBar.delegate = self
        
        
    }
    
    //Sayfalar arası geçiş yapınca çalışır
    override func viewWillAppear(_ animated: Bool) {
        
        if isSearch {
            searchPerson(person_name: searchWord!)
        }else{
            getAllPersons()
        }
        personTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        
        if segue.identifier == "toDetail" {
            let goToViewController = segue.destination as! DetailsViewController
            goToViewController.person = PersonsList[index!]
        }
        
        if segue.identifier == "toUpdate" {
            let goToViewController = segue.destination as! UpdateViewController
            goToViewController.person = PersonsList[index!]
        }
    }
    
    func getAllPersons() {
        do{
            PersonsList = try context.fetch(Persons.fetchRequest())
        }catch {
            print(error)
        }
    }
    
    func searchPerson(person_name: String) {
        
        let fetchRequest: NSFetchRequest<Persons> = Persons.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "person_name CONTAINS %@", person_name)
        
        do{
            PersonsList = try context.fetch(fetchRequest)
        }catch {
            print(error)
        }
    }


}

extension ViewController: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = PersonsList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell",
                                                 for: indexPath) as! PersonCellTableViewCell
       // cell.PersonTextLabel.text = PersonsList[indexPath.row]
        
        cell.PersonTextLabel.text = "\(person.person_name!) - \(person.person_phone_number!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (UIContextualAction, view, boolValue) in
            
            let person = self.PersonsList[indexPath.row]
            
            self.context.delete(person)
            
            appDelegate.saveContext()
            
            if self.isSearch {
                self.searchPerson(person_name: self.searchWord!)
            }else{
                self.getAllPersons()
            }
            self.personTableView.reloadData()
            
        }
        
        let UpdateAction = UIContextualAction(style: .normal, title: "Update"){
            (UIContextualAction, view, boolValue) in
            
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,UpdateAction])
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // print("Arama sonuç \(searchText)")
        
        searchWord = searchText
        
        if searchWord == "" {
            isSearch = false
            getAllPersons()
        }else{
            isSearch = true
            searchPerson(person_name: searchWord!)
        }
        
        personTableView.reloadData()
        
    }
    
}
