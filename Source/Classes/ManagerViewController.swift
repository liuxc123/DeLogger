//
//  ManagerViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 02/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController, LogHeadViewDelegate {

    var button = LogHeadView(frame: CGRect(origin: LogHeadView.originalPosition, size: LogHeadView.size))
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.view.addSubview(self.button)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.button.updateOrientation(newSize: size)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.delegate = self
        self.view.backgroundColor = UIColor.clear
        let selector = #selector(ManagerViewController.panDidFire(panner:))
        let panGesture = UIPanGestureRecognizer(target: self, action: selector)
        button.addGestureRecognizer(panGesture)
    }

    func didTapButton() {
        DeLogger.shared.displayedList = true
        
        let managerTabBarController = UITabBarController()
        managerTabBarController.tabBar.barTintColor = UIColor.black
        managerTabBarController.tabBar.tintColor = Color.mainGreen
        managerTabBarController.viewControllers = getViewControllers()
        
        self.present(managerTabBarController, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        DeLogger.shared.displayedList = false
    }

    @objc func panDidFire(panner: UIPanGestureRecognizer) {

        if panner.state == .began {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: nil)
        }

        let offset = panner.translation(in: view)
        panner.setTranslation(CGPoint.zero, in: view)
        var center = button.center
        center.x += offset.x
        center.y += offset.y
        button.center = center

        if panner.state == .ended || panner.state == .cancelled {

            let location = panner.location(in: view)
            let velocity = panner.velocity(in: view)

            var finalX: Double = 30
            var finalY: Double = Double(location.y)

            if location.x > UIScreen.main.bounds.size.width / 2 {
                finalX = Double(UIScreen.main.bounds.size.width) - 30.0
                self.button.changeSideDisplay(left: false)
            } else {
                self.button.changeSideDisplay(left: true)
            }

            let horizentalVelocity = abs(velocity.x)
            let positionX = abs(finalX - Double(location.x))

            let velocityForce = sqrt(pow(velocity.x, 2) * pow(velocity.y, 2))

            let durationAnimation = (velocityForce > 1000.0) ? min(0.3, positionX / Double(horizentalVelocity)) : 0.3

            if velocityForce > 1000.0 {
                finalY += Double(velocity.y) * durationAnimation
            }

            if finalY > Double(UIScreen.main.bounds.size.height) - 50 {
                finalY = Double(UIScreen.main.bounds.size.height) - 50
            } else if finalY < 50 {
                finalY = 50
            }

            UIView.animate(withDuration: durationAnimation * 5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 6,
                           options: UIViewAnimationOptions.allowUserInteraction,
                           animations: {
                            self.button.center = CGPoint(x: finalX, y: finalY)
                            self.button.transform = CGAffineTransform.identity
                }, completion: nil)
        }
    }

    func shouldReceive(point: CGPoint) -> Bool {
        if DeLogger.shared.displayedList {
            return true
        }
        return self.button.frame.contains(point)
    }
    
    /// ——————— 初始化VC ————————
    func getViewControllers() ->  [UIViewController] {
        
        var viewControllers = [UIViewController]()
        
        let logsStoryboard = UIStoryboard(name: "Logs", bundle: Bundle(for: ManagerListLogViewController.self))
        if let logsNaviController = logsStoryboard.instantiateInitialViewController() {
            self.setupChildViewController(controller: logsNaviController, title: "logs", imageName: "tabbar-logs@2x", selectImageName: "tabbar-logs@2x")
            viewControllers.append(logsNaviController)
        }
        
        let applicationStoryboard = UIStoryboard(name: "Application", bundle: Bundle(for: InformationsTableViewController.self))
        if let applicationNaviController = applicationStoryboard.instantiateInitialViewController() {
            self.setupChildViewController(controller: applicationNaviController, title: "application", imageName: "tabbar-app@2x", selectImageName: "tabbar-app@2x")
            viewControllers.append(applicationNaviController)

        }
        
        let settingsStoryboard = UIStoryboard(name: "Settings", bundle: Bundle(for: SettingsTableViewController.self))
        if let settingsNaviController = settingsStoryboard.instantiateInitialViewController() {
            self.setupChildViewController(controller: settingsNaviController, title: "settings", imageName: "tabbar-settings@2x", selectImageName: "tabbar-settings@2x")
            viewControllers.append(settingsNaviController)

        }
        
        return viewControllers
    }
    
    //设置TabbarItem 以及NavigationController
    func setupChildViewController(controller: UIViewController, title: String, imageName: String, selectImageName: String) {
//        let item = UITabBarItem(title: title, image: UIImage(named: imageName)?.withRenderingMode(.automatic), selectedImage: UIImage(named: selectImageName)?.withRenderingMode(.automatic))
//        controller.tabBarItem = item
    }
}
