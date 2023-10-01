import UIKit
import SnapKit

class FavouritesViewController: UIViewController {

// MARK: - Constraints

    struct Constraints {
        static let favouritesTitle = "Favourites"
    }
    private var contactsData = ContactsData.getContacts()
    private let favouritesTableView = UITableView()

// MARK: - View Did Load Method

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = Constraints.favouritesTitle
        setFavouritesTableView()
        addViews()
        addConstraints()
        }
    }

    // MARK: - Add Views Method

extension FavouritesViewController {
    private func addViews() {
        view.addSubview(favouritesTableView)
    }
}

// MARK: - Set Table View

extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    private func setFavouritesTableView() {
        favouritesTableView.dataSource = self
        favouritesTableView.delegate = self
        favouritesTableView.register(ContactCell.self, forCellReuseIdentifier: "contactCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactCell {
            cell.contact = contactsData[indexPath.row]
            return cell
        }
            return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailContactViewController = DetailContactViewController()
        detailContactViewController.contact = contactsData[indexPath.row]
        navigationController?.pushViewController(detailContactViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - Constraints

extension FavouritesViewController {
    private func addConstraints() {
        favouritesTableView.snp.makeConstraints { make in
            make.size.equalTo(self.view)
        }
    }
}
