//
//  easypipelineTests.swift
//  easypipelineTests
//
//  Created by Developer on 4.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import XCTest
@testable import easypipeline

class easypipelineTests: XCTestCase {
    
    var expecResponse: XCTestExpectation?
    var expecReqCode: XCTestExpectation?
    
    var pipelineData: MyPipelineData?
    static var ReqCode: Int?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.pipelineData = nil
        easypipelineTests.ReqCode = nil
        self.expecReqCode = nil
        self.expecResponse = nil
    }
    
    //MARK: Pipeline async test
    func test2EasyPipeline() {
        self.expecResponse = expectation(description: "The expected response is 'ab' by data")
        //first Pipeline
        let pipelineData1 = MyPipelineData()
        easypipelineTests.ReqCode = 1
        
        Pipeline(pipelineResult: self, pipelineRequestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData1)
        
        //second Pipeline
        let pipelineData2 = MyPipelineData()
        easypipelineTests.ReqCode = 2
        
        Pipeline(pipelineResult: self, pipelineRequestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData2)
        
        wait(for: [expecResponse!], timeout: 8.0)
    }
    
    //MARK: test request code for 1
    func testRequestCode1() {
        self.expecReqCode = expectation(description: "The expected response is '1' by request code")
        
        let pipelineData = MyPipelineData()
        easypipelineTests.ReqCode = 1
        
        Pipeline(pipelineResult: self, pipelineRequestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData)
        
        wait(for: [expecReqCode!], timeout: 8.0)
    }
    
    //MARK: test request code for 1
    func testRequestCode2() {
        self.expecReqCode = expectation(description: "The expected response is '1' by request code")
        
        let pipelineData = MyPipelineData()
        easypipelineTests.ReqCode = 1
        
        Pipeline(pipelineResult: self, pipelineRequestCode: easypipelineTests.ReqCode!)
            .Next(workStation: WorkStation1())
            .Next(workStation: WorkStation2())
            .Run(data: pipelineData)
        
        wait(for: [expecReqCode!], timeout: 8.0)
    }
    
}

extension easypipelineTests: PipelineResultProtocol {
    func OnResult(pipelineRequestCode sourcePipelineHashCode: Int, pipelineData: PipelineDataProtocol) {
        //Response expectation
        expecResponse?.fulfill()
        //Request code expectation for 1
        if sourcePipelineHashCode == 1 {
            expecReqCode?.fulfill()
        }
    }
}
