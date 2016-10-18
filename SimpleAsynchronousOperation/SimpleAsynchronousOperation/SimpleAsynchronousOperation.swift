//
//  SimpleAsynchronousOperation.swift
//
//  Created by small on 3/12/16.
//
//

import Foundation

open class SimpleAsynchronousOperation: Operation {
    
    public final override var isAsynchronous: Bool {
        return true
    }

    fileprivate var _executing = false
    public final override var isExecuting : Bool {
        return isCancelled ? false : _executing
    }
    
    fileprivate var _finished = false
    public final override var isFinished : Bool {
        return isCancelled ? true : _finished
    }
    
    fileprivate let executingKey = "executing"
    fileprivate let finishedKey = "finished"
    open override func start() {
        guard !isFinished || !isExecuting else {
            return
        }
        willChangeValue(forKey: executingKey)
        _executing = true
        didChangeValue(forKey: executingKey)
        main()
    }
    
    open override func main() {
        finish()
    }
    
    open override func cancel() {
        super.cancel()
    }
    
    public final func finish() {
        guard !isCancelled else {
            return
        }
        willChangeValue(forKey: finishedKey)
        willChangeValue(forKey: executingKey)
        _executing = false
        _finished = true
        didChangeValue(forKey: executingKey)
        didChangeValue(forKey: finishedKey)
        completionBlock?()
        completionBlock = nil
    }
    
}
