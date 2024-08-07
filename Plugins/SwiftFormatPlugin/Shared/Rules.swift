//
//  Rules.swift
//  SwiftFormatPlugin
//
//  Copyright © 2023 UnpxreTW. All rights reserved.
//

/// 格式規則
enum Rule {

	// MARK: 命令參數

	/// 不啟用的規則
	case disable(rules: String)

	/// 使用的 Swift 版本
	case swiftversion(String)

	// MARK: 格式規則

	/// 當設定的單字字首為大寫時轉換成全大寫
	case acronyms(String)

	/// 偏好在 `if`、`guard`、`while` 中使用逗號取代 `&&`
	case andOperator(preferComma: Bool)

	/// 偏好在協議中中使用 `AnyObject` 取代 `class`
	case anyObjectProtocol(preferAnyObject: Bool)

	/// 偏好使用 `@main` 取代舊的 `@UIApplicationMain` 與 `@NSApplicationMain`
	case applicationMain(preferMain: Bool)
}

extension Rule {

	/// 取得當前規則的規則名稱與附帶的設定值
	///
	/// - note: 當前使用反射取得其內容
	private var currentCase: (label: String?, value: Any) { Mirror(reflecting: self).children.first! }

	/// 取得當前規則的名稱
	private var name: String? { currentCase.label }

	/// 規則的設定值
	///
	/// - note: 規則可能不包含設定值
	private var option: Any? {
		// !!!: `currentCase` 中第一個子元素為 case 本身，捨棄掉第一個元素後下一個元素應為其附帶的設定
		guard let associated = Mirror(reflecting: currentCase).children.dropFirst().first?.value else { return nil }
		return switch associated {
		// !!!: 如果附帶設定不包含標題時值可以直接取得設定值
		case let option as String: option
		case let option as Bool: option
		// !!!: 嘗試再次反射取得附加參數標題與設定值
		default: if let option = Mirror(reflecting: associated).children.first?.value { 
			switch option {
			case let option as String: option
			case let option as Bool: option
			default: nil
			}
		} else {
			nil
		}}
	}

	/// 使用當前命令設定產生使用於命令行參數的字串
	private var command: [String] {
		/// 如果無法正確取得名稱則可能為錯誤的配置不回傳產生的指令
		guard let name: String = self.name else {
			print("錯誤的規則名稱：")
			dump(self)
			return []
		}
		var command: [String] = if case .disable = self {
			[]
		} else if case .swiftversion = self {
			[]
		} else {
			["--enable", "\(name)"]
		}
		return switch self.option {
		case let option as String: command + ["--\(name)", option]
		case let option as Bool: option ? command : []
		default: []
		}
	}
}

extension Rule {

	// 所有使用中的規則與其設定值
	static let allRules: [Rule] = [
		// 預設不啟用所有規則
		.disable(rules: "all")

		, // 當前使用版本 `5.10`
		.swiftversion("5.10")

		, // 與預設相同選擇 "ID,URL,UUID"
		.acronyms("ID,URL,UUID")

		, // 偏好逗號取代 `&&` 在判斷式中
		.andOperator(preferComma: true)

		, // 偏好使用 `AnyObject`
		.anyObjectProtocol(preferAnyObject: true)

		, // 偏好使用 `@main`
		.applicationMain(preferMain: true)
	]

	/// 將設定的規則轉換為命令行指令
	static var allToCommand: [String] { Self.allRules.map { $0.command }.flatMap { $0 } }
}

