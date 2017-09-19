//: Playground - noun: a place where people can play

import UIKit
import GameplayKit

class TemperatureRule: GKRule {
    override func evaluatePredicate(in system: GKRuleSystem) -> Bool {
        print("Evaluating \(type(of: self))")
        if system.state["temperature"] as? Double != nil && system.grade(forFact: "willPrecipitate" as NSObjectProtocol) > 0.0 {
            return true
        } else {
            return false
        }
    }
    override func performAction(in system: GKRuleSystem) {
        print("Performing action for \(type(of: self))")
        let temp = system.state["temperature"] as! Double
        let fact = "frozen" as NSObjectProtocol
        if temp < 30.0 {
            system.assertFact(fact, grade: 1.0)
        } else if temp > 34.0 {
            system.assertFact(fact, grade: 0.0)
        } else {
            system.assertFact(fact, grade: 0.5)
        }
    }
}

class PrecipitationRule: GKRule {
    override func evaluatePredicate(in system: GKRuleSystem) -> Bool {
        print("Evaluating \(type(of: self))")
        if system.state["dewPoint"] as? Double != nil {
            return true
        } else {
            return false
        }
    }
    override func performAction(in system: GKRuleSystem) {
        print("Performing action for \(type(of: self))")
        let dewPoint = system.state["dewPoint"] as! Double
        let temp = system.state["temperature"] as! Double
        let fact = "willPrecipitate" as NSObjectProtocol
        if temp <= dewPoint {
            system.assertFact(fact)
        }
    }
}


let rules = [TemperatureRule(), PrecipitationRule()]
rules[0].salience = 1
rules[1].salience = 2
let system = GKRuleSystem()
system.state["temperature"] = 34.0
system.state["dewPoint"] = 34.0
system.add(rules)
system.evaluate()

