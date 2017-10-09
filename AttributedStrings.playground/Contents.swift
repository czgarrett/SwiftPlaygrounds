//: Playground - noun: a place where people can play

import UIKit

// Converting HTML to attributed string
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            let options: [String:Any] = [
                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
            ]
            return try NSAttributedString(data: data, options: options, documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

var str = "<div style=\"background-color: white;\">Here\'s a <a href=\"http://www.google.com\">link</a> to Google.</div>"

str.htmlToAttributedString

str.htmlToString

// Paragraph with left and right aligned text

let paragraph = NSMutableParagraphStyle()
paragraph.alignment = .left
for tabStop in paragraph.tabStops {
    paragraph.removeTabStop(tabStop)
}
paragraph.addTabStop(NSTextTab(textAlignment: .right, location: 240.0, options: [:]))

let text = NSMutableAttributedString()

let leftAttributes = [
    NSFontAttributeName: UIFont.systemFont(ofSize: 10.0),
    NSForegroundColorAttributeName: UIColor.white,
    NSParagraphStyleAttributeName: paragraph
]

let rightAttributes = [
    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20.0),
    NSForegroundColorAttributeName: UIColor.white,
    NSParagraphStyleAttributeName: paragraph
]

let data = [
    "Carrots": 23,
    "Pears": 453,
    "Apples ": 2350
]

for (key, value) in data {
    text.append(NSAttributedString(string: key, attributes: leftAttributes))
    text.append(NSAttributedString(string: "\t\(value)\n", attributes: rightAttributes))
}

text
