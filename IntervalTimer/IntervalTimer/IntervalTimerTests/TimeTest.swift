//
//  TimeTest.swift
//  IntervalTimerTests
//
//  Created by YoungK on 1/8/24.
//

import XCTest
@testable import IntervalTimer

final class TimeTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTimeMinus() throws {
        var time = Time(minutes: 3, seconds: 45)
        time.minus(230)
        print(time)
        XCTAssertEqual(time.totalSeconds, 0)
    }

}
