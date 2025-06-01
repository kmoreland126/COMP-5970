import UIKit

var greeting = "Hello, playground"

// My dataset that has pets names and ages
let pets: [(name: String, age: Int)] = [
    (name: "Annie", age: 14),
    (name: "Megan", age: 2),
    (name: "Checkers", age: 8),
    (name: "Buddy", age: 5),
    (name: "Whiskers", age: 10)
]

//Function that finds the average ages of the pets from the tuple
func averageAge(data: [(name: String, age: Int)]) -> Double {
    let ages = data.map {$0.age}
    let average = Double(ages.reduce(0, +)) / Double(ages.count)
    return average
}

//Filters out animals older than 5
let youngPets: [(name: String, age: Int)] = pets.filter {$0.age <= 5}

//Prints the average ages of the pets out
print("The average age of the pets is \(averageAge(data: pets))")

//Prints out the pets that are 5 or younger
print("Pets that are 5 or younger are")
for pet in youngPets {
    print(pet.name, pet.age)
}
