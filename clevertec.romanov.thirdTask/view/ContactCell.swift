import UIKit
import SnapKit

final class ContactCell: UITableViewCell {
    
    

// MARK: - Properties

    struct Constants {
        static let isSimpleImageIcon = UIImage(
            named: "favorite_border")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        static let isFavouriteImageIcon = UIImage(
            named: "favorite")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    }
    var isFavourite: Bool?
    var contact: Contact? {
        didSet {
            photoImageView.image = UIImage(named: "baseline")
            fullNameLabel.text = contact?.fullName
            phoneNumberLabel.text = contact?.phoneNumber
            isFavourite = contact?.isFavourite
        }
    }

// MARK: - UI Elements

    lazy var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.layer.cornerRadius = 30
        photoImageView.contentMode = .scaleAspectFit
        return photoImageView
    }()
    lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = .systemFont(ofSize: 20)
        fullNameLabel.textColor = .darkGray
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    lazy var phoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.font = .systemFont(ofSize: 20)
        phoneNumberLabel.textColor = .lightGray
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumberLabel
    }()
    lazy var informationStackView: UIStackView = {
        let informationStackView = UIStackView()
        informationStackView.axis = .vertical
        informationStackView.alignment = .leading
        informationStackView.spacing = 5
        return informationStackView
    }()
    lazy var favouriteButton: UIButton = {
        let favouriteButton = UIButton()
        favouriteButton.setImage(Constants.isSimpleImageIcon, for: .normal)
        favouriteButton.setImage(Constants.isFavouriteImageIcon, for: .selected)
        favouriteButton.tintColor = .red
        favouriteButton.contentMode = .center
        return favouriteButton
    }()

// MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        addConstraints()
        makeFavourite()
     }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

// MARK: - Add Views Method

        private func addViews() {
            self.contentView.addSubview(photoImageView)
            [fullNameLabel, phoneNumberLabel ].forEach { element in
                informationStackView.addArrangedSubview(element)
            }
            self.contentView.addSubview(informationStackView)
            self.contentView.addSubview(favouriteButton)
        }

// MARK: - Make Favourite Method

    func makeFavourite() {
        favouriteButton.addTarget(self, action: #selector(makeFavourite(sender:)), for: .touchUpInside)
    }
    @objc func makeFavourite(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isFavourite = sender.isSelected
    }
}


// MARK: - Constraints

extension ContactCell {
    private func addConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.size.equalTo(60)
        }
        informationStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.top)
            make.leading.equalTo(photoImageView.snp.trailing).offset(10)
        }
        favouriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.size.equalTo(40)
        }
    }
}
