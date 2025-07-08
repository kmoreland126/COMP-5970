//
//  StoryLogic.swift
//  Assignment 5
//
//  Created by Kate Moreland on 6/18/25.
//

struct StoryLogic {
    
    var currentNodeID: String = "Start"
    
    let story: [String: StoryNode] = [
        "Start": StoryNode (
        id: "Start",
        text: "There is a murder at a home. You are at the crime scene. What do you do first?",
        options: [
            Choice(text: "Look for clues", nextNodeID: "clues"),
            Choice(text: "Start questioning people", nextNodeID: "question")
        ]
        ),
        "clues": StoryNode (
            id: "clues",
            text: "You find a bloody knife with mustard on it.",
            options: [
                Choice(text: "Check who likes mustard", nextNodeID: "mustard"),
                Choice(text: "Blame it on the son", nextNodeID: "son")
            ]
        ),
        "question": StoryNode (
            id: "question",
            text: "You talk to the family and they said they last saw the man in the kitchen with the wife.",
            options: [
                Choice(text: "Arrest the wife", nextNodeID: "wife"),
                Choice(text: "If there are no cameras then it can't be proven", nextNodeID: "unknown")
            ]
        ),
        "mustard": StoryNode (
            id: "mustard",
            text: "You discover the wife loves mustard. She is arrested.",
            options: nil
        ),
        "son": StoryNode (
            id: "son",
            text: "The son is innocent. The killer goes free.",
            options: nil
        ),
        "wife": StoryNode (
            id: "wife",
            text: "The wife is the killer. You have solved the case",
            options: nil
        ),
        "unknown": StoryNode (
            id: "unknown",
            text: "The truth is unknown. The killer goes free.",
            options: nil
        )
    ]
    
    var currentNode: StoryNode {
        story[currentNodeID]!
    }
    
    mutating func choose(option: Choice) {
        currentNodeID = option.nextNodeID
    }
    
    mutating func reset() {
        currentNodeID = "Start"
    }
    
    struct StoryNode {
        let id: String
        let text: String
        let options: [Choice]?
    }
    
    struct Choice {
        let text: String
        let nextNodeID: String
    }
}
