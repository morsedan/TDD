import XCTest
@testable import BullsEye

class BullsEyeTests: XCTestCase {
  
    var sut: BullsEyeGame!
  
    override func setUpWithError() throws {
      super.setUp()
      sut = BullsEyeGame()
      sut.startNewGame()
        
    }
  
    func testScoreIsComputed() {
        // Given
      let guess = sut.targetValue + 5
        // When
      sut.check(guess: guess)
        // Then
      XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong.")
    }
  
  func testScoreIsComputedWhenGuessLTTarget() {
      // Given
    let guess = sut.targetValue - 5
      // When
    sut.check(guess: guess)
      // Then
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong.")
  }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      sut = nil
      super.tearDown()
    }
}
