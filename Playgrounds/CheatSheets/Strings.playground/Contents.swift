//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let start = str.startIndex
let mid = str.index(start, offsetBy: 4)
str.substring(with: mid ..< str.index(after: mid))

let emoji = "👨🏼‍💻"
emoji.characters.count

let range = emoji.startIndex ..< emoji.characters.index(emoji.startIndex, offsetBy: 2)
emoji[range]

var unmodified = ""

enum SkinTone: String {
    case 🏻
    case 🏼
    case 🏽
    case 🏾
    case 🏿
    
    static var all = [🏻,🏼,🏽,🏾,🏿]
    static var skinToneScalars: Set<UnicodeScalar> {
        var characters = Set<UnicodeScalar>()
        for tone in SkinTone.all {
            for character in tone.rawValue.unicodeScalars {
                characters.insert(character)
            }
        }
        return characters
    }
}

extension String {
    var unicodeName: String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToUnicodeName, false)
        return mutableString as String
    }
}


SkinTone.🏿.rawValue.unicodeScalars.count

let toneCharacters = SkinTone.skinToneScalars

for character in emoji.unicodeScalars {
    print(character)
    print(character.debugDescription)
    if !toneCharacters.contains(character) {
        unmodified.append(Character(character))
    }
}
unmodified

let modifiableEmojis = Set([
    "🙌","👏","👋","👍","👎","👊","✌️","👌","✋","👐","💪","🙏","☝️","👆","👇","👈","👉","🖕","🖖","✍️",
    "💅","👂","👃","👶","👦","👧","👨","👩","👱","👴","👵","👲",
    "👳","👮","👷","💂","🎅","👼","👸","👰","🚶","🏃","💃","🙇","💁","🙅","🙆","🙋","🙎","🙍","💇","💆"])

let modifiableScalars = modifiableEmojis.map { $0.unicodeScalars.first! }


var newlyModified = ""
for scalar in unmodified.unicodeScalars {
    newlyModified.append(Character(scalar))
    if modifiableScalars.contains(scalar) {
        newlyModified.append(SkinTone.🏾.rawValue.characters.first!)
    }
}

newlyModified

unmodified

var s1 = Set(["one", "two", "three"])
var s2 = Set(["two", "one", "three"])
var s3 = Set(["two", "one", "four"])
s1 == s2
s1 == s3

