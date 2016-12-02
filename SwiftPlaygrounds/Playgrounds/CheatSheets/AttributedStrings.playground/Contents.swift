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
