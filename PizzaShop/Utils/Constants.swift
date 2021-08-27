//
//  Constants.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import Foundation

struct K {
    
    static let appName = "Pizza Pizza"
    static let foodCellIdentifier = "foodCell"
    static let orderCellIdentifier = "orderCell"
    static let menuSegue = "toMenuViewController"
    static let authSegue = "toAuthViewController"
    static let detailSegue = "toFoodDetailViewController"
    
    struct colors {
        static let primaryColor = "PrimaryColor"
        static let accentColor = "AccentColor"
        static let linkColor = "LinkColor"
    }
    
    struct error {
        static let title = "Error"
        static let invalidFieldMessage = "Please enter a valid username/password."
    }
    
    struct icons {
        static let camera = "camera.viewfinder"
    }
    
    struct Firestore {
        static let collectionName = "Posts"
        static let storageFolderName = "media"
        static let postedByField = "postedBy"
        static let imageUrlField = "imageUrl"
        static let postCommentField = "postComment"
        static let dateField = "date"
        static let likesField = "likes"
    }
    
}
