//
//  TestLeboncoinTests.swift
//  TestLeboncoinTests
//
//  Created by walid nakbi on 16/7/2021.
//

import XCTest
@testable import TestLeboncoin
class TestLeboncoinTests: XCTestCase {
    var viewModel : AnnoncesListViewModel!
    var mockAnnonceService : MockAnnonceService?
    override func setUp() {
        viewModel = .init()
    }
    func testListAnnonce(){
        mockAnnonceService?.fetchAnnonces(completion: { (result) in
            switch result {
            case .success(let annoceModel):
                self.viewModel.onRefreshHandling?()
            case .failure(let error):
                print(error)
                self.viewModel.onErrorHandling?(ErrorResult.network(string: error.localizedDescription))
            }
        })
        viewModel.getAnnonceListData()
        XCTAssertTrue((viewModel.onRefreshHandling != nil))
    }
}
