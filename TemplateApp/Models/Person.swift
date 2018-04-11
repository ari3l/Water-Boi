//
//  Person.swift
//  TemplateApp
//
//  Created by Ariel Steinlauf on 4/8/18.
//  Copyright © 2018 Ariels Apps LLC. All rights reserved.
//

import Foundation

struct Person {
    var firstName: String
    var lastName: String

    static func randomPeople() -> [Person] {
        let firstNamePool = ["Ariel", "Joe", "Mike", "Tammy", "Rachel", "Chaya"]
        let lastNamePool = ["Stein", "Davis", "Johnson", "Smith", "Flay", "Levin"]

        var people = [Person]()
        for _ in 0...10 {
            let randomFirstNameIndex = Int(arc4random_uniform(UInt32(firstNamePool.count)))
            let randomLasttNameIndex = Int(arc4random_uniform(UInt32(lastNamePool.count)))

            let randomFirstName = firstNamePool[randomFirstNameIndex]
            let randomLastName = lastNamePool[randomLasttNameIndex]

            let person = Person(firstName: randomFirstName, lastName: randomLastName)

            people.append(person)
        }

        return people
    }
}

extension Person: Equatable {
    public static func == (lhs: Person, rhs: Person) -> Bool {
        return (lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName)
    }
}
