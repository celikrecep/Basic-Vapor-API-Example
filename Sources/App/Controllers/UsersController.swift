import Vapor

struct UsersController: RouteCollection {
    func boot(router: Router){
        let usersRoute = router.grouped("api", "users")
        usersRoute.post(User.self, use: createUser)
        usersRoute.get(use: getAllHandler)
        usersRoute.get(User.parameter, use: getUserByID)
        usersRoute.get(User.parameter, "games", use: getGamesHandler)
    }
    
    //create user
    func createUser(_ req: Request, user: User) throws -> Future<User> {
        return user.save(on: req)
    }
    //get all users
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    //get user by ID
    func getUserByID(_ req: Request) throws -> Future<User> {
        return try req.parameter(User.self)
    }
    //get all games by userID
    func getGamesHandler(_ req: Request) throws -> Future<[Game]> {
        return try req.parameter(User.self)
            .flatMap(to: [Game].self) { user in
                try user.games.query(on: req).all()
        }
    }
}

