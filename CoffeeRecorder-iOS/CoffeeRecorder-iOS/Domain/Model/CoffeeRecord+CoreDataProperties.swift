//
//  CoffeeRecord+CoreDataProperties.swift
//  CoffeeRecorder-iOS
//
//  Created by 菅原実希 on 2024/11/04.
//
//

import Foundation
import CoreData


extension CoffeeRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoffeeRecord> {
        return NSFetchRequest<CoffeeRecord>(entityName: "CoffeeRecord")
    }

    @NSManaged public var comment: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var rate: Double
    @NSManaged public var shopName: String?

}

extension CoffeeRecord : Identifiable {

}
