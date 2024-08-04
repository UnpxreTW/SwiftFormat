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

	// MARK: - 格式規則

	/// 特定縮寫自動全大寫
	case acronyms
}

extension Rule {

	/// 取得當前規則的名稱
	///
	/// 使用 `Mirror` 取得規則名稱
	var name: String? { Mirror(reflecting: self).children.first?.label }

	/// 規則的設定值
	var option: String? { 
		guard let rule = Mirror(reflecting: self).children.first else { return nil }
		// !!!: 一個規則只會帶一個設定值字串
		let option = Mirror(reflecting: rule).children.first?.value
		switch option {
		case as String:
			return option
		}
	}

	/// 要使用於命令行參數的字串
	var command: [String] {
		guard let ruleName: String = self.name, let option = self.option else { return [] }
		return [ruleName, option]
	}
}

extension Rule {

	// 所有使用中的規則與其設定值
	static var allRules: [Rule] = [
		.disable(rules: "all")
	]
}

