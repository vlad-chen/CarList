//
//  Font.swift
//  CarList
//
//  Created by Vlad Che on 12/2/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation
import UIKit

public enum Font {
    case display
    case text
    case system
    case with(family: String)
    indirect case italic(Font)
    
    // MARK: - Public -
    
    var black: UIFont { return font(with: Font.Weight.black.rawValue) }
    var bold: UIFont { return font(with: Font.Weight.bold.rawValue) }
    var heavy: UIFont { return font(with: Font.Weight.heavy.rawValue) }
    var light: UIFont { return font(with: Font.Weight.light.rawValue) }
    var medium: UIFont { return font(with: Font.Weight.medium.rawValue) }
    var regular: UIFont { return font(with: Font.Weight.regular.rawValue) }
    var semibold: UIFont { return font(with: Font.Weight.semibold.rawValue) }
    var ultralight: UIFont { return font(with: Font.Weight.ultralight.rawValue) }
    var thin: UIFont { return font(with: Font.Weight.thin.rawValue) }
    
    var body: UIFont { return font(for: .body) }
    var title: UIFont { return font(for: .title2) }
    var footnote: UIFont { return font(for: .footnote) }
    var caption: UIFont { return font(for: .caption1) }
    var callout: UIFont { return font(for: .callout) }
    var headline: UIFont { return font(for: .headline) }
    var subheadline: UIFont { return font(for: .subheadline) }
    
    // MARK: - Private -
    
    private var family: String {
        switch self {
        case .display: return "SFProDisplay-"
        case .text: return "SFProText-"
        case .system: return ""
        case .with(let family): return family
        case .italic(let font): return font.family
        }
    }
    
    private var size: CGFloat {
        return UIFont.systemFontSize
    }
    
    private func font(with weight: String) -> UIFont {
        if case .system = self {
            return UIFont.systemFont(ofSize: size, weight: uiFontWeight(for: weight))
        }
        do {
            var name = family + weight
            if case .italic = self { name += Font.Weight.italic.rawValue }
            return try font(for: name)
        } catch (let error) {
            print(error)
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    private func font(for name: String) throws -> UIFont {
        if let font = UIFont(name: name, size: size) {
            return font
        } else {
            throw Error.with(message: "Can't create font with name: \(name)")
        }
    }
    
    private func font(for style: UIFontTextStyle) -> UIFont {
        if case .system = self {
            return UIFont.preferredFont(forTextStyle: style)
        } else {
            return UIFontMetrics(forTextStyle: style).scaledFont(for: medium)
        }
    }
    
    private func uiFontWeight(for weight: String) -> UIFont.Weight {
        return (Font.Weight(rawValue: weight) ?? Font.Weight.medium).uiFontWeigth
    }
    
    private enum Weight: String {
        case black = "Black"
        case bold = "Bold"
        case heavy = "Heavy"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semibold = "Semibold"
        case ultralight = "Ultralight"
        case thin = "Thin"
        case italic = "Italic"
        
        var uiFontWeigth: UIFont.Weight {
            switch self {
            case .black: return .black
            case .bold: return .bold
            case .heavy: return .heavy
            case .light: return .light
            case .medium: return .medium
            case .regular: return .regular
            case .semibold: return .semibold
            case .ultralight: return .ultraLight
            case .thin: return .thin
            case .italic: return .medium
            }
        }
        
    }
    
}
