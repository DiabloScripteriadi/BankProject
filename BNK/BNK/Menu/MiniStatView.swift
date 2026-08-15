import UIKit

class MiniStatView: UIView {

    init(icon: String, title: String, value: String) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        let image = UIImageView(image: UIImage(systemName: icon))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white


        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        titleLabel.font = .systemFont(ofSize: 12)


        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.textColor = .white
        valueLabel.font = .systemFont(ofSize: 15, weight: .bold)


        addSubview(image)
        addSubview(titleLabel)
        addSubview(valueLabel)


        NSLayoutConstraint.activate([

            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.widthAnchor.constraint(equalToConstant: 18),
            image.heightAnchor.constraint(equalToConstant: 18),


            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 6),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),


            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),

            bottomAnchor.constraint(equalTo: valueLabel.bottomAnchor)

        ])
    }


    required init?(coder: NSCoder) {
        fatalError()
    }
}