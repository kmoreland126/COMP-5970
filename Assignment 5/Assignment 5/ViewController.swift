//
//  ViewController.swift
//  Assignment 5
//
//  Created by Kate Moreland on 6/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    
    
    var storyLogic = StoryLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func answerSubmitted(_ sender: UIButton) {
        let currentNode = storyLogic.currentNode

        // If we're on a final node (no options), tapping any button restarts the story
        if currentNode.options == nil {
            storyLogic.reset()
            updateUI()
            return
        }

        // Otherwise, handle the normal choice
        guard let userChoiceText = sender.titleLabel?.text,
              let selectedChoice = currentNode.options?.first(where: { $0.text == userChoiceText }) else {
            return
        }

        storyLogic.choose(option: selectedChoice)
        updateUI()
    }
    
    func updateUI() {
        let currentNode = storyLogic.currentNode
        QuestionLabel.text = currentNode.text
        
        if let options = currentNode.options, options.count >= 2 {
            Button1.setTitle(options[0].text, for: .normal)
            Button1.isHidden = false
            
            Button2.setTitle(options[1].text, for: .normal)
            Button2.isHidden = false
        } else if let options = currentNode.options, options.count == 1 {
            Button1.setTitle(options[0].text, for: .normal)
            Button1.isHidden = false
            
            Button2.isHidden = true
        } else {
            // No options - end of story, show restart button
            Button1.setTitle("Restart", for: .normal)
            Button1.isHidden = false
            Button2.isHidden = true
        }
    }
}

