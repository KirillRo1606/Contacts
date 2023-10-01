import UIKit
import SnapKit

final class DetailContactViewController: UIViewController {

// MARK: - Properties

    struct Constants {
        static let fullNameLabelText = "Full Name:"
        static let phoneNumberLabelText = "Phone Number:"
        static let editButtonTitle = "Edit"
        static let doneButtonTitle = "Save"
    }
    var contact: Contact? {
        didSet {
            photoImageView.image = UIImage(named: "baseline")
            fullNameTextField.text = contact?.fullName
            phoneNumberTextField.text = contact?.phoneNumber
        }
    }

// MARK: - UI Elements

    private let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.layer.cornerRadius = 60
        photoImageView.contentMode = .scaleToFill
        return photoImageView
    }()
    private let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = Constants.fullNameLabelText
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    private let fullNameTextField: UITextField = {
        let fullNameTextField = UITextField()
        fullNameTextField.isUserInteractionEnabled = false
        fullNameTextField.borderStyle = .roundedRect
        fullNameTextField.translatesAutoresizingMaskIntoConstraints = false
        return fullNameTextField
    }()
    private let phoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.text = Constants.phoneNumberLabelText
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumberLabel
    }()
    private let phoneNumberTextField: UITextField = {
        let phoneNumberTextField = UITextField()
        phoneNumberTextField.isUserInteractionEnabled = false
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumberTextField
    }()
    private let fullNameStackView: UIStackView = {
        let fullNameStackView = UIStackView()
        fullNameStackView.axis = .horizontal
        fullNameStackView.alignment = .leading
        fullNameStackView.spacing = 10
        fullNameStackView.translatesAutoresizingMaskIntoConstraints = false
        return fullNameStackView
    }()
    private let phoneNumberStackView: UIStackView = {
        let phoneNumberStackView = UIStackView()
        phoneNumberStackView.axis = .horizontal
        phoneNumberStackView.alignment = .leading
        phoneNumberStackView.spacing = 10
        phoneNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumberStackView
    }()
    private let informationStackView: UIStackView = {
        let informationStackView = UIStackView()
        informationStackView.axis = .vertical
        informationStackView.alignment = .leading
        informationStackView.spacing = 10
        return informationStackView
    }()
    private let editButton: UIButton = {
        let editButton = UIButton()
        editButton.setTitle(Constants.editButtonTitle, for: .normal)
        editButton.setTitle(Constants.doneButtonTitle, for: .selected)
        editButton.setTitleColor(.systemBlue, for: .normal)
        editButton.setTitleColor(.systemBlue, for: .selected)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        return editButton
    }()

// MARK: - View Did Load Method

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setViews()
        addConstraints()
        addKeyboardFunctionality()
    }
}

// MARK: - Add Views Method

extension DetailContactViewController {
    private func addViews() {
        view.addSubview(photoImageView)
        [ fullNameLabel, fullNameTextField ].forEach { element in
            fullNameStackView.addArrangedSubview(element)
        }
        [ phoneNumberLabel, phoneNumberTextField ].forEach { element in
            phoneNumberStackView.addArrangedSubview(element)
        }
        [ fullNameStackView, phoneNumberStackView ].forEach { stack in
            informationStackView.addArrangedSubview(stack)
        }
        view.addSubview(informationStackView)
    }
}

// MARK: - Set Views Method

extension DetailContactViewController: UITextFieldDelegate {
    private func setViews() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        editButton.addTarget(self, action: #selector(editPush(sender:)), for: .touchUpInside)
        fullNameTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    @objc func editPush(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        fullNameTextField.isUserInteractionEnabled = sender.isSelected
        phoneNumberTextField.isUserInteractionEnabled = sender.isSelected
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Constraints

extension DetailContactViewController {
    private func addConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(120)
        }
        fullNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(fullNameTextField)
        }
        phoneNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(phoneNumberTextField)
        }
        informationStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            //make.centerX.equalTo(view.snp.centerX)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
}

// MARK: - Keyboard Methods

extension DetailContactViewController {
    private func addKeyboardFunctionality() {
        NotificationCenter.default.addObserver(
            self, selector:
                #selector(keyboardWillShow), name:
                UIResponder.keyboardWillShowNotification, object:
                nil
        )
        NotificationCenter.default.addObserver(
            self, selector:
                #selector(keyboardWillHide), name:
                UIResponder.keyboardWillHideNotification, object:
                nil
        )
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (
            notification.userInfo?[
                UIResponder.keyboardFrameEndUserInfoKey
            ] as? NSValue
        )?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height) / 2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
