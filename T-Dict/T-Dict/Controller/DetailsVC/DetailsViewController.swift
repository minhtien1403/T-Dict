//
//  DetailsViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/19/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet private weak var segmentControl: UISegmentedControl!
    private var childViews = [UIViewController]()
    private var pageController: UIPageViewController!
    private var currentPageIndex = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configNavigationBar()
        setupChildViews()
        setupPageController()
    }
    
    func configViews() {
        title = "Details"
    }
    
    func configNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.listImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setupChildViews() {
        let defineVC = DefinitionViewController()
        let synonymsVC = InformationViewController()
        let antonymsVC = InformationViewController()
        let rhymeVC = InformationViewController()
        defineVC.view.tag = 0
        synonymsVC.view.tag = 1
        antonymsVC.view.tag = 2
        rhymeVC.view.tag = 3
        childViews = [defineVC, synonymsVC, antonymsVC, rhymeVC]
    }
    
    func setupPageController() {
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.delegate = self
        pageController.dataSource = self
        pageController.view.backgroundColor = .clear
        guard let navBottom = navigationController?.navigationBar.bottom else {
            return
        }
        pageController.view.frame = CGRect(x: 0,
                                           y: navBottom + segmentControl.height,
                                           width: view.width,
                                           height: view.height)
        pageController.setViewControllers([childViews[currentPageIndex]], direction: .forward, animated: true, completion: nil)
        pageController?.didMove(toParent: self)
        addChild(pageController)
        view.addSubview(pageController.view)
    }
}
extension DetailsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
