//
//  MainAssembler.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol MainAssembler {
    func resolve() -> MainViewController
}

extension MainAssembler where Self: DefaultAssembler {
    func resolve() -> MainViewController {
        let moviesNavigationController = UINavigationController()
        let moviesViewController: MoviesViewController = resolve(
            navigationController: moviesNavigationController)
        moviesNavigationController.makeTabBarItem(title: "Movies", image: #imageLiteral(resourceName: "icon-movies"), tag: 0)
        moviesNavigationController.viewControllers.append(moviesViewController)
        
        let categoriesNavigationController = UINavigationController()
        let categoriesViewController: CategoriesViewController = resolve(
            navigationController: categoriesNavigationController)
        categoriesNavigationController.makeTabBarItem(title: "Categories", image: #imageLiteral(resourceName: "icon-categories"), tag: 1)
        categoriesNavigationController.viewControllers.append(categoriesViewController)
        
        let favoritesNavigationController = UINavigationController()
        let favoritesViewController: FavoritesViewController = resolve(
            navigationController: favoritesNavigationController)
        favoritesNavigationController.makeTabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "icon-favorites"), tag: 2)
        favoritesNavigationController.viewControllers.append(favoritesViewController)
        
        let mainViewController = MainViewController().then {
            $0.viewControllers = [moviesNavigationController,
                                  categoriesNavigationController,
                                  favoritesNavigationController]
        }
        
        return mainViewController
    }
}
