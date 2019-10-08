import UIKit

var str = "Hello, playground"

//Third party classes - Legacy
class GoogleAuthentication {
    func login(email: String, password: String, completion: @escaping (GoogleUser?, Error?) -> Void) {
        //Make a network call which return a Token
        let token = "special-token-value"
        
        let user = GoogleUser(email: email, password: password, token: token)
        
        completion(user, nil)
    }
}

struct GoogleUser {
    var email: String
    var password: String
    var token: String
}

//Protocol for Adapter
protocol AuthenticationService {
    
    func login(email: String, password: String,
               success: @escaping (User, Token) -> Void,
               failure: @escaping (Error?) -> Void)
}

struct User {
    let email: String
    let password: String
}

struct Token {
    let value: String
}


//ADAPTER
class GoogleAuthenticationAdapter: AuthenticationService {
    
    //Khai bao 1 doi tuong thuoc kieu Legacy (has a legacy object - chua ben trong class 1 thuoc tinh kieu Legacy/ Ben trong class co 1 storage property kieu Legacy
    private var authenticator = GoogleAuthentication()
    
    //Doi tuong cua Adapter se goi doi tuong cua Legacy thuc hien func login, du lieu thanh cong se duoc truyen vao closure success, du lieu that bai se duoc truyen vao closure failure
    func login(email: String, password: String, success: @escaping (User, Token) -> Void, failure: @escaping (Error?) -> Void) {
        authenticator.login(email: email, password: password) { (googleUser, error) in
            guard let gUser = googleUser else {
                failure(error)
                return
            }
            
            let user = User(email: gUser.email, password: gUser.password)
            let token = Token(value: gUser.token)
            success(user, token)
        }
    }
    
}

//MARK: - EXAMPLE
//Object using an adapter se khai bao 1 doi tuong thuoc kieu Protocol for Adapter
var authService: AuthenticationService = GoogleAuthenticationAdapter()

authService.login(email: "user@gmail.com", password: "password", success: { (user, token) in
    print("Auth success: \(user.email), \(token.value)")
}) { (error) in
    if let error = error {
        print("Auth failed with error: \(error)")
    } else {
        print("Auth failed with error: no error provided")
    }
}

