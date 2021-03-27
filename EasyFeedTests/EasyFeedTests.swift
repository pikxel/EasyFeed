//
//  EasyFeedTests.swift
//  EasyFeedTests
//
//  Created by Peter Lizak on 27/03/2021.
//

import XCTest
@testable import EasyFeed

class EasyFeedTests: XCTestCase {

    func testCallToPostService() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        var apiSuccess: Bool?
        var responseError: APIServiceError?

        // when
        let endPoint = EndPoint<[Post]>(urlParameter: nil,
                                         expectedResponseType: [Post].self,
                                         expectedResponseCode: 200,
                                         path: "posts",
                                         api: .weather)
        APIService().perform(endPoint: endPoint, completion: { success, _, error  in
            apiSuccess = success
            responseError = error
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)

        // then
        XCTAssertEqual(apiSuccess, true)
        XCTAssertNil(responseError)
    }

    func testErrorShowing() {
        let viewController = DashboardViewController()
        let nav = UINavigationController.init(rootViewController: viewController)

        viewController.presentAlert(title: "TestAlert", message: "Test", options: "", completion: {_ in })

        let exp = expectation(description: "Test after 1.5 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(nav.visibleViewController is UIAlertController)
        } else {
            XCTFail("Delay interrupted")
        }
    }
}

