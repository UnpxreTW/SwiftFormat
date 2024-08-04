//
//  Rules.swift
//  SwiftFormatPlugin
//
//  Copyright © 2023 UnpxreTW. All rights reserved.
//

// 格式規則
enum Rule {

	// 不啟用的規則
	case disable(rules: String)

	// MARK: - 格式規則

	// 特定縮寫自動全大寫
	case acronyms
}

extension Rule {

	// 取得當前規則的名稱
	//
	// 使用 `Mirror` 取得規則名稱
	var name: String? { Mirror(reflecting: self).children.first?.label }

	// 規則的設定值
	var option: String?

	// 要使用於命令行參數的字串
	var command: [String] {}
}

extension Rule {

	// 所有使用中的規則與其設定值
	static var allRules: [Rule] = [
		.disable(rules: "all")
	]
}

