//
//  CoreDataStorageTests.swift
//  LyraTests
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import XCTest
import CoreData
import Lyra

final class CoreDataStorageTests: XCTestCase {

    var sut: CoreDataStorage! = nil

    override func setUp() {
        let container = CoreDataPersistentContainer(inMemory: true)
        sut = CoreDataStorage(container: container)
    }

    override func tearDown() {
        sut = nil
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }



}

class MockPersistentContainer {

    lazy var container: NSPersistentContainer = {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            let container = NSPersistentContainer(name: "StateDatabase")
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        }()

}
