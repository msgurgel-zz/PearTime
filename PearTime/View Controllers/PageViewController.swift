// File        : PageViewController.Swift
// Project     : PearTime
// Author      : Adam Tunkiewicz
// Date        : October 4th, 2019
// Description : This file contains the mechanisms to switch between views for selecting
//               different kinds of timers.

import UIKit

class PageViewController: UIPageViewController , UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // Contains an index of views that can be cycled through
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(viewController: "Pomodoro"),
                self.newViewController(viewController: "Custom")]
    }()
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view based on the selected index
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers(
                [firstViewController],
                direction: .forward,
                animated: true,
                completion: nil)
        }
        
        self.delegate = self
        configurePageControl()
    }
    
    // Creates the 3-dot control at the bottom of the selection view
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
    
    // This function switches the index of the controllers when the user swipes left or right
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController)
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
    
    // This function also switches the index of the view controller array, when combined
    // with the previous function, the user should be able to infinitely scroll left or right
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController)
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
    
    // This function loads the view controller based on the selected index
    func pageViewController(_ pageViewController: UIPageViewController , didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool)
    {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
    }
    
    // This function creates an instance of all the indexed controllers
    func newViewController(viewController: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }

}
