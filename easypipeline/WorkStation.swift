//
//  WorkStation.swift
//  easypipeline
//
//  Created by Developer on 4.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import Foundation

open class WorkStation {
    private var _nextWorkStation: WorkStation?
    private var _prevWorkStation: WorkStation?
    internal var IsRoot = false
    
    var iPipelineProgress: PipelineProgressProtocol?
    var pipelineRequestCode: Int?
    var workStationRequestCode: Int?
    var progressValue: Float?
    
    public init() {
        
    }
    
    public func Next(workStation: WorkStation, progress: Float) -> WorkStation {
        progressValue = progress
        
        return _Next(workStation: workStation)
    }
    
    public func Next(workStation: WorkStation, _workStationRequestCode: Int) -> WorkStation{
        workStationRequestCode = _workStationRequestCode
        
        return _Next(workStation: workStation)
    }
    
    public func Next(workStation: WorkStation, progress: Float, _workStationRequestCode: Int) -> WorkStation {
        progressValue = progress
        workStationRequestCode = _workStationRequestCode
        
        return _Next(workStation: workStation)
    }
    
    public func Next(workStation: WorkStation) -> WorkStation {
        return _Next(workStation: workStation)
    }
    
    public func _Next(workStation: WorkStation) -> WorkStation {
        _nextWorkStation = workStation
        _nextWorkStation?._prevWorkStation = self
        _nextWorkStation?.iPipelineProgress = iPipelineProgress
        _nextWorkStation?.pipelineRequestCode = pipelineRequestCode
        
        return _nextWorkStation!
    }
    
    public func Run(data: PipelineDataProtocol) {
        if IsRoot  {
            InvokeAsync(data: data)
        }else {
            _prevWorkStation?.Run(data: data)
        }
    }
    
    public func updateProgress() {
        iPipelineProgress?.OnProgress(sourcePipelineHashCode: pipelineRequestCode, workStationRequestCode: workStationRequestCode, progress: progressValue)
    }
    
    open func InvokeAsync(data: PipelineDataProtocol) {
        if progressValue != nil || workStationRequestCode != nil {
            updateProgress()
        }
        
        if _nextWorkStation != nil {
            _nextWorkStation?.InvokeAsync(data: data)
        }
    }
}

