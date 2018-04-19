import Foundation
import Vapor
import FluentSQLite


final class User: Codable{
    var id: UUID?
    var name: String
    var username: String
    
    init(name: String, username: String){
        self.username = username
        self.name = name
    }
}

extension User: SQLiteUUIDModel{ }
extension User: Content{ }
extension User: Migration{ }
extension User: Parameter { }

extension User {
    var games: Children<User, Game> {
        return children(\.userID)
    }
}
