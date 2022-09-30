//
//  CharacterCollectionViewCell.swift
//  StarWarsCardGame
//
//  Created by Matthew Rawlings on 9/29/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    
    func displayImage(character: Character) {
        characterImage.image = character.photo
        characterImage.contentMode = .scaleAspectFill
        characterImage.clipsToBounds = true
    }
}
