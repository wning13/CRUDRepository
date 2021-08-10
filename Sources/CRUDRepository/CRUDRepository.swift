import RealmSwift

public protocol CRUDRepository {
    associatedtype T
    func save(entity: T)
    func save(entities: [T])
    func find(by primaryKey: Any) -> T?
    func exists(by primaryKey: Any) -> Bool
    func findAll() -> [T]
    func count() -> Int
    func delete(by primaryKey: Any)
    func delete(entity: T)
    func delete(entities: [T])
    func deleteAll()
}

public class RealmCRUDRepository<ELement: Object>: CRUDRepository {
    
    public typealias T = ELement
    
    public let localRealm = try! Realm()
    
    public func save(entity: ELement) {
        try! localRealm.write {
            localRealm.add(entity, update: .modified)
        }
    }
    
    public func save(entities: [ELement]) {
        try! localRealm.write {
            localRealm.add(entities, update: .modified)
        }
    }

    public func find(by primaryKey: Any) -> ELement? {
        return localRealm.object(ofType: ELement.self, forPrimaryKey: primaryKey)
    }

    public func exists(by primaryKey: Any) -> Bool {
        return localRealm.object(ofType: ELement.self, forPrimaryKey: primaryKey) != nil
    }

    public func findAll() -> [ELement] {
        var result = [ELement]()
        for element in localRealm.objects(ELement.self) {
            result.append(element)
        }
        return result
    }

    public func count() -> Int {
        return localRealm.objects(ELement.self).count
    }

    public func delete(by primaryKey: Any) {
        try! localRealm.write {
            if let obj = find(by: primaryKey) {
                localRealm.delete(obj)
            }
        }
    }

    public func delete(entity: ELement) {
        try! localRealm.write {
            localRealm.delete(entity)
        }
    }

    public func delete(entities: [ELement]) {
        try! localRealm.write {
            localRealm.delete(entities)
        }
    }

    public func deleteAll() {
        try! localRealm.write {
            localRealm.delete(findAll())
        }
    }
    
}
