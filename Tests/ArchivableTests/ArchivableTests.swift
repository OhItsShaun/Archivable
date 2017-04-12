import XCTest
@testable import Archivable

class ArchivableTests: XCTestCase {

    func testIntReflexive() {
        let one = 1
        let archived = Data(from: one)
        let unarchived = Int.unarchive(archived)!
        
        XCTAssert(one == unarchived)
    }
    
    func testSmallStringReflexive() {
        let string = "Test"
        let archived = Data(from: string)
        let unarchived = String.unarchive(archived)!
        
        XCTAssert(string == unarchived)
    }
    
    func testLongStringReflexive() {
        var string = ""
        for i in 0...200 {
            string += "\(i)"
        }
        let archived = Data(from: string)
        let unarchived = String.unarchive(archived)!
        
        XCTAssert(string == unarchived)
    }
    
    
    func testSimpleStruct() {
        let simple = SimpleStruct(with: 5, message: "hello there")
        let archived = Data(from: simple)
        let unarchived = archived.to(type: SimpleStruct.self)
        
        XCTAssert(simple.count == unarchived.count && simple.message == unarchived.message)
    }
    
    func testDynamicStruct() {
        var dynamic = DynamicStruct(with: 5, messages: [])
        dynamic.add(message: "Hey")
        dynamic.add(message: "How")
        dynamic.add(message: "Are")
        dynamic.add(message: "You?")
        
        let archived = Data(from: dynamic)
        let unarchived = archived.to(type: DynamicStruct.self)
        
        XCTAssert(dynamic.count == unarchived.count && dynamic.messages == unarchived.messages)
    }
    
    func testDataAppending() {
        let one = 1
        let hello = "hello"
        
        let oneData = Data(from: one)
        let helloData = Data(from: hello)
        
        var data = Data()
        data.append(oneData)
        data.append(helloData)
        
        let sizeOfOne = MemoryLayout<Int>.size
        let sizeOfHello = MemoryLayout.size(ofValue: hello)
        
        let subOneData = data.subdata(in: Range(0..<sizeOfOne))
        let subHelloData = data.subdata(in: Range(sizeOfOne..<(sizeOfHello+sizeOfOne)))
        
        XCTAssert(one == subOneData.to(type: Int.self) && hello == subHelloData.to(type: String.self))
    }

    static var allTests = [
        ("testIntReflexive", testIntReflexive),
        ("testSmallStringReflexive", testSmallStringReflexive),
        ("testLongStringReflexive", testLongStringReflexive),
        ("testSimpleStruct", testSimpleStruct),
        ("testDynamicStruct", testDynamicStruct),
        ("testDataAppending", testDataAppending)
    ]
}

struct SimpleStruct {
    var count: Int
    var message: String
    
    init(with count: Int, message string: String) {
        self.count = count
        self.message = string
    }
}

extension SimpleStruct: Archivable {
    public func archive() -> Data {
        var data = Data()
        data.append(self.count.archive())
        data.append(self.message.archive())
        
        return data
    }
}

extension SimpleStruct: Unarchivable {
    
    public static func unarchive(_ data: Data) -> SimpleStruct? {
        var data = data
        
        guard let numberData = data.remove(forType: Int.self) else {
            return nil
        }
        guard let number = Int.unarchive(numberData) else {
            return nil
        }
        
        guard let stringData = data.remove(to: data.count) else {
            return nil
        }
        guard let string = String.unarchive(stringData) else {
            return nil
        }
        
        return SimpleStruct(with: number, message: string)
    }
    
}

struct DynamicStruct {
    
    var count: Int
    var messages: [String]
    
    init(with count: Int, messages strings: [String]) {
        self.count = count
        self.messages = strings
    }
    
    mutating func add(message string: String) {
        self.messages += [string]
    }
    
}
