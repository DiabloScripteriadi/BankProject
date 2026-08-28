//
//  AIOrbButton.swift
//  BNK
//
//  Created by chasemedkcorto on 22.07.26.
//

//Ai-s gavaketebine dro ar davxarje
import UIKit
final class AIOrbButton: UIButton {

    var ringColors: [UIColor] = [
        UIColor(red: 0.36, green: 0.31, blue: 0.91, alpha: 1),  // indigo
        UIColor(red: 0.13, green: 0.78, blue: 0.69, alpha: 1),  // teal
        UIColor(red: 0.95, green: 0.72, blue: 0.29, alpha: 1),  // gold
    ] {
        didSet { conicLayer.colors = conicColors }
    }

    private let diameter: CGFloat

    private let conicLayer = CAGradientLayer()
    private let innerLayer = CALayer()
    private let sparkLayer = CAShapeLayer()
    private let ring1 = CAShapeLayer()
    private let ring2 = CAShapeLayer()

    private var isAnimating = false

    init(diameter: CGFloat = 64) {
        self.diameter = diameter
        super.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        setupLayers()
        addTarget(self, action: #selector(handleDown), for: .touchDown)
        addTarget(self, action: #selector(handleUp), for: [.touchUpInside, .touchUpOutside, .touchCancel, .touchDragExit])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override var intrinsicContentSize: CGSize { CGSize(width: diameter, height: diameter) }


    private var conicColors: [CGColor] {
        (ringColors + [ringColors[0]]).map { $0.cgColor }
    }

    private func setupLayers() {
        layer.shadowColor = ringColors[0].cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 18
        layer.shadowOffset = CGSize(width: 0, height: 10)

        [ring1, ring2].forEach { ring in
            ring.fillColor = UIColor.clear.cgColor
            ring.strokeColor = ringColors[1].withAlphaComponent(0.4).cgColor
            ring.lineWidth = 1
            layer.addSublayer(ring)
        }

        conicLayer.type = .conic
        conicLayer.colors = conicColors
        conicLayer.frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        let ringMask = CAShapeLayer()
        ringMask.path = UIBezierPath(ovalIn: conicLayer.bounds).cgPath
        conicLayer.mask = ringMask
        layer.addSublayer(conicLayer)

        let inset: CGFloat = 5
        innerLayer.frame = CGRect(x: inset, y: inset, width: diameter - inset * 2, height: diameter - inset * 2)
        innerLayer.cornerRadius = innerLayer.frame.width / 2
        innerLayer.backgroundColor = UIColor(red: 0.07, green: 0.08, blue: 0.12, alpha: 1).cgColor
        layer.addSublayer(innerLayer)

        let sparkSize: CGFloat = diameter * 0.32
        sparkLayer.path = starPath(in: CGRect(x: 0, y: 0, width: sparkSize, height: sparkSize)).cgPath
        sparkLayer.fillColor = UIColor.white.cgColor
        sparkLayer.bounds = CGRect(x: 0, y: 0, width: sparkSize, height: sparkSize)
        sparkLayer.position = CGPoint(x: diameter / 2, y: diameter / 2)
        layer.addSublayer(sparkLayer)
    }

    private func starPath(in rect: CGRect) -> UIBezierPath {
        let w = rect.width, h = rect.height
        let path = UIBezierPath()
        path.move(to: CGPoint(x: w * 0.5, y: 0))
        path.addLine(to: CGPoint(x: w * 0.61, y: h * 0.39))
        path.addLine(to: CGPoint(x: w, y: h * 0.5))
        path.addLine(to: CGPoint(x: w * 0.61, y: h * 0.61))
        path.addLine(to: CGPoint(x: w * 0.5, y: h))
        path.addLine(to: CGPoint(x: w * 0.39, y: h * 0.61))
        path.addLine(to: CGPoint(x: 0, y: h * 0.5))
        path.addLine(to: CGPoint(x: w * 0.39, y: h * 0.39))
        path.close()
        return path
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        [ring1, ring2].forEach {
            $0.frame = bounds.insetBy(dx: -7, dy: -7)
            $0.path = UIBezierPath(ovalIn: $0.bounds).cgPath
        }
    }


    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil {
            startAmbientAnimations()
        } else {
            stopAmbientAnimations()
        }
    }

    private func startAmbientAnimations() {
        guard !isAnimating else { return }
        isAnimating = true

        // Spin the conic ring
        let spin = CABasicAnimation(keyPath: "transform.rotation.z")
        spin.fromValue = 0
        spin.toValue = Double.pi * 2
        spin.duration = 5
        spin.repeatCount = .infinity
        conicLayer.add(spin, forKey: "spin")

        // Pulse the spark
        let pulse = CAKeyframeAnimation(keyPath: "transform")
        pulse.values = [
            CATransform3DIdentity,
            CATransform3DConcat(CATransform3DMakeScale(1.18, 1.18, 1), CATransform3DMakeRotation(.pi / 7, 0, 0, 1)),
            CATransform3DIdentity
        ]
        pulse.keyTimes = [0, 0.5, 1]
        pulse.duration = 2.2
        pulse.repeatCount = .infinity
        sparkLayer.add(pulse, forKey: "pulse")

        // Ripple rings, staggered
        addRipple(to: ring1, delay: 0)
        addRipple(to: ring2, delay: 1.3)

        // Idle float
        let float = CAKeyframeAnimation(keyPath: "transform.translation.y")
        float.values = [0, -7, 0]
        float.keyTimes = [0, 0.5, 1]
        float.duration = 3.4
        float.repeatCount = .infinity
        float.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        layer.add(float, forKey: "float")
    }

    private func addRipple(to ring: CAShapeLayer, delay: CFTimeInterval) {
        let group = CAAnimationGroup()
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 0.85
        scale.toValue = 1.5
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0.7
        opacity.toValue = 0.0
        group.animations = [scale, opacity]
        group.duration = 2.6
        group.beginTime = CACurrentMediaTime() + delay
        group.repeatCount = .infinity
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        ring.add(group, forKey: "ripple")
    }

    private func stopAmbientAnimations() {
        isAnimating = false
        conicLayer.removeAnimation(forKey: "spin")
        sparkLayer.removeAnimation(forKey: "pulse")
        ring1.removeAnimation(forKey: "ripple")
        ring2.removeAnimation(forKey: "ripple")
        layer.removeAnimation(forKey: "float")
    }


    @objc private func handleDown() {
        conicLayer.speed = 0 // pause spin mid-frame
        UIView.animate(withDuration: 0.12, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) {
            self.transform = CGAffineTransform(translationX: 0, y: 2).scaledBy(x: 0.94, y: 0.94)
        }
    }

    @objc private func handleUp() {
        conicLayer.speed = 1
        UIView.animate(
            withDuration: 0.35, delay: 0,
            usingSpringWithDamping: 0.55, initialSpringVelocity: 0.4,
            options: [.allowUserInteraction]
        ) {
            self.transform = .identity
        }
    }
}
