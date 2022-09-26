//
//  MockWebService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/25/22.
//

import Foundation

final class MockWebService: API {
    
    func getAllFoods() async throws -> [Food] {
        let foods = [
            Food(name: "BBQ Chicken Pizza", type: "pizza", price: 14.99, ingredients: "Pizza crust, spicy barbecue sauce, chicken breast halves, fresh cilantro, pepperoncini peppers, red onion, Colby-Monterey Jack cheese", image: "images/bbq_chicken.jpg"),
            Food(name: "Margherita Pizza", type: "pizza", price: 12.99, ingredients: "San Marzano tomatoes, mozzarella cheese, fresh basil, salt, extra-virgin olive oil", image: "images/margherita.jpg"),
            Food(name: "Meat Lover's Pizza", type: "pizza", price: 14.99, ingredients: "Pizza crust mix, olive oil, garlic powder, ground beef, onion powder, spaghetti sauce, pepperoni, Canadian bacon, fresh mushrooms, ripe olives, mozzarella cheese", image: "images/meat_lovers.jpg"),
            Food(name: "Pepperoni Pizza", type: "pizza", price: 14.99, ingredients: "CONTADINA® Tomato Paste, oregano, basil, garlic powder, onion powder, sugar, salt, black pepper", image: "images/pepperoni.jpg"),
            Food(name: "Vegetable Pizza", type: "pizza", price: 12.99, ingredients: "Crescent rolls, cream cheese, softened mayonnaise, dry vegetable soup mix (such as Knorr®), radishes, green bell pepper, red bell pepper, yellow bell pepper, florets, florets, carrot, celery", image: "images/vegetable.jpg"),
            Food(name: "Hawaiian Pizza", type: "pizza", price: 15.99, ingredients: "Flour tortilla, pizza sauce (such as Contadina®), tomato with paper towels, pineapple rings with paper towels, dried basil, dried oregano, garlic powder, cooked ham, mozzarella cheese", image: "images/hawaiian.jpg"),
            Food(name: "Bacon Pizza", type: "pizza", price: 14.99, ingredients: "Ground beef sirloin, onions, garlic, rosemary leaves, ground pepper, yellow cornmeal, Pillsbury™ Classic Crust Pizza Crust, marinara sauce, part-skim mozzarella cheese, Parmesan cheese, center-cut bacon, crisply cooked, crumbled", image: "images/bacon.jpg"),
            Food(name: "Caesar Salad", type: "salad", price: 8.99, ingredients: "Romaine lettuce, croutons, lemon juice, olive oil, egg, Worcestershire sauce, anchovies, garlic, Dijon mustard, Parmesan cheese, black pepper", image: "images/caesar.jpg"),
            Food(name: "Greek Salad", type: "salad", price: 9.99, ingredients: "Tomatoes, cucumbers, onion, feta cheese, olives, salt, pepper, Greek oregano, olive oil, green bell pepper slices, caper berries", image: "images/greek.jpg"),
            Food(name: "Caprese Salad", type: "salad", price: 9.99, ingredients: "Mozzarella, tomatoes, basil, salt, olive oil", image: "images/caprese.jpg"),
            Food(name: "Cheesecake", type: "dessert", price: 4.99, ingredients: "Cream cheese, egg, butter, sugar, biscuit, milk", image: "images/cheesecake.jpg"),
            Food(name: "Ice Cream", type: "dessert", price: 3.99, ingredients: "Milk, cream, vanilla", image: "images/ice_cream.jpg"),
            Food(name: "Apple Pie", type: "dessert", price: 4.99, ingredients: "All-purpose flour, lemon juice, apples, Cortland, sugar, butter, cinnamon, nutmeg, egg", image: "images/apple_pie.jpg"),
            Food(name: "Beer", type: "beverage", price: 1.99, ingredients: nil, image: "images/heineken.jpg"),
            Food(name: "Cola", type: "beverage", price: 1.79, ingredients: nil, image: "images/coca_cola.jpg")
        ]
        
        return foods
    }
    
    func submitOrder(order: Order) async throws -> Int {
        return 200
    }
    
    
    func submitReservation(reservation: Reservation) async throws -> Int {
        return 200
    }
    
    func login(user: User) async throws -> User {
        return User(name: "John Doe", phone: "09131110000", address: "2391 S Muddy String Rd, Thayne, WY, 83127")
    }
    
    func register(user: User) async throws -> User {
        return User(name: user.name, phone: user.phone, address: user.address)
    }
    
}
