//
//  Rules.swift
//  SwiftFormatPlugin
//
//  Copyright © 2023 UnpxreTW. All rights reserved.
//

/// 格式規則
enum Rule {

	/// 當設定的單字字首為大寫時轉換成全大寫
	case acronyms(String)

	/// 偏好在 `if`、`guard`、`while` 中使用逗號取代 `&&`
	case andOperator(preferComma: Bool)

	/// 偏好在協議中中使用 `AnyObject` 取代 `class`
	case anyObjectProtocol(preferAnyObject: Bool)

	/// 偏好使用 `@main` 取代舊的 `@UIApplicationMain` 與 `@NSApplicationMain`
	case applicationMain(preferMain: Bool)

	/// 偏好 `assertionFailure` 與 `preconditionFailure` 取代判斷為 `false` 的測試
	case assertionFailures(Bool)

	/// 在 `import` 區塊後加入空白行
	case blankLineAfterImports(Bool)

	/// 在每個 `switch` 中的 `case` 間插入空白行
	case blankLineAfterSwitchCase(Bool)

	/// 在 `MARK` 註解周圍加上空白行
	case blankLinesAroundMark(Bool)
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
		guard let name = self.name else { return [] }
		var command: [String] = ["--enable", "\(name)"]
		Mirror(reflecting: currentCase.value).children.forEach { label, option in
			switch option {
			case let option as String: comman + ["--\(name)", option]
			default: break
			}
		}
		return command
	}
}

extension Rule {

	// 所有使用中的規則與其設定值
	static let allRules: [Rule] = [
		  // 與預設相同選擇 "ID,URL,UUID"
		.acronyms("ID,URL,UUID")

		, // 偏好逗號取代 `&&` 在判斷式中
		.andOperator(preferComma: true)

		, // 偏好使用 `AnyObject`
		.anyObjectProtocol(preferAnyObject: true)

		, // 偏好使用 `@main`
		.applicationMain(preferMain: true)

		, // 啟用
		.assertionFailures(true)

		, // 啟用
		.blankLineAfterImports(true)

		, // 不在 `switch` 中的每個 `case` 間插入空白行
		.blankLineAfterSwitchCase(false)

		, // 在 MARK 註解周圍加上空白行
		.blankLinesAroundMark(true)
	]

	/// 將設定的規則轉換為命令行指令
	static var allToCommand: [String] { Self.allRules.map { $0.command }.flatMap { $0 } }
}

