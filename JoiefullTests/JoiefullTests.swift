//
//  JoiefullTests.swift
//  JoiefullTests
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import XCTest
@testable import Joiefull

final class JoiefullTests: XCTestCase {
    func testVMfetchClothesShouldSucceed() async {
        let sessionFake = URLSessionFake()
        guard let data = FakeData().correctData else {
            XCTFail()
            return
        }
        sessionFake.data = data
        sessionFake.response = FakeData().correctResponse
        
        let vm = ClothesViewModel(session: sessionFake)
        
        await vm.fetchClothes()
        
        XCTAssertEqual(vm.clothes, FakeData().clothes)
    }
    
    func testVMfetchClothesShouldFailedWithBadURL() async {
        let sessionFake = URLSessionFake()
        sessionFake.response = FakeData().badResponse
        
        let vm = ClothesViewModel(session: sessionFake)
        
        await vm.fetchClothes()
        
        XCTAssertEqual(vm.showError, true)
        XCTAssertEqual(vm.errorMessage, "Une erreur est survenu")
    }
    
    
    func testVMfetchClothesShouldFailedWithBadServerRepsonse() async {
        let sessionFake = URLSessionFake()
        sessionFake.response = FakeData().badResponse2
        
        let vm = ClothesViewModel(session: sessionFake)
        
        await vm.fetchClothes()
        
        XCTAssertEqual(vm.showError, true)
        XCTAssertEqual(vm.errorMessage, "Une erreur est survenu")
    }
    
    func testVMfetchClothesShouldFailedWithURLErrorTimeOut() async {
        let sessionFake = URLSessionFake()
        sessionFake.error = URLError(.timedOut)
        
        let vm = ClothesViewModel(session: sessionFake)
        
        await vm.fetchClothes()
        
        XCTAssertEqual(vm.showError, true)
        XCTAssertEqual(vm.errorMessage, "Connexion impossible...")
    }
    
    
    func testVMfetchClothesShouldFailedWithMachErrorAborted() async {
        let sessionFake = URLSessionFake()
        sessionFake.error = MachError(.aborted)
        
        let vm = ClothesViewModel(session: sessionFake)
        
        await vm.fetchClothes()
        
        XCTAssertEqual(vm.showError, true)
        XCTAssertEqual(vm.errorMessage, "Une erreur est survenu")
    }
    
    func testVMSelectedCloth() async {
        let sessionFake = URLSessionFake()
        guard let data = FakeData().correctData else {
            XCTFail()
            return
        }
        sessionFake.data = data
        sessionFake.response = FakeData().correctResponse
        
        let vm = ClothesViewModel(session: sessionFake)
        
        await vm.fetchClothes()
        
        vm.selectedClothID = 1
        guard let cloth = vm.selectedCloth else {
            XCTFail()
            return
        }
        
        cloth.wrappedValue.name = "new name"
        
        XCTAssertEqual(vm.clothes[0].name, "new name")
        XCTAssertEqual(vm.clothes[0].categoryItem, .accessories)
        XCTAssertEqual(vm.clothes[1].categoryItem, .shoes)
        XCTAssertEqual(vm.clothes[2].categoryItem, .top)
        XCTAssertEqual(vm.clothes[3].categoryItem, .bottoms)
        XCTAssertEqual(vm.clothes[4].categoryItem, .none)
    }
    
    func testAppCoordinator() {
        let coordinator = AppCoordinator()
        
        coordinator.goToDetail()
        
        XCTAssert(coordinator.path == [.detailView])
        
        coordinator.resetNavigation()
        
        XCTAssert(coordinator.path.isEmpty)
    }
}
