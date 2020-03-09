//
//  Pipeline.swift
//  easypipeline
//
//  Created by Developer on 4.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import Foundation

public class Pipeline: WorkStation {
    private var pipelineResult: PipelineResultProtocol?
    
    public init(pipelineResult: PipelineResultProtocol, pipelineRequestCode: Int) {
        super.init()
        
        IsRoot = true
        self.pipelineRequestCode = pipelineRequestCode
        self.pipelineResult = pipelineResult
    }
    
    public init(pipelineResult: PipelineResultProtocol, pipelineRequestCode: Int, iPipelineProgress: PipelineProgressProtocol) {
        super.init()
        
        IsRoot = true
        self.pipelineRequestCode = pipelineRequestCode
        self.pipelineResult = pipelineResult
        self.iPipelineProgress = iPipelineProgress
    }
    
    public override func InvokeAsync(data: PipelineDataProtocol) {
        DispatchQueue.global().async {
            self.runInBackground(iPipelineData: data, completion: { requestCode, response  in
                self.pipelineResult?.OnResult(pipelineRequestCode: requestCode, pipelineData: response)
            })
        }
    }
    
    func runInBackground(iPipelineData: PipelineDataProtocol, completion: @escaping (Int, PipelineDataProtocol) -> Void) {
        super.InvokeAsync(data: iPipelineData)
        completion(pipelineRequestCode!,iPipelineData)
    }
}

