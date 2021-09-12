//
//  RepositoryVMTest.swift
//  RobustaStudioTaskTests
//
//  Created by ahmed moharam on 12/09/2021.
//

import XCTest
@testable import RobustaStudioTask

private struct constants {
    static var repo: RepositoryModel {
        let repo = RepositoryModel()
        repo.name = "Ahmed Moharam"
        repo.topicDescription = "Ios developer"
        repo.commentsURL = "https://"
        repo.languagesURL = "https://"
        repo.fullRepoName = "ahmed/moharam/repo"
        repo.url = "https://"
        repo.topicPrivate = true
        repo.fork = true
        return repo
    }
}

class RepositoryVMTests: XCTestCase {

    //MARK: - Properties
    fileprivate var repoVM: RepositoryVMProtocol!
    
    override func setUpWithError() throws {
        repoVM = RepositoryVM(repo: constants.repo)
    }
    
    //MARK: - Test Methods
    func testPropertiesRetriever() {
        XCTAssertEqual(repoVM.name, constants.repo.name)
        XCTAssertEqual(repoVM.topicDescription, constants.repo.topicDescription)
        XCTAssertEqual(repoVM.commentsURL, constants.repo.commentsURL)
        XCTAssertEqual(repoVM.languageURL, constants.repo.languagesURL)
        XCTAssertEqual(repoVM.fullRepoName, constants.repo.fullRepoName)
        XCTAssertEqual(repoVM.repoURL, constants.repo.url)
//        XCTAssertEqual(repoVM.topicPrivate, "\(constants.repo.topicPrivate ?? false)")
        XCTAssertEqual(repoVM.fork, constants.repo.fork)
        XCTAssertEqual(repoVM.name, constants.repo.name)
        XCTAssertEqual(repoVM.name, constants.repo.name)
    }

    override func tearDownWithError() throws {
    }

}
