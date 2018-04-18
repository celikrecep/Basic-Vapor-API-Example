import Vapor
import Fluent

struct GamesController: RouteCollection {
    func boot(router: Router) throws {
        let gamesRoutes = router.grouped("api", "games")
        gamesRoutes.post(Game.self,use: addGame)
        gamesRoutes.get(use: getAllHandler)
        gamesRoutes.get(Game.parameter, use: getGamesByID)
        gamesRoutes.put(Game.parameter, use: updateGameById)
        gamesRoutes.delete(Game.parameter, use: deleteGameByID)
        gamesRoutes.get("search", use: searchGame)
        gamesRoutes.get("first", use: firstGame)
        gamesRoutes.get("sorted", use: sortedGame)
    }
    
    func addGame(_ req: Request) throws -> Future<Game> {
        return try req.content.decode(Game.self)
            .flatMap(to:Game.self){ game in
                return game.save(on: req)
        }
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Game]> {
        return Game.query(on: req).all()
    }
    func getGamesByID(_ req: Request) throws -> Future<Game> {
        return try req.parameter(Game.self)
    }
    func updateGameById(_ req: Request) throws -> Future<Game> {
        return try flatMap(to: Game.self,
                           req.parameter(Game.self),
                           req.content.decode(Game.self)) {
                            game, updateGame in
                            game.name = updateGame.name
                            game.producer = updateGame.producer
                            return game.save(on: req)
        }
    }
    func deleteGameByID(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameter(Game.self)
            .flatMap(to: HTTPStatus.self) { game in
                return game.delete(on: req)
                .transform(to: HTTPStatus.noContent)
        }
    }
    func searchGame(_ req: Request) throws -> Future<[Game]> {
        guard let searchTerm = req.query[String.self, at: "term"] else {
            throw Abort(.badRequest)
        }
        return try Game.query(on: req).group(.or) { or in
            try or.filter(\.name == searchTerm)
            try or.filter(\.producer == searchTerm)
            }.all()
    }
    func firstGame(_ req: Request) throws -> Future<Game> {
        return Game.query(on: req)
            .first()
            .map(to: Game.self) { game in
                guard let game = game else{
                    throw Abort(.notFound)
                }
                return game
        }
    }
    func sortedGame(_ req: Request) throws -> Future<[Game]> {
        return try Game.query(on: req)
        .sort(\.name, .ascending)
        .all()
    }
}
