import XCTest
@testable import RealmSwift
@testable import CRUDRepository

class User: Object {
    @Persisted(primaryKey: true) var name: String = ""
    @Persisted var phone: String?
    @Persisted var address: String = ""
    
    convenience init(name: String, address: String) {
        self.init()
        self.name = name
        self.address = address
    }
}

class UserRepository: RealmCRUDRepository<User> {

}

final class CRUDRepositoryTests: XCTestCase {
    
    let repository = UserRepository()
    
    func testSaveUser() {
        repository.deleteAll()
        
        let user1 = User(name: "name1", address: "address1")
        let user2 = User(name: "name2", address: "address2")
        
        repository.save(entity: user1)
        repository.save(entity: user1)
        repository.save(entity: user2)
        
        XCTAssert(repository.count() == 2)
        XCTAssert(repository.find(by: user1.name)?.address == user1.address)
    }
    
    func testSaveUsers() {
        repository.deleteAll()
        
        let user1 = User(name: "name1", address: "address1")
        let user2 = User(name: "name2", address: "address2")
        
        repository.save(entities: [user1, user2])
        
        XCTAssert(repository.count() == 2)
        XCTAssert(repository.find(by: user1.name)?.address == user1.address)
    }
    
    func testDeleteUser() {
        repository.deleteAll()
        
        let user1 = User(name: "name1", address: "address1")
        let user2 = User(name: "name2", address: "address2")
        
        repository.save(entity: user1)
        repository.save(entity: user2)
        XCTAssert(repository.exists(by: user1.name))
        XCTAssert(repository.exists(by: user2.name))
        
        repository.delete(entity: user1)
        XCTAssert(!repository.exists(by: "name1"))
        XCTAssert(repository.exists(by: "name2"))
        
        repository.delete(by: user2.name)
        XCTAssert(!repository.exists(by: "name2"))
    }
    
    func testDeleteAllUsers() {
        repository.deleteAll()
        
        let user1 = User(name: "name1", address: "address1")
        let user2 = User(name: "name2", address: "address2")
        let user3 = User(name: "name3", address: "address3")
        let user4 = User(name: "name4", address: "address4")
        
        repository.save(entities: [user1, user2, user3, user4])
        XCTAssert(repository.count() > 0)
        
        repository.deleteAll()
        XCTAssert(repository.count() == 0)
    }
    
    func testDeleteUsers() {
        repository.deleteAll()
        
        let user1 = User(name: "name1", address: "address1")
        let user2 = User(name: "name2", address: "address2")
        let user3 = User(name: "name3", address: "address3")
        let user4 = User(name: "name4", address: "address4")
        
        repository.save(entities: [user1, user2, user3, user4])
        repository.delete(entities: [user1, user2])
        
        XCTAssert(repository.count() == 2)
        XCTAssert(!repository.exists(by: "name1"))
        XCTAssert(repository.exists(by: "name3"))
    }
}
