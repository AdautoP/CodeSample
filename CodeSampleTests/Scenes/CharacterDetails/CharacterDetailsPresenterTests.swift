//
//  CharacterDetailsPresenterTests.swift
//  CodeSampleTests
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//

@testable import CodeSample
import XCTest

fileprivate final class CharacterDetailsCoordinatorMock: CharacterDetailsCoordinating {
    var didCallActionCount = 0
    var action: CharacterDetailsAction?
    
    func perform(_ action: CharacterDetailsAction) {
        didCallActionCount += 1
        self.action = action
    }
}

fileprivate final class CharacterDetailsViewControllerMock: CharacterDetailsDisplayable {
    var didDisplayCharacterScreenData = 0
    var characterScreenData: Display<CharacterScreenData>?
    
    func displayCharacterScreenData(_ data: Display<CharacterScreenData>) {
        didDisplayCharacterScreenData += 1
        characterScreenData = data
    }
}

extension Display where Value == CharacterScreenData {
    public static func == (
        lhs: Display<CharacterScreenData>,
        rhs: Display<CharacterScreenData>
    ) -> Bool {
        if lhs.value.self == rhs.value.self {
            switch (lhs, rhs) {
            case (.idle, .idle):return true
            case (.loading, .loading): return true
            case (.failure, .failure): return true
            case (.success, .success): return true
            default: return false
            }
        } else {
            return false
        }
    }
}

final class CharacterDetailsPresenterTests: XCTestCase {
    fileprivate let coordinatorMock = CharacterDetailsCoordinatorMock()
    fileprivate let controllerMock = CharacterDetailsViewControllerMock()
    
    lazy var sut = CharacterDetailsPresenter(coordinator: coordinatorMock)
    
    func testPresentNextStep_ShouldCallCoordinator() {
        sut.presentNextStep(.confirm)
        XCTAssertEqual(coordinatorMock.didCallActionCount, 1)
        XCTAssertEqual(coordinatorMock.action, .confirm)
    }
    
    func testPresenterCharacter_ShouldDisplayCharacter() {
        sut.display = controllerMock
        sut.presentCharacter(.loading)
        XCTAssertEqual(controllerMock.didDisplayCharacterScreenData, 1)
        XCTAssertTrue(controllerMock.characterScreenData ?? .idle == .loading)
    }
}
