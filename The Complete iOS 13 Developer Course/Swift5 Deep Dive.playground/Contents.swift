import UIKit

var str = "Hello, playground"
var name = "howon"
name.lowercased()
name.uppercased()

//integer
let myNumber = 4

50 / 4
50.0 / 4.0

// --- Predefining Type
var myString : String = "50"
// Error myString = 10

let anotherNumber : Int = Int(10.5)
let StringNumber = String(20)

var myFavorites = [2, 3, 5, 1]

// as -> casting
// any -> any Object

myFavorites.sort()


var number : Int = 1
while number <= 19 {
    print(number)
    number += 1
}

func myFunction() {
    print("hello")
}

myFunction()

var myName : String? // Optional
myName = "hello"
myName?.uppercased()

// Optionals : ? vs !
var myAge = "a"
var myInteger = (Int(myAge) ?? 0)  * 5

if let myNumber = Int(myAge) {
    print(myNumber * 5)
} else {
    print("Wrong Input")
}
