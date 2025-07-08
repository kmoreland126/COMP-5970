//
//  ViewController.swift
//  Assignment 4
//
//  Created by Kate Moreland on 6/14/25.
//

import UIKit

class ViewController: UIViewController {

    // Connecting elements
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var moodSlider: UISlider!
    @IBOutlet weak var savedEntry: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var saveMood: UIButton!
    
    // Slider upload
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Slider Setup
        moodSlider.minimumValue = 0
        moodSlider.maximumValue = 100
        moodSlider.value = 50 // Start in the middle
        updateMoodLabel(for: Int(moodSlider.value))
    }

    // Slider update
    @IBAction func sliderChanged(_ sender: UISlider) {
        let moodValue = Int(sender.value)
        updateMoodLabel(for: moodValue)
    }

    @IBAction func saveMood(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let selectedDate = formatter.string(from: datePicker.date)

        // Get emoji from moodLabel text (last 2 characters)
        let emoji = moodLabel.text?.suffix(2) ?? ""
        savedEntry.text = "On \(selectedDate), you felt \(emoji)"
    }

    // Mood Label
    func updateMoodLabel(for value: Int) {
        switch value {
        case 0...20:
            moodLabel.text = "Very Sad 😢"
        case 21...40:
            moodLabel.text = "Sad 🙁"
        case 41...60:
            moodLabel.text = "Neutral 😐"
        case 61...80:
            moodLabel.text = "Happy 🙂"
        case 81...100:
            moodLabel.text = "Very Happy 😄"
        default:
            moodLabel.text = "Unknown"
        }
    }
}
