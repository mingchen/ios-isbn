//
//  ISBNTests.swift
//  ISBNTests
//
//  Created by Ming Chen on 11/14/17.
//  Copyright © 2017 ISBN. All rights reserved.
//

import XCTest
@testable import ISBN

class ISBNTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testInvalidISBN() {
        XCTAssertNil(ISBN(isbn10: ""))
        XCTAssertNil(ISBN(isbn10: "abc"))

        XCTAssertNil(ISBN(isbn13: ""))
        XCTAssertNil(ISBN(isbn13: "abc"))
    }

    func testInvalidISBN10Checksum() {
        XCTAssertNil(ISBN(isbn10: "1578700581"))
        XCTAssertNil(ISBN(isbn10: "1a78700581"))

        XCTAssertNil(ISBN(isbn10: "15787y0582"))
    }

    func testInvalidISBN13Checksum() {
        XCTAssertNil(ISBN(isbn13: "9780446563041"))
        XCTAssertNil(ISBN(isbn13: "978h446563041"))

        //XCTAssertNotNil(ISBN(isbn13: "9780446563048"))
        XCTAssertNil(ISBN(isbn13: "9780446563u48"))
    }

    func testValidISBN10() {
        XCTAssertNotNil(ISBN(isbn10: "1578700582"))
        guard let isbn = ISBN(isbn10: "1578700582") else {
            XCTFail("init failed")
            return
        }

        XCTAssertTrue(isbn.isISBN10())
        XCTAssertFalse(isbn.isISBN13())
    }

    func testValidISBN13() {
        XCTAssertNotNil(ISBN(isbn13: "9780446563048"))
        guard let isbn = ISBN(isbn13: "9780446563048") else {
            XCTFail("init failed")
            return
        }

        XCTAssertFalse(isbn.isISBN10())
        XCTAssertTrue(isbn.isISBN13())
    }
}
