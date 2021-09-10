//
//  WorkItemManager.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation

protocol WorkItemManagerProtocol {
    func perform(after: TimeInterval, _ block: @escaping () -> Void)
}

class WorkItemManager: WorkItemManagerProtocol {
    
    //MARK: Singleton
    static let shared: WorkItemManagerProtocol = WorkItemManager()
    
    //MARK: Properties
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    //MARK: Methods
    func perform(after: TimeInterval, _ block: @escaping () -> Void) {
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem(block: block)
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: requestWorkItem)
    }
}
