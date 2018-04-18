import Routing
import Vapor
import Fluent
/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    
   let gamesController = GamesController()
    try router.register(collection: gamesController)
    //add game
    /*router.post("api", "games") { req -> Future<Game> in
        return try req.content.decode(Game.self)
            .flatMap(to:Game.self){ game in
                return game.save(on: req)
        }
    }*/
    
    //get all games
   /* router.get("api" ,"games") { req -> Future<[Game]> in
        return Game.query(on: req).all()
    }*/

    /*//brings the game by ID
    router.get("api", "games", Game.parameter) { req -> Future<Game> in
        return try req.parameter(Game.self)
    }*/
    //gamesRoutes.get(Game.parameter, use: gamesController.getGamesByID)
    //uptade the game by ID
    /*router.put("api", "games", Game.parameter) { req -> Future<Game> in
        return try flatMap(to: Game.self,
                           req.parameter(Game.self),
                           req.content.decode(Game.self)) {
                            game, uptadeGame in
                            game.name = uptadeGame.name
                            game.producer = uptadeGame.producer
                            return game.save(on: req)
        }
    }*/
    //gamesRoutes.put(Game.parameter, use: gamesController.updateGameById)
    //delete the game by ID
    /*router.delete("api", "games", Game.parameter) { req -> Future<HTTPStatus> in
        return try req.parameter(Game.self)
            .flatMap(to: HTTPStatus.self) { game in
                return game.delete(on: req)
                            .transform(to: HTTPStatus.noContent)
        }
    }*/
   // gamesRoutes.delete(Game.parameter, use: gamesController.deleteGameByID)
    //search
   /*router.get("api", "games", "search") { req -> Future<[Game]> in
        guard let searchTerm = req.query[String.self, at: "term"] else {
                throw Abort(.badRequest)
        }
        return try Game.query(on: req).group(.or) { or in
            try or.filter(\.name == searchTerm)
            try or.filter(\.producer == searchTerm)
        }.all()
    }*/
   // gamesRoutes.get("search", use: gamesController.searchGame)
    //first item of query
    /*router.get("api", "games", "first") { req -> Future<Game> in
        return Game.query(on: req)
        .first()
            .map(to: Game.self) { game in
                guard let game = game else{
                    throw Abort(.notFound)
                }
                return game
        }
    }*/
   // gamesRoutes.get("first", use: gamesController.firstGame)
    //sorted for ascending
    /*router.get("api", "games", "sorted") { req -> Future<[Game]> in
        return try Game.query(on: req)
                  .sort(\.name, .ascending)
            .all()
    }*/
   // gamesRoutes.get("sorted", use: gamesController.sortedGame)
}
