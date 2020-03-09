//
//  PipelineProgressProtocol.swift
//  easypipeline
//
//  Created by Developer on 9.03.2020.
//  Copyright © 2020 Ahmet. All rights reserved.
//

import Foundation

public protocol PipelineProgressProtocol {
    func OnProgress(sourcePipelineHashCode: Int?, workStationRequestCode: Int?, progress: Float?)
}
