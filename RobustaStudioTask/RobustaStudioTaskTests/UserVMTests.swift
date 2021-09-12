//
//  UserVMTests.swift
//  RobustaStudioTaskTests
//
//  Created by ahmed moharam on 12/09/2021.
//

import XCTest
@testable import RobustaStudioTask

private struct constants {
    static var user = UserModel()
    static var isMoreSexMonths: Bool?
}

class UserVMTests: XCTestCase {
    
    //MARK: - Properties
    fileprivate var userVM: UserVMProtocol!
    
    override func setUpWithError() throws {
        constants.user.name = "Ahmed Moharam"
        constants.user.login = "ahmed/moharam"
        constants.user.avatarURL = "https://"
        constants.user.htmlURL = "https://"
        constants.user.followingURL = "https://"
        constants.user.type = "https://"
        constants.user.followersURL = "https://"
        constants.user.company = "Robusta Studio"
        constants.user.location = "Cairo"
        constants.user.url = "https://"
        constants.user.commentsURL = "https://"
        constants.user.createdAt = "2007-10-20T05:24:19Z"
        constants.user.siteAdmin = true
        userVM = UserVM(user: constants.user)
    }
    
    func testPropertiesRetriever() {
        XCTAssertEqual(userVM.name, constants.user.name)
        XCTAssertEqual(userVM.ownerUserName, constants.user.login)
        XCTAssertEqual(userVM.avatarURL, constants.user.avatarURL)
        XCTAssertEqual(userVM.gitHubRepoLink, constants.user.htmlURL)
        XCTAssertEqual(userVM.followingURL, constants.user.followingURL)
        XCTAssertEqual(userVM.followersURL, constants.user.followersURL)
        XCTAssertEqual(userVM.company, constants.user.company)
        XCTAssertEqual(userVM.location, constants.user.location)
        XCTAssertEqual(userVM.userURL, constants.user.url)
        XCTAssertEqual(userVM.commentsURL, constants.user.commentsURL)
        XCTAssertEqual(userVM.siteAdmin, constants.user.siteAdmin)
    }
    
    func testMoreThanSexMonths() {
        XCTAssertEqual(userVM.createdAt, "10 month ago, 13 years ago")
        constants.isMoreSexMonths = false
        try? setUpWithError()
    
    }
    
 
    override func tearDownWithError() throws {
        // This method is called after the invocation of each test method in the class.
    }
}
