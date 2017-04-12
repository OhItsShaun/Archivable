//
//  DataExtension.swift
//  House
//
//  Created by Shaun Merchant on 10/12/2016.
//  Copyright © 2016 Shaun Merchant. All rights reserved.
//

import Foundation

public extension Data {
    
    /// Transform a value or instance into a collection of `Data` by using the raw bytes allocated for the type.
    ///
    /// - Important: Improper or uninformed use could result in unstable and dangerous code. In such circumstance **do not use**.
    ///
    /// - Parameter value: The value or instance to transform to `Data`.
    public init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    
    /// Represent the data as an instance or value of a given type.
    ///
    /// - Important: Improper or uninformed use could result in unstable and dangerous code. In such circumstance **do not use**.
    ///
    /// - Parameter type: The type to treat the collection of bytes as.
    /// - Returns: An instance or value of the type.
    public func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
    
    /// Remove and return data from the starting index to a specified index.
    ///
    /// - Parameter index: The index to remove data to.
    /// - Returns: The data from the starting index to the specified data, `nil` if the range of data is not valid, e.g.: index out of bounds.
    public mutating func remove(to index: Int) -> Data? {
        guard index <= self.count else {
            return nil
        }
        
        let newData = self.subdata(in: 0..<index)
        self = self.subdata(in: index..<self.count)
        
        return newData
    }
    
    /// Remove and return enough data from the current `Data` collection, such that the amount of data returned is
    /// equal to the size of memory that would need to be reserved if the supplied type were to be allocated in memory.
    ///
    /// - Parameter type: The type remove and return enough data for, if the type were to be allocated.
    /// - Returns: A collection of data that has a size equal to the memory footprint of the given type, otherwise `nil` if enough data does not
    ///            exist to meet the memory size of the given type.
    public mutating func remove<T>(forType type: T.Type) -> Data? {
        let index = MemoryLayout<T>.size
        
        return self.remove(to: index)
    }
    
    /// Determine if a given type has the same memory allocation size as the `Data` collection.
    ///
    /// - Parameter type: The type to determine memory allocation size of.
    /// - Returns: Whether the type has the same memory allocation size as the `Data` collection.
    public func isValid<T>(forType type: T.Type) -> Bool {
        let expectedSize = MemoryLayout<T>.size
        
        guard self.count >= expectedSize else {
            return false
        }
        
        guard self.count <= expectedSize else {
            return false
            
        }
        
        return true
    }
}
