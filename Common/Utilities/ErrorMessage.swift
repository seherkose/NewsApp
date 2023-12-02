//
//  ErrorMessage.swift
//  NewsApp
//
//  Created by Seher Köse on 7.09.2023.
//

import Foundation

enum NAError: String, Error{
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again"
    case invalidServer = "Server returned an error"
    case invalidDecodedData = "Failed to decode data from the server"
    case unabletoFavorite = "There was an error favoriting this new. Please try again."
    case alreadyInFavorites = "You've already favorited this new"
}

