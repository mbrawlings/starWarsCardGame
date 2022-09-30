//
//  CharacterCollectionViewController.swift
//  StarWarsCardGame
//
//  Created by Matthew Rawlings on 9/29/22.
//

import UIKit

class CharacterCollectionViewController: UICollectionViewController, FilterSelectionDelegate {
    
    private var displayedCharacters: [Character] = []
    private var targetCharacter: Character?
    private var selectedFaction = "jedi"

    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCharacters(faction: selectedFaction)
    }
    
    //MARK: - Delegate Function
    func shuffleCharacters(faction: String) {
        selectedFaction = faction
        if faction == "jedi" {
            let jediGroup = CharacterController.jedi.shuffled().prefix(3)
            displayedCharacters = Array(jediGroup)
            targetCharacter = CharacterController.sith.randomElement()
        } else if faction == "sith" {
            let sithGroup = CharacterController.sith.shuffled().prefix(3)
            displayedCharacters = Array(sithGroup)
            targetCharacter = CharacterController.jedi.randomElement()
        }
        updateViews()
        
    //MARK: - Helper Functions
    }
    func updateViews() {
        guard let character = targetCharacter else { return }
        displayedCharacters.append(character)
        displayedCharacters.shuffle()
        collectionView.reloadData()
        title = "Find \(character.name)"
    }
    func presentAlert(character: Character) {
        let success = character == targetCharacter
        let alertController = UIAlertController(title: success ? "Good job!" : "Better luck next time", message: nil, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let shuffleAction = UIAlertAction(title: "Shuffle", style: .default, handler: {_ in self.shuffleCharacters(faction: self.selectedFaction)})
        alertController.addAction(doneAction)
        if success {
            alertController.addAction(shuffleAction)
        }
        present(alertController, animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilterVC" {
            let destination = segue.destination as? FilterViewController
            destination?.delegate = self
        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return displayedCharacters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell()}
        
        let character = displayedCharacters[indexPath.row]
    
        cell.displayImage(character: character)
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = displayedCharacters[indexPath.row]
        presentAlert(character: character)
    }

}

extension CharacterCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 15, height: width + 30)
    }
}
