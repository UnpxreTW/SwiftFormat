//
//  Rules.swift
//  SwiftFormatPlugin
//
//  Copyright © 2023 UnpxreTW. All rights reserved.
//

/// 格式規則
enum Rule {

	/// 當設定的單字字首為大寫時轉換成全大寫
	case acronyms(EnableFlag, String)

	/// 偏好在 `if`、`guard`、`while` 中使用逗號取代 `&&`
	case andOperator(preferComma: EnableFlag)

	/// 偏好在協議中中使用 `AnyObject` 取代 `class`
	case anyObjectProtocol(preferAnyObject: EnableFlag)

	/// 偏好使用 `@main` 取代舊的 `@UIApplicationMain` 與 `@NSApplicationMain`
	case applicationMain(preferMain: EnableFlag)

	/// 偏好 `assertionFailure` 與 `preconditionFailure` 取代判斷為 `false` 的測試
	case assertionFailures(EnableFlag)

	/// 在 `import` 區塊後加入空白行
	case blankLineAfterImports(EnableFlag)

	/// 在每個 `switch` 中的 `case` 間插入空白行
	case blankLineAfterSwitchCase(EnableFlag)

	/// 在 `MARK` 註解周圍加上空白行
	case blankLinesAroundMark(EnableFlag)
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
		var command: [String] = []
		for (label, option) in Mirror(reflecting: currentCase.value).children {
			if let isEnable = option as? EnableFlag {
				command.append(contentsOf: ["--\(isEnable)", name])
				guard isEnable == .enable else { break }
				continue
			}
			if label == "_flag", let isEnable = option as? Bool {
				// !!!: 有可能在反射中 ```EnableFlag``` 被展開，導致失去結構訊息
				command.append(contentsOf: ["--\(EnableFlag(isEnable))", name])
				guard isEnable else { break }
				continue
			}
			switch option {
			case let option as String:
				if let label, !label.isEmpty, label.first != "." {
					command.append(contentsOf: ["--\(label)", option])
				} else {
					// !!!: 如未指定參數標籤時標籤會為 "." 開頭的參數偏移數字，此時需要以規則名稱開頭
					command.append(contentsOf: ["--\(name)", option])
				}
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
		.acronyms(.ruleEnable, "ID,URL,UUID")

		, // 偏好逗號取代 `&&` 在判斷式中
		.andOperator(preferComma: .ruleEnable)

		, // 偏好使用 `AnyObject`
		.anyObjectProtocol(preferAnyObject: .ruleEnable)

		, // 偏好使用 `@main`
		.applicationMain(preferMain: .ruleEnable)

		, // 啟用
		.assertionFailures(.ruleEnable)

		, // 啟用
		.blankLineAfterImports(.ruleEnable)

		, // 不在 `switch` 中的每個 `case` 間插入空白行
		.blankLineAfterSwitchCase(.ruleEnable)

		, // 在 MARK 註解周圍加上空白行
		.blankLinesAroundMark(.ruleEnable)
	]

	/// 將設定的規則轉換為命令行指令
	static var allToCommand: [String] { Self.allRules.map { $0.command }.flatMap { $0 } }
}

extension Rule {

	///  ```Rule``` 中的規則第一個參數必須為 ```Rule.EnableFlag``` 型態，用於決定規則是否啟用
	///
	/// - Important: 當參數列表包含此型態的參數且為不啟用時會直接關閉對應的規則
	struct EnableFlag: OptionSet {

		public static let disable: Self = .init(rawValue: 0)

		public static let enable: Self = .init(rawValue: 1)

		/// 標示其為標記規則的啟用與否
		private static let isRuleFlag: Self = .init(rawValue: 1 << 1)

		/// 用於規則的啟用
		public static let ruleEnable: Self = [.isRuleFlag, .enable]

		/// 當規則不啟用時，第一個參數後停止解析後續可選參數
		public static let ruleDisable: Self = [.isRuleFlag, .disable]

		internal var rawValue: Int


		internal init(rawValue: Int) {
			self.rawValue = rawValue
		}

		internal init(_ flag: Bool) {
			self._flag = flag
		}
	}
}

extension Rule.EnableFlag: CustomStringConvertible {

	var description: String {
		self._flag ? "enable" : "disable"
	}
}
