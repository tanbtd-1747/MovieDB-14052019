//
//  UIViewController+.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showError(message: String, completion: (() -> Void)? = nil) {
        let ac = UIAlertController(title: "Error",
                                   message: message,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func removeBackButtonTitle() {
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func topMostViewController() -> UIViewController? {
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController()
        }
        
        if let tab = self as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            if let visibleController = navigation.visibleViewController {
                return visibleController.topMostViewController()
            }
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController?.topMostViewController()
    }
}

extension UIViewController {
    func makeTabBarItem(title: String, image: UIImage?, tag: Int) {
        let tabBarItem = RAMAnimatedTabBarItem(title: title, image: image, tag: tag)
        tabBarItem.animation = RAMBounceAnimation()
        self.tabBarItem = tabBarItem
    }
    
    func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func hideTabBar(_ isHidden: Bool) {
        if let tabBarController = tabBarController as? RAMAnimatedTabBarController {
            tabBarController.animationTabBarHidden(isHidden)
        }
    }
}

extension UIViewController {
    func addBottomSheetViewController(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        viewController.view.frame = CGRect(x: 0,
                                           y: view.frame.maxY,
                                           width: view.frame.width,
                                           height: view.frame.height)
    }
    
    func addTopSheetViewController(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        viewController.view.frame = CGRect(x: 0,
                                           y: -viewController.view.frame.height,
                                           width: view.frame.width,
                                           height: view.frame.height)
    }
    
    func presentSheetViewController() {
        UIView.animate(withDuration: 0.3,
                       animations: { [weak self] in
                        guard let self = self else { return }
                        
                        self.view.frame = CGRect(x: 0,
                                                 y: 0,
                                                 width: self.view.frame.width,
                                                 height: self.view.frame.height)
            },
                       completion: { _ in
                        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        })
    }
    
    func dismissBottomSheetViewController() {
        view.backgroundColor = .clear
        UIView.animate(withDuration: 0.3,
                       animations: { [weak self] in
                        guard let self = self else { return }
                        
                        self.view.frame = CGRect(x: 0,
                                                 y: self.view.bounds.maxY,
                                                 width: self.view.frame.width,
                                                 height: self.view.frame.height)
                        },
                       completion: { _ in
                        self.view.removeFromSuperview()
                        self.removeFromParent()
                        })
    }
    
    func dismissTopSheetViewController() {
        view.backgroundColor = .clear
        UIView.animate(withDuration: 0.3,
                       animations: { [weak self] in
                        guard let self = self else { return }
                        
                        self.view.frame = CGRect(x: 0,
                                                 y: -self.view.frame.height,
                                                 width: self.view.frame.width,
                                                 height: self.view.frame.height)
            },
                       completion: { _ in
                        self.view.removeFromSuperview()
                        self.removeFromParent()
        })
    }
}
