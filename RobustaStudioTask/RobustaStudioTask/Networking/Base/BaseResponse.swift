//
//  BaseResponse.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//
import Foundation

/// Object
class BaseResponse<T: Codable>: Codable {
    var data: T?
}

/// Array of objects 
class BaseArrayResponse<T: Codable>: Codable {
    var message: String?
    var data: [T]?
}
