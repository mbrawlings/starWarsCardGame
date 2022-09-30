//
//  FilterViewController.swift
//  StarWarsCardGame
//
//  Created by Matthew Rawlings on 9/29/22.
//

import UIKit

protocol FilterSelectionDelegate: AnyObject {
    func shuffleCharacters(faction: String)
    
}

class FilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    weak var delegate: FilterSelectionDelegate?

    @IBAction func sithButtonTapped(_ sender: Any) {
        delegate?.shuffleCharacters(faction: "sith")
        self.dismiss(animated: true)
    }
    
    @IBAction func jediButtonTapped(_ sender: Any) {
        delegate?.shuffleCharacters(faction: "jedi")
        self.dismiss(animated: true)
    }
    
}
