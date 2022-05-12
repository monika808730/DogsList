//
//  DogListAPITests.swift
//  DogListAPITests
//
//  Created by Monika on 12/05/2022.
//

import XCTest
import DogList

class DogListAPITests: XCTestCase {
    
    func testIfAPIWorking(){
           let expectations = self.expectation(description: "DogsListAPICall")
           getAPIReponse(url: "https://api.thedogapi.com/v1/breeds", completion: { data,error in
               
               if error != nil{
                   XCTFail("Fail")
               }else{
                   XCTAssertNotNil(data)
                   XCTAssertNil(error)
               }
               expectations.fulfill()
           })
           
           waitForExpectations(timeout: 5, handler: nil)
       }
    
    
}
