//
//  DetailsViewController.swift
//  Persons-CRUD-List-Search
//
//  Created by Cihan Çallı on 21.03.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailPersonNameLabel: UILabel!
    @IBOutlet weak var detailPersonPhoneNumberLabel: UILabel!
    
    var person: Persons?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = person {
            detailPersonNameLabel.text =  p.person_name
            detailPersonPhoneNumberLabel.text = p.person_phone_number
        }
    }

}
