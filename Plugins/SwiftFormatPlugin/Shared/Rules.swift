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
	private var name: String { currentCase.label! }

	/// 使用當前命令設定產生使用於命令行參數的字串
	private var command: [String] {
        return ["--enable", "\(name)"] + Mirror(reflecting: currentCase.value).children.map { (label, option) -> [String] in
            switch option {
			case let option as String: ["--\(name)", option]
			default: []
			}
        }.flatMap { $0 }
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

