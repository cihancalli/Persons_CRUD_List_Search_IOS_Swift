//
//  UpdateViewController.swift
//  Persons-CRUD-List-Search
//
//  Created by Cihan Çallı on 21.03.2022.
//

import UIKit

class UpdateViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var updatePersonNameTextField: UITextField!
    @IBOutlet weak var updatePersonPhoneNumberTextField: UITextField!
    
    var person: Persons?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let p = person {
            updatePersonNameTextField.text =  p.person_name
            updatePersonPhoneNumberTextField.text = p.person_phone_number
        }
        
    }
    @IBAction func didUpdateButtonTapped(_ sender: Any) {
        
        if let p = person, let personName = updatePersonNameTextField.text,
           let personPhoneNumber = updatePersonPhoneNumberTextField.text {
            
            p.person_name = personName
            p.person_phone_number = personPhoneNumber
            
            appDelegate.saveContext()
            
        }
        
    }
    
}
