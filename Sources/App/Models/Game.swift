import Vapor
import FluentSQLite

final class Game: Codable {
    var id: Int?
    var producer: String
    var name: String
    var userID: User.ID
    
    init(producer: String, name: String, userID: User.ID) {
        self.producer = producer
        self.name = name
        self.userID = userID
    }
    
}
extension Game: Model {
    typealias Database = SQLiteDatabase
    typealias ID = Int
    public static var idKey: IDKey = \Game.id
}

extension Game: SQLiteModel{}
extension Game: Migration{}
extension Game: Content{}
extension Game: Parameter {}
extension Game {
    var user: Parent<Game, User> {
        return parent(\.userID)
    }
}
