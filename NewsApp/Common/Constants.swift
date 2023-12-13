//
//  Constants.swift
//  NewsApp
//
//  Created by Seher Köse on 2.12.2023.
//

import Foundation

struct Constants {
    struct NewsListVC {
        static let badStuff = "Bad Stuff Happened"
        static let okMessage = "OK"
    }
    struct Login {
        static let headerSignIn =  "SIGN IN"
        static let headerHeadLine = "Dive into the Latest Headlines"
        static let buttonSignIn =  "Sign In"
        static let buttonNewUser = "New User? Create Account"
        static let buttonForgotPassword = "Forgot Password?"
        static let invalidEmail = "Invalid Email"
        static let invalidEmailMessage = "Please enter a valid email!"
        static let okMessage = "OK"
        static let invalidPassword = "Invalid Password"
        static let invalidPasswordMessage =  "Please enter a valid password!"
        static let signInError = "Error Signing In"
        static let errorMessage = "Error!"
    }
    struct InfoScreen {
        static let alreadyFavorited = "Already Favorited"
        static let alreadyFavoritedMessage = "This article is already in your favorites."
        static let okMessage = "OK"
        static let errorMessage = "ERROR"
        static let wentWrongMessage = "Something went wrong!"
        static let successTitle   = "Success!"
        static let successMessage = "You have successfully favorited this article 🎉"
        static let articleNotFound = "Selected article not found"
        static let errorFetchingNews = "Error Fetching News"
    }
    struct ForgotPasswordVC {
        static let headerForgotPassword = "Forgot Password?"
        static let headerForgotPasswordSubTitle = "Reset your password.."
        static let signUp = "Sign Up"
        static let errorMessage = "Error!"
        static let invalidMail = "Invalid Email"
        static let okMessage = "OK"
        static let passwordReset = "Error Password Reset!"
        static let passwordResetTitle = "Password Reset"
        static let passwordResetMessage = "The password reset link has been sent to your email address."
        static let resetPassword = "Reset Password"
    }
    struct OnboardingVC {
        struct page1 {
            static let imageName1 = "onb3"
            static let titleText1 = "News From Around The World"
            static let subtitleText1 = "Best time to read, take your time to read a little more of this world."
        }
        struct page2 {
            static let imageName2 = "onb2"
            static let titleText2 =  "Best Time to Read"
            static let subtitleText2 = "Your Daily Dose of International News"
        }
        struct page3 {
            static let imageName3 =  "onb1"
            static let titleText3 =  "Start Your News Journey"
            static let subtitleText3 =  "Swipe, Discover, and Stay Updated"
        }
        static let nextButton = "NEXT"
        static let skipButton = "SKIP"
        
    }
    struct FavoritesListVC {
        static let favoriteNews = "Favorite News"
        static let noFavorites = "No Favorites?\nAdd one.."
        static let wentWrong = "Something went wrong"
        static let okMessage = "OK"
        static let unableRemove = "Unable to remove"
    }
    
    struct SearchVC {
        static let showNews = "SHOW NEWS"
        static let emptyCountry = "Empty Country"
        static let emptyCountryMessage = "Please enter a country name 😊"
        static let okMessage = "OK"
    }
    
    struct WebViewControllerVC {
        static let done = "Done"
    }
    
    struct RegisterVC {
        static let errorMessage = "ERROR"
        static let invalidPassword = "Invalid Password"
        static let invalidEmail = "Invalid Email"
        static let invalidUserName = "Invalid Username"
        static let okMessage = "OK"
        static let unexpectedError = "Unexpected Error!"
        static let invalidPasswordMessage = "Your password must be at least 6 character and must contain 1 character, 1 number, and 1 uppercase letter"
        static let invalidEmailMessage = "Please enter a valid email!"
        static let invalidUserNameMessage = "Please enter a valid username!"
        static let signUpTitle = "SIGN UP"
        static let alreadyHaveAccount = "Already have an account? Sign In"
        static let createAccount = "Create Your Account"
        static let message = "By creating an account, you agree to our Terms & Conditions and acknowledge that you have read the Privacy Policy."
        static let termsAndCondLink = "terms://termsAndConditions"
        static let termsAndCond = "Terms & Conditions"
        static let privacyPolicyLink = "privacy://privacyPolicy"
        static let privacyPolicy = "Privacy Policy"
        static let policyLink = "https://policies.google.com/terms?hl=en-US"
    }
    
    struct ProfileInfoVC {
        static let logOut = "Log Out"
        static let changePassword = "Change Password"
        static let attributedString =  "Terms & Conditions\n Privacy Policy"
        static let termsAndCondLink = "terms://termsAndConditions"
        static let termsAndCond = "Terms & Conditions"
        static let privacyPolicyLink = "privacy://privacyPolicy"
        static let privacyPolicy = "Privacy Policy"
        static let policyLink = "https://policies.google.com/terms?hl=en-US"
        static let errorMessage = "ERROR"
        static let okMessage = "OK"
        
    }
}
