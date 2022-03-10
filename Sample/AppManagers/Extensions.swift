//
//  Extensions.swift
//   AppsMaven
//
//  Created by Sandip Gill on 16/12/20.
//

import UIKit


import Foundation
import UIKit


class RoundedImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        self.layer.cornerRadius = self.frame.height/2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String {
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    var isBlankByTrimming: Bool {
        let trimmed = self.trimmingCharacters(in:
            CharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    func trimWhitespacesAndNewlines() -> String{
        return self.trimmingCharacters(in:
            CharacterSet.whitespacesAndNewlines)
    }

    func isValidEmail() -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = incomingFormat
      dateFormatter.timeZone = TimeZone(abbreviation: "en_US")

      let dt = dateFormatter.date(from: self)
      dateFormatter.timeZone = TimeZone.current
      dateFormatter.dateFormat = outGoingFormat
      return dateFormatter.string(from: dt ?? Date())
    }
}


extension NSMutableAttributedString {
    func setFontFace(font: UIFont, color: UIColor? = nil) {
        beginEditing()
        self.enumerateAttribute(
            .font,
            in: NSRange(location: 0, length: self.length)
        ) { (value, range, stop) in

            if let f = value as? UIFont,
              let newFontDescriptor = f.fontDescriptor
                .withFamily(font.familyName)
                .withSymbolicTraits(f.fontDescriptor.symbolicTraits) {

                let newFont = UIFont(
                    descriptor: newFontDescriptor,
                    size: font.pointSize
                )
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                if let color = color {
                    removeAttribute(
                        .foregroundColor,
                        range: range
                    )
                    addAttribute(
                        .foregroundColor,
                        value: color,
                        range: range
                    )
                }
            }
        }
        endEditing()
    }
}

extension UIView{
    
    @IBInspectable var setRound: Bool {
        get {
            return self.setRound
        }
        set {
            DispatchQueue.main.async {
                self.layer.cornerRadius = self.frame.size.height/2
            }
        }
    }
    
    @IBInspectable var setCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            
            DispatchQueue.main.async {
                self.layer.cornerRadius = newValue
            }
        }
    }
    
    func roundCorners(cornerRadius: Double) {
           self.layer.cornerRadius = CGFloat(cornerRadius)
           self.clipsToBounds = true
       }
       
       func roundCornersWithBorderColor() {
           self.layer.borderWidth = 1
           //        self.layer.borderColor = UIColor(red:9.0/255.0, green:168.0/255.0, blue:170.0/255.0, alpha:1.0).cgColor
           self.layer.cornerRadius = 5.0
           self.clipsToBounds = true
       }
    
    func createGradientLayer(color1: UIColor, color2: UIColor, type: CAGradientLayerType?) {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        
        if type == .radial
        {
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.6)
            gradientLayer.endPoint = CGPoint(x: 2.2, y: 1.6)
            gradientLayer.type = type ?? .radial
            self.layer.addSublayer(gradientLayer)
        }
        else if type == .axial
        {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.9)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.1)
            gradientLayer.type = .axial
            self.layer.addSublayer(gradientLayer)
        }
        else if type == nil // customize
        {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
            self.layer.insertSublayer(gradientLayer, at: 0)
            //gradientLayer.type = .axial
            
        }
    }
    
    func addDashedBorder(x: Int) {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1).cgColor
        shapeLayer.lineWidth = 1.5
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,2]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: x, y: 0),
                                CGPoint(x: x, y: Int(self.frame.height))])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func addShadowView(width:CGFloat=0.2, height:CGFloat=0.2, Opacidade:Float=0.7, maskToBounds:Bool=false, radius:CGFloat=0.5){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Opacidade
        self.layer.masksToBounds = maskToBounds
    }
    
    func addCornerRadiusWithShadow(cornerRadius: CGFloat) {
        // set the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        // set the shadow properties
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
    }
}
extension UIColor {
        convenience init(red: Int, green: Int, blue: Int) {
            assert(red >= 0 && red <= 255, "Invalid red component")
            assert(green >= 0 && green <= 255, "Invalid green component")
            assert(blue >= 0 && blue <= 255, "Invalid blue component")
            
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        }
        
        convenience init(rgb: Int) {
            self.init(
                red: (rgb >> 16) & 0xFF,
                green: (rgb >> 8) & 0xFF,
                blue: rgb & 0xFF
            )
        }
    
    @nonobjc class var primary: UIColor {
        return UIColor(red: 4.0 / 255.0, green: 145.0 / 255.0, blue: 1.0, alpha: 1.0)
      }
    @nonobjc class var secondary: UIColor {
        return UIColor(red: 120.0 / 255.0, green: 134.0 / 255.0, blue: 158.0 / 255.0, alpha: 1.0)
      }
    @nonobjc class var tertiary: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
      }
    @nonobjc class var textHead: UIColor {
        return UIColor(red: 4.0 / 255.0, green: 44.0 / 255.0, blue: 92.0 / 255.0, alpha: 1.0)
      }
    @nonobjc class var background: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 250.0 / 255.0, blue: 1.0, alpha: 1.0)
      }
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
      }
    @nonobjc class var algaeGreen: UIColor {
        return UIColor(red: 42.0 / 255.0, green: 217.0 / 255.0, blue: 90.0 / 255.0, alpha: 1.0)
      }
    @nonobjc class var blueGrey: UIColor {
      return UIColor(red: 120.0 / 255.0, green: 134.0 / 255.0, blue: 158.0 / 255.0, alpha: 1.0)
    }
}

extension UIButton
{
    func createGradLayer(color1: UIColor, color2: UIColor, type: CAGradientLayerType) {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        // gradientLayer.type = type
        
        self.layer.insertSublayer(gradientLayer, at: 0)//.addSublayer(gradientLayer)
        
    }
    
    func imageSet(image:String) {
        self.setImage(UIImage.init(named: image), for: .normal)
    }
}

private var kAssociationKeyMaxLength: Int = 0

extension UITextField{

    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }

        let selection = selectedTextRange

        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)

        selectedTextRange = selection
    }
}




extension DateFormatter {
    
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone.current
    return formatter
  }()
    
    static let iso8601: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone.current
      return formatter
    }()
    
    static let yyyyMMdd: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone.current
      return formatter
    }()
    
    static let hhmma: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "hh:mm a"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone.current
      return formatter
    }()
}
