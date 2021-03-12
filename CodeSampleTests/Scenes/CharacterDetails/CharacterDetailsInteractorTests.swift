//
//  CharacterDetailsInteractorTests.swift
//  CodeSampleTests
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//

@testable import CodeSample
import RxSwift
import XCTest

fileprivate final class CharacterDetailsPresenterMock: CharacterDetailsPresenting {
    var display: CharacterDetailsDisplayable?
    
    var didPresentCharacter = 0
    var characterDisplay: Display<Character>?
    
    func presentCharacter(_ character: Display<Character>) {
        didPresentCharacter += 1
        characterDisplay = character
    }
    
    func presentNextStep(_ action: CharacterDetailsAction) {
        //
    }
}

fileprivate final class CharacterDetailsServiceMock: CharacterDetailsServicing {
    var expectedResult: Observable<[EpisodeResponse]> = .just([.init(name: "Ep 1", airDate: "01/01/2001", episode: "Ep 1", characters: [])])
    
    func requestMultipleEpisodes(_ episodeUrls: [String]) -> Observable<[EpisodeResponse]> {
        expectedResult
    }
}

extension Display where Value == Character {
    public static func == (
        lhs: Display<Value>,
        rhs: Display<Value>
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

final class CharacterDetailsInteractorTests: XCTestCase {
    fileprivate let presenterMock = CharacterDetailsPresenterMock()
    fileprivate let serviceMock = CharacterDetailsServiceMock()
    fileprivate let character = Character(
        id: 1,
        name: "Vini",
        status: .alive,
        species: "Human",
        image: "",
        lastLocation: .init(name: "Earth"),
        origin: .init(name: "Earth"),
        gender: .male,
        episodes: [],
        episodesUrls: []
    )
    
    lazy var sut = CharacterDetailsInteractor(
        presenter: presenterMock,
        service: serviceMock,
        character: character
        )
    
//    func testLoadCharacter_WhenRequestSucceeds_ShowPresentCharacter() {
//        sut.loadCharacters()
//        XCTAssertEqual(presenterMock.didPresentCharacter, 2)
//        XCTAssertTrue(presenterMock.characterDisplay ?? .idle == .success(character))
//    }
//
//    func testLoadCharacter_WhenRequestFails_ShowPresentFailure() {
//        let error = Display<Character>.failure(NetworkError.unavailableUrl, nil)
//        serviceMock.expectedResult = .error(NetworkError.unavailableUrl)
//        sut.loadCharacters()
//        XCTAssertEqual(presenterMock.didPresentCharacter, 2)
//        XCTAssertTrue(presenterMock.characterDisplay ?? .idle == error)
//    }
}
