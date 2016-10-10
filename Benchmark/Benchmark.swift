//
//  Benchmark.swift
//  Benchmark
//
//  Created by shoji on 2016/05/24.
//  Copyright © 2016年 com.shoji. All rights reserved.
//

import CoreFoundation

public struct Benchmark {

    fileprivate let startTimeInterval: CFAbsoluteTime
    fileprivate let key: String
    fileprivate static var sharedInstance: Benchmark?

    public init(key: String) {
        startTimeInterval = CFAbsoluteTimeGetCurrent()
        self.key = key
    }

    public func finish() {
        let elapsed = CFAbsoluteTimeGetCurrent() - startTimeInterval
        let formatedElapsed = String(format: "%.5f", elapsed)
        print("\(key): \(formatedElapsed) sec.")
    }

    public static func start(_ key: String = "Benchmark") {
        sharedInstance = Benchmark(key: key)
    }

    public static func finish() {
        sharedInstance?.finish()
        sharedInstance = nil
    }

    public static func measure(_ key: String = "Benchmark", block: (Void) -> Void) {
        let benchmark = Benchmark(key: key)
        block()
        benchmark.finish()
    }
}

prefix operator ⏲
public prefix func ⏲(handler: (Void) -> Void) {
    Benchmark.measure(block: handler)
}
