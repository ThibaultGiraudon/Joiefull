//
//  JoiefullTests.swift
//  JoiefullTests
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import XCTest
@testable import Joiefull

final class JoiefullTests: XCTestCase {
    func testviewModelfetchClothesShouldSucceed() async {
        let sessionFake = URLSessionFake()
        guard let data = FakeData().correctData else {
            XCTFail("Failed to load correct data")
            return
        }
        sessionFake.data = data
        sessionFake.response = FakeData().correctResponse
        
        let viewModel = ClothesViewModel(session: sessionFake)
        
        await viewModel.fetchClothes()
        
        XCTAssertEqual(viewModel.clothes, FakeData().clothes)
        XCTAssertEqual(viewModel.clothes[0].categoryItem, .accessories)
        XCTAssertEqual(viewModel.clothes[1].categoryItem, .shoes)
        XCTAssertEqual(viewModel.clothes[2].categoryItem, .top)
        XCTAssertEqual(viewModel.clothes[3].categoryItem, .bottoms)
        XCTAssertEqual(viewModel.clothes[4].categoryItem, .none)
    }
    
    func testviewModelUpdateInfoShouldSucceed() async {
        let sessionFake = URLSessionFake()
        guard let data = FakeData().correctData else {
            XCTFail("Failed to load correct data")
            return
        }
        sessionFake.data = data
        sessionFake.response = FakeData().correctResponse
        
        let viewModel = ClothesViewModel(session: sessionFake)
        
        await viewModel.fetchClothes()
        
        guard var cloth = FakeData().clothes?.first(where: {$0.id == 1}) else {
            XCTFail("Failed to get id 1 cloth")
            return
        }
        
        cloth.name = "new name"
        viewModel.updateInfo(for: cloth)
        
        guard let changedCloth = viewModel.clothes.first(where: { $0.id == 1 }) else {
            XCTFail("Failed to get id 1 cloth")
            return
        }
        
        XCTAssertEqual(cloth, changedCloth)
    }
    
    func testviewModelUpdateInfoShouldFailed() async {
        let sessionFake = URLSessionFake()
        guard let data = FakeData().correctData else {
            XCTFail("Failed to load correct data")
            return
        }
        sessionFake.data = data
        sessionFake.response = FakeData().correctResponse
        
        let viewModel = ClothesViewModel(session: sessionFake)
        
        await viewModel.fetchClothes()
        
        guard var cloth = FakeData().clothes?.first(where: {$0.id == 1}) else {
            XCTFail("Failed to get id 1 cloth")
            return
        }
        
        cloth.name = "new name"
        cloth.id = 333
        viewModel.updateInfo(for: cloth)
        
        XCTAssertEqual(FakeData().clothes, viewModel.clothes)
    }
    
    func testviewModelfetchClothesShouldFailedWithBadURL() async {
        let sessionFake = URLSessionFake()
        sessionFake.response = FakeData().badResponse
        
        let viewModel = ClothesViewModel(session: sessionFake)
        
        await viewModel.fetchClothes()
        
        XCTAssertEqual(viewModel.showError, true)
        XCTAssertEqual(viewModel.errorMessage, "Erreur serveur (code 400).")
    }
    
    func testviewModelfetchClothesShouldFailedWithInvalidReponse() async {
        let sessionFake = URLSessionFake()
        sessionFake.response = FakeData().badResponse2
        
        let viewModel = ClothesViewModel(session: sessionFake)
        
        await viewModel.fetchClothes()
        
        XCTAssertEqual(viewModel.showError, true)
        XCTAssertEqual(viewModel.errorMessage, "Réponse du serveur invalide.")
    }
    
    func testviewModelfetchClothesShouldFailedWithDecodingError() async {
        let sessionFake = URLSessionFake()
        sessionFake.response = FakeData().correctResponse
        
        let viewModel = ClothesViewModel(session: sessionFake)
        
        await viewModel.fetchClothes()
        
        XCTAssertEqual(viewModel.showError, true)
        XCTAssertEqual(viewModel.errorMessage, "Erreur de format des données.")
    }
    
    func testviewModelfetchClothesShouldFailedWithURLErrorTimeOut() async {
        let sessionFake = URLSessionFake()
        sessionFake.error = URLError(.timedOut)
        
        let viewModel = ClothesViewModel(session: sessionFake)
        
        await viewModel.fetchClothes()
        
        XCTAssertEqual(viewModel.showError, true)
        XCTAssertEqual(viewModel.errorMessage, "Problème de connexion internet.")
    }
    
    func testviewModelfetchClothesShouldFailedWithMachErrorAborted() async {
        let sessionFake = URLSessionFake()
        sessionFake.error = MachError(.aborted)
        
        let viewModel = ClothesViewModel(session: sessionFake)
        
        await viewModel.fetchClothes()
        
        XCTAssertEqual(viewModel.showError, true)
        XCTAssertEqual(viewModel.errorMessage, "Erreur réseau inattendue.")
    }
}
