//
//  PhotosCollectionViewControllerTests.swift
//  pr1Tests
//
//  Created by Никита Попов on 21.02.24.
//

import XCTest
@testable import pr1

final class PhotosCollectionViewControllerTests: XCTestCase {
    
    private var nwE: VKEndPoints!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.nwE = VKEndPoints.getPhotos
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        self.nwE = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testgetURL(){
        let res = nwE.getURL(token: "token", id: "id")?.absoluteString ?? ""
        XCTAssertEqual(res , "https://api.vk.ru/method/photos.get?access_token=token&owner_id=id&album_id=profile&v=5.199", "Неверное значение" )
    }
}
