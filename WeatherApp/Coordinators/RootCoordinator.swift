//
//  RootCoordinator.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 19/01/25.
//

import Foundation
import UIKit
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
    func popViewController()
}


class RootCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
    }
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    
}
