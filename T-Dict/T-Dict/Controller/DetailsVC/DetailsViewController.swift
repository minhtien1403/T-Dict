//
//  DetailsViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/19/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController, UINavigationControllerDelegate {
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    private var childViews = [UIViewController]()
    private var pageController: UIPageViewController!
    private var currentPageIndex = 0
    private var defines = [String]()
    private var examples = [String]()
    private var word: String?
    
    init(word: String?) {
        super.init(nibName: nil, bundle: nil)
        guard let word = word else {
            APIService.shared.getRandomWord { [weak self] (response) in
                guard let randomWord = response?.word else {
                    return
                }
                DispatchQueue.main.async {
                    self?.word = randomWord
                    self?.viewWillAppear(true)
                }
            }
            return
        }
        self.word = word
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupChildViews()
        setupPageController()
    }
    
    //MARK: - Config View
    func configViews() {
        title = "Details"
    }
    
    func configNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.listImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapAddToList))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setupChildViews() {
        let defineVC = DefinitionViewController()
        let synonymsVC = InformationViewController(type: .synonyms)
        let antonymsVC = InformationViewController(type: .antonyms)
        let rhymeVC = InformationViewController(type: .rhymes)
        defineVC.view.tag = 0
        synonymsVC.view.tag = 1
        antonymsVC.view.tag = 2
        rhymeVC.view.tag = 3
        childViews = [defineVC, synonymsVC, antonymsVC, rhymeVC]
        configPages(pages: childViews)
    }
    
    func configPages(pages: [UIViewController]) {
        guard let define = pages.first as? DefinitionViewController else {
            return
        }
        define.config(word: word ?? "")
        for index in 1..<pages.count {
            guard let page = pages[index] as? InformationViewController else {
                return
            }
            page.config(word: word ?? "")
        }
    }
    
    func setupPageController() {
        pageController = UIPageViewController(transitionStyle: .scroll,
                                              navigationOrientation: .horizontal,
                                              options: nil)
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
        pageController.setViewControllers([childViews[currentPageIndex]],
                                          direction: .forward,
                                          animated: true,
                                          completion: nil)
        pageController?.didMove(toParent: self)
        addChild(pageController)
        view.addSubview(pageController.view)
    }
    //MARK: - Handle Events
    @IBAction func didChangeSegment(_ sender: Any) {
        let nextIndex = segmentControl.selectedSegmentIndex
        let direction = nextIndex < currentPageIndex ? UIPageViewController.NavigationDirection.reverse : UIPageViewController.NavigationDirection.forward
        pageController.setViewControllers([childViews[nextIndex]],
                                          direction: direction,
                                          animated: true,
                                          completion: nil)
        currentPageIndex = nextIndex
    }
    
    @objc func didTapAddToList() {
        guard let word = word else {
            print("Failed to add")
            return
        }
        guard let definceVC = childViews.first as? DefinitionViewController else {
            alertError(message: "Some thing wrong")
            return
        }
        let vc = ListViewController()
        vc.didTapCell = { [weak self] listname in
            if !CoreDataManager.ListItemManager.shared.addItemToList(word: word, pronounce: definceVC.getPronounce(), listName: listname) {
                self?.alertError(message: "This word is already in this List")
            }
        }
        present(vc, animated: true, completion: nil)
    }
}

extension DetailsViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        currentPageIndex = viewController.view.tag
        segmentControl.selectedSegmentIndex = currentPageIndex;
        let pageIndex = viewController.view.tag - 1;
        if pageIndex < 0 {
            return nil
        }
        return childViews[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        currentPageIndex = viewController.view.tag
        segmentControl.selectedSegmentIndex = currentPageIndex;
        let pageIndex = viewController.view.tag + 1;
        if pageIndex > childViews.count - 1 {
            return nil
        }
        return childViews[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageController.viewControllers,
            let currentIndex = childViews.firstIndex(of: viewController[0]) else {
            return
        }
        segmentControl.selectedSegmentIndex = currentIndex
    }
}


