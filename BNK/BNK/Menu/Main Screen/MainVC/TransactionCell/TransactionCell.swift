//
//  TransactionCell.swift
//  BNK
//
//  Created by chasemedkcorto on 12.02.26.
//
import UIKit

final class TransactionCell: UITableViewCell {

    var onTap: (() -> Void)?

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
        view.layer.cornerCurve = .continuous

        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.separator.withAlphaComponent(0.18).cgColor

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 5)

        return view
    }()

    private let iconBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.12)
        view.layer.cornerRadius = 22
        return view
    }()

    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.left.arrow.right")
        image.tintColor = .systemBlue
        image.preferredSymbolConfiguration =
        UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)

        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No transactions yet"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your payments and transfers will appear here"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()

    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle("View", for: .normal)
        button.setImage(
            UIImage(systemName: "chevron.right"),
            for: .normal
        )

        button.tintColor = .systemBlue
        button.titleLabel?.font =
        .systemFont(ofSize: 14, weight: .semibold)

        button.semanticContentAttribute = .forceRightToLeft

        return button
    }()


    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {

        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)

        setup()
    }


    required init?(coder: NSCoder) {
        fatalError()
    }


    private func setup() {

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none


        contentView.addSubview(containerView)

        containerView.addSubview(iconBackground)
        iconBackground.addSubview(iconImage)

        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(actionButton)


        NSLayoutConstraint.activate([

            containerView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            ),

            containerView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),

            containerView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),

            containerView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8
            ),



            iconBackground.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 18
            ),

            iconBackground.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor
            ),

            iconBackground.widthAnchor.constraint(
                equalToConstant: 44
            ),

            iconBackground.heightAnchor.constraint(
                equalToConstant: 44
            ),


            iconImage.centerXAnchor.constraint(
                equalTo: iconBackground.centerXAnchor
            ),

            iconImage.centerYAnchor.constraint(
                equalTo: iconBackground.centerYAnchor
            ),



            titleLabel.leadingAnchor.constraint(
                equalTo: iconBackground.trailingAnchor,
                constant: 14
            ),

            titleLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 18
            ),



            subtitleLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),

            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 4
            ),



            actionButton.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -18
            ),

            actionButton.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor
            )
        ])


        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapped)
        )

        containerView.addGestureRecognizer(tap)
    }



    override func setHighlighted(_ highlighted: Bool,
                                 animated: Bool) {

        UIView.animate(
            withDuration: 0.15
        ) {

            self.containerView.transform =
            highlighted
            ? CGAffineTransform(scaleX: 0.97, y: 0.97)
            : .identity
        }
    }



    @objc private func tapped() {
        onTap?()
    }
}
