//
//  AuthService.swift
//  NewsApp
//
//  Created by Seher Köse on 16.09.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService{
    public static let shared = AuthService()
    
    private init(){}
    
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping(Bool, Error?)->Void){
        
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else{
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email,
                ]) { error in
                    if let error = error{
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                    
                }
        }
        
    }
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping(Error?) -> Void){
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password){
            result, error in
            if let error = error{
                completion(error)
                return
            }else{
                completion(nil)
                
            }
        }
    }
    public func signOut(completion: @escaping(Error?) -> Void){
        do{
            try Auth.auth().signOut()
            completion(nil)
        }catch let error{
            completion(error)
        }
    }
    
    public func resetPassword(with email: String, completion: @escaping(Error?) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            completion(error)
        }
    }
    
    public func fetchUser(completion: @escaping(AuthUser?, Error?) -> Void){
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        db.collection("users")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let username = snapshot["username"] as? String,
                   let email = snapshotData["email"] as? String{
                    let authuser = AuthUser(username: username, email: email, userUID: userUID)
                    
                    completion(authuser, nil)
                }
            }
        
    }
}

