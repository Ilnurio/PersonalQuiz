//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Ilnur on 06.04.2023.
//

import UIKit

final class ResultViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var animalTypeLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // избавляемся от кнопки Back в NavigationController
        navigationItem.hidesBackButton = true
        //
        let time = ContinuousClock().measure {
            updateResult()
        }
        print(time)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

 // MARK: - Private Methods
extension ResultViewController {
    private func updateResult() {
        var frequencyOfAnimals: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        
        // второй вариант цикла
//        for animal in animals {
//            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
//        }
        
        // третий вариант цикла
//        for animal in animals {
//            frequencyOfAnimals[animal, default: 0] += 1
//        }
        
        let sortedFrequentAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequentAnimal = sortedFrequentAnimals.first?.key else { return }
        
        // решение в одну строку всей логики
//        let mostFrequetnAnimal = Dictionary(grouping: answers) {$0.animal}
//            .sorted { $0.value.count > $1.value.count }
//            .first?.key
        
        updateUI(with: mostFrequentAnimal)
    }
    
    private func updateUI(with animal: Animal) {
        animalTypeLabel.text = "Вы - \(animal.rawValue)!"
        descriptionLabel.text = animal.definition
    }
}
