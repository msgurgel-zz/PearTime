//
//  PageViewController.swift
//  PearTime
//
//  Created by Student on 2019-10-02.
//  Copyright © 2019 Mateus Gurgel. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController , UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(viewController: "Pomodoro"),
                self.newViewController(viewController: "Custom")]
    }()
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers(
                [firstViewController],
                direction: .forward,
                animated: true,
                completion: nil)
        }
        // Do any additional setup after loading the view.
        
        self.delegate = self
        configurePageControl()
    }
    
    func configurePageControl()
    {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController)
        else
        {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0
        else
        {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex
        else
        {
                return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController)
        else
        {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex
        else
        {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllers.count > nextIndex
        else
        {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController , didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool)
    {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    func newViewController(viewController: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }

}
