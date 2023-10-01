import UIKit
import SnapKit

class ContactsViewController: UIViewController {

// MARK: - Constraints

    struct Constraints {
        static let contactsTitle = "Contacts"
    }
    
    private var contactsData = ContactsData.getContacts()
    private let contactsTableView = UITableView()

// MARK: - View Did Load Method

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = Constraints.contactsTitle
        setContactsTableView()
        addViews()
        addConstraints()
        
    }

// MARK: - Add Views Method

    private func addViews() {
        view.addSubview(contactsTableView)
        //tabBarItem.tag = 110
    }
}

// MARK: - Set Table View

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    private func setContactsTableView() {
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        contactsTableView.register(ContactCell.self, forCellReuseIdentifier: "contactCell")
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

extension ContactsViewController {
    private func addConstraints() {
        contactsTableView.snp.makeConstraints { make in
            make.size.equalTo(self.view)
        }
    }
}
