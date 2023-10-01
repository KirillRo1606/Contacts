import UIKit
import SnapKit

final class ContactsTabBarController: UITabBarController, UITabBarControllerDelegate {

// MARK: - Properties

    struct Constraints {
        static let contactsTabTitle = "Contacts"
        static let favouritesTabTitle = "Favourites"
        static let contactsTabImage = UIImage(named: "baseline")
        static let favouritesTabImage = UIImage(named: "favorite")
    }

// MARK: - View Did Load Method

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        //self.navigationItem.title = self.selectedViewController?.title
        //self.navigationController?.navigationItem.title = 
    }

// MARK: - View Will Appear Method

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UINavigationBar.appearance().prefersLargeTitles = true
        generateViewControllers()
    }
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        }

// MARK: - Generate View Controllers

    private func generateViewControllers() {
        let contactsViewController = ContactsViewController()
        contactsViewController.title = Constraints.contactsTabTitle
        contactsViewController.tabBarItem.image = Constraints.contactsTabImage
//        contactsViewController.tabBarItem.im
//        let contactsTabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
//        contactsTab.tabBarItem = contactsTabBarItem
        
        let favouritesViewController = FavouritesViewController()
        favouritesViewController.title = Constraints.favouritesTabTitle
        favouritesViewController.tabBarItem.image = Constraints.favouritesTabImage

        self.viewControllers = [contactsViewController, favouritesViewController]
    }
}
