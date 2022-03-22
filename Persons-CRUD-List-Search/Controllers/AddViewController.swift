//
//  AddViewController.swift
//  Persons-CRUD-List-Search
//
//  Created by Cihan Çallı on 21.03.2022.
//

import UIKit

class AddViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var addPersonNameTextField: UITextField!
    @IBOutlet weak var addPersonPhoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didAddPersonButtonTapped(_ sender: Any) {
        
        if let personName = addPersonNameTextField.text,
           let personPhoneNumber = addPersonPhoneNumberTextField.text {
            
            let person = Persons(context: context)
            
            person.person_name = personName
            person.person_phone_number = personPhoneNumber
            
            appDelegate.saveContext()
        }
        
        
    }
    
}
