import Vapor
import FluentSQLite

final class Game: Codable {
    var id: Int?
    var producer: String
    var name: String
    
    init(producer: String, name: String) {
        self.producer = producer
        self.name = name
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
