import UIKit

@IBDesignable public class GradientView: UIView {
    @IBInspectable var startColor: UIColor = .black {
        didSet { updateColors() }
    }
    @IBInspectable var endColor: UIColor = .white {
        didSet { updateColors() }
    }
    @IBInspectable var startLocation: Double = 0.05 {
        didSet { updateLocations() }
    }
    @IBInspectable var endLocation: Double = 0.95 {
        didSet { updateLocations() }
    }
    override public class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateLocations()
        updateColors()
    }
}
