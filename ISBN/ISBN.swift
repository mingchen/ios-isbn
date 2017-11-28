//
//  ISBN.swift
//  ISBN
//
//  Copyright © 2017 Ming Chen. All rights reserved.
//

import Foundation

//
// Usage example:
//
// if let isbn = ISBN("123") {
// } else {
//    // Not a valid isbn code
// }
//
class ISBN {
    var code: String = ""
    static let isbn10_regex = try! NSRegularExpression(pattern: "[0-9]{9}[0-9xX]")
    static let isbn13_regex = try! NSRegularExpression(pattern: "[0-9]{13}")

    init?(isbn10: String) {
        if ISBN.isbn10_regex.matches(in: isbn10, range: NSRange(isbn10.startIndex..., in: isbn10)).count == 0 {
            return nil
        }

        if (verifyChecksum10(isbn10)) {
            code = isbn10
        } else {
            return nil
        }
    }

    init?(isbn13: String) {
        if ISBN.isbn13_regex.matches(in: isbn13, range: NSRange(isbn13.startIndex..., in: isbn13)).count == 0 {
            return nil
        }

        if (verifyChecksum13(isbn13)) {
            code = isbn13
        } else {
            return nil
        }
    }

    func isISBN10() -> Bool {
        return code.count == 10
    }

    func isISBN13() -> Bool {
        return code.count == 13
    }

    var description: String {
        return code
    }

    fileprivate func verifyChecksum10(_ input: String) -> Bool {
        var checksum = 0

        for i in 0..<9 {
            if let intCharacter = Int(String(input[input.index(input.startIndex, offsetBy: i)])) {
                checksum += (i + 1) * intCharacter
            }
        }

        let lastOne = input[input.index(input.startIndex, offsetBy: 9)]
        if (lastOne == "X" || lastOne == "x") {
            checksum += 10 * 10
        } else {
            if let intCharacter = Int(String(input[input.index(input.startIndex, offsetBy: 9)])) {
                checksum += 10 * intCharacter
            }
        }

        return ((checksum % 11) == 0)
    }

    fileprivate func verifyChecksum13(_ input: String) -> Bool {
        let factor = [1, 3]
        var checksum = 0

        for i in 0..<12 {
            if let intCharacter = Int(String(input[input.index(input.startIndex, offsetBy: i)])) {
                print("\(factor[i%2]) * \(intCharacter)")
                checksum += factor[i % 2] * intCharacter
            }
        }

        if let lastInt = Int(String(input[input.index(input.startIndex, offsetBy: 12)])) {
            return (lastInt - ((10 - (checksum % 10)) % 10) == 0)
        }

        return false
    }
}
