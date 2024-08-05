//
//  Rules.swift
//  SwiftFormatPlugin
//
//  Copyright © 2023 UnpxreTW. All rights reserved.
//

/// 格式規則
enum Rule {

	/// 不啟用的規則
	case disable(rules: String)
}

extension Rule {

	/// 取得當前規則的名稱
	///
	/// 使用 `Mirror` 取得規則名稱
	var name: String? { Mirror(reflecting: self).children.first?.label }

	/// 規則的設定值
	var option: String? {
		guard
			/// 取出當前解析的規則
			let rule = Mirror(reflecting: self).children.first,
			/// 取得當前解析規則附帶的設定值
			let associated = Mirror(reflecting: rule).children.dropFirst().first?.value
		else { return nil }
		if let option = associated as? String {
			// 如果此規則附帶的設定值沒有標題則可以直接轉換為字串
			return option
		} else if let option = Mirror(reflecting: associatedValue).children.first?.value as? String {
			// 如果此規則附帶的設定值有參數如： `.disqble(rules:)` 則需要在做一次反射取得其中的值
			return option
		} else {
			return nil
		}
	}

	/// 要使用於命令行參數的字串
	var command: [String] {
		guard let ruleName: String = self.name, let option = self.option else { return [] }
		return ["--\(ruleName)", option]
	}
}

extension Rule {

	// 所有使用中的規則與其設定值
	static var allRules: [Rule] = [
		// 預設不啟用所有規則
		.disable(rules: "all")
	]

	/// 將設定的規則轉換為命令行指令
	static var allToCommand: [String] { Self.allRules.map { $0.command }.flatMap { $0 } }
}

