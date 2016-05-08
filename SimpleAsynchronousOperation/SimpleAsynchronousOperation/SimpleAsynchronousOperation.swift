//
//  SimpleAsynchronousOperation.swift
//
//  Created by small on 3/12/16.
//
//

import Foundation

public class SimpleAsynchronousOperation: NSOperation {
    
    public final override var asynchronous: Bool {
        return true
    }

    private var _executing = false
    public final override var executing : Bool {
        return _executing
    }
    
    private var _finished = false
    public final override var finished : Bool {
        return _finished
    }
    
    private let executingKey = "executing"
    private let finishedKey = "finished"
    public override func start() {
        guard !finished || !executing else {
            return
        }
        willChangeValueForKey(executingKey)
        _executing = true
        didChangeValueForKey(executingKey)
        main()
    }
    
    public override func main() {
        finishOperation()
    }
    
    public final func finishOperationIfNotCancelled() {
        guard !cancelled else {
            return
        }
        finishOperation()
    }
    
    public final func finishOperation() {
        willChangeValueForKey(finishedKey)
        willChangeValueForKey(executingKey)
        _executing = false
        _finished = true
        didChangeValueForKey(executingKey)
        didChangeValueForKey(finishedKey)
        completionBlock?()
        completionBlock = nil
    }
    
}
