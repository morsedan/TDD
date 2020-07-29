import XCTest
@testable import HalfTunes

class HalfTunesSlowTests: XCTestCase {
  
  var sut: URLSession!

    override func setUpWithError() throws {
      super.setUp()
      sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      sut = nil
      super.tearDown()
    }

    func testValidCallToiTunesGetsHTTPStatusCode200() {
        // Given
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
      let promise = expectation(description: "Status code: 200")
        // When
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        // Then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)
    }
  
  func testCallToiTunesCompletes() {
      // Given
      let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
    let promise = expectation(description: "Completion handler invoked")
    var statusCode: Int?
    var responseError: Error?
      // When
    let dataTask = sut.dataTask(with: url!) { data, response, error in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask.resume()
    wait(for: [promise], timeout: 5)
      // Then
    XCTAssertNil(responseError)
    XCTAssertEqual(statusCode, 200)
  }
  
  
}
