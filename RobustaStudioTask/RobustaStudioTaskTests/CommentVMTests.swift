//
//  CommentsVMTests.swift
//  RobustaStudioTaskTests
//
//  Created by ahmed moharam on 12/09/2021.
//

import XCTest
@testable import RobustaStudioTask

private struct constants {
    static var comment: CommentModel {
        let comment = CommentModel()
        comment.body = "Ios developer .... etc"
        return comment
    }
}

class CommentVMTests: XCTestCase {
    
    
    //MARK: - Properties
    fileprivate var commentVM: CommentVMProtocol!
    
    override func setUpWithError() throws {
        commentVM = CommentVM(comment: constants.comment)
    }
    
    //MARK: - Test Methods
    func testPropertiesRetriever() {
        XCTAssertEqual(commentVM.body, constants.comment.body)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
