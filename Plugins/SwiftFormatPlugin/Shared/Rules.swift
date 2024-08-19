//
//  Rules.swift
//  SwiftFormatPlugin
//
//  Copyright © 2023 UnpxreTW. All rights reserved.
//

/// 格式規則
enum FormatRule {

	/// 當設定的單字字首為大寫時轉換成全大寫
	case acronyms(rule: RuleFlag, String)

	/// 偏好在 `if`、`guard`、`while` 中使用逗號取代 `&&`
	case andOperator(preferComma: RuleFlag)

	/// 偏好在協議中中使用 `AnyObject` 取代 `class`
	case anyObjectProtocol(preferAnyObject: RuleFlag)

	/// 偏好使用 `@main` 取代舊的 `@UIApplicationMain` 與 `@NSApplicationMain`
	case applicationMain(preferMain: RuleFlag)

	/// 偏好 `assertionFailure` 與 `preconditionFailure` 取代判斷為 `false` 的測試
	case assertionFailures(rule: RuleFlag)

	/// 在 `import` 區塊後加入空白行
	case blankLineAfterImports(rule: RuleFlag)

	/// 在每個 `switch` 中的 `case` 間插入空白行
	case blankLineAfterSwitchCase(rule: RuleFlag)

	/// 在 `MARK` 註解周圍加上空白行
	case blankLinesAroundMark(rule: RuleFlag, lineaftermarks: Option)

	/// 移除區塊間尾端的空白行
	case blankLinesAtEndOfScope(rule: RuleFlag)

	/// 移除區塊間開頭的空白行
	///
	/// 可選選項 `typeblanklines` 用於對於型別宣告開頭可以使用 `remove`（移除）或是`preserve`（保留）
	case blankLinesAtStartOfScope(rule: RuleFlag, typeblanklines: String)

	/// 移除鏈狀函數連結間的空白行（但保留換行符號）
	case blankLinesBetweenChainedFunctions(rule: RuleFlag)

	/// 移除 `import` 引用間的空白行
	case blankLinesBetweenImports(rule: RuleFlag)

	/// 在類、結構、枚舉、擴展、協定或函數宣告間插入空白行
	case blankLinesBetweenScopes(rule: RuleFlag)

	/// 將多行註解區塊轉換為連續的單行註解
	case blockComments(rule: RuleFlag)

	/// 是否使用 Allman 樣式的大括弧
	case braces(rule: RuleFlag, allman: Bool)

	/// 使用 `if/switch` 簡化賦值
	///
	/// 可選參數：
	/// - condassignment: `after-property` 只在變數宣告後進行簡化（預設值）、`always` 總是簡化
	case conditionalAssignment(rule: RuleFlag, condassignment: String = "after-property")

	/// 將連續的空白行替換為單個空白行
	case consecutiveBlankLines(rule: RuleFlag)

	/// 將連續的空白替換為單個空白
	case consecutiveSpaces(rule: RuleFlag)

	/// 保持 `switch` 中每個 `case` 的間隔一致
	case consistentSwitchCaseSpacing(rule: RuleFlag)

	/// 在宣告前使用文件註解風格
	///
	/// 可選參數：
	/// - doccomments: `before-declarations` 只在宣告前使用（預設值）、`always` 總是使用
	case docComments(rule: RuleFlag, doccomments: String = "before-declarations")

	/// 移除重複的 `import` 宣告
	case duplicateImports(rule: RuleFlag)

	/// 分別決定 `else`、`guard、`while`、`catch` 等關鍵字與前一個大括弧的相對位置
	///
	/// 可選參數：
	/// - elseposition: `else` 與 `catch` 放置位置；`same-line` 與前一個大括弧同行（預設值）、`next-line` 下一行
	/// - guardelse: `guard-else` 放置位置；`same-line` 同一行、`next-line` 下一行、`auto` 自動（預設值）
	case elseOnSameLine(rule: RuleFlag, elseposition: String = "same-line", guardelse: String = "auto")

	/// 移除空的大括弧組內部的內容
	///
	/// 可選選項
	/// - emptybraces: `no-space` 無空格（預設值）、`spaced` 單個空格、`linebreak` 換行符號
	case emptyBraces(rule: RuleFlag, emptybraces: String = "no-space")

	/// 將只有 `static` 修飾成員的類別或是結構轉換為 `enum` 作為命名空間
	///
	/// 可選選項：
	/// - enumnamespaces: `always` 總是轉換（預設）、`structs-only` 只對結構進行轉換
	case enumNamespaces(rule: RuleFlag, enumnamespaces: String = "always")

	/// 設定 `extension` 的訪問控制關鍵字放置於 `extension` 前或是其內部宣告成員宣告前
	///
	/// 可選選項：
	/// extensionacl: `on-extension` 放置於 extension 宣告前（預設值）、`on-declarations` 放置於成員宣告前
	case extensionAccessControl(rule: RuleFlag, extensionacl: String = "on-extension")

	/// 設定檔案標頭
	///
	/// 可選選項：
	/// header: 可使用 `strip`、`ignore` 或是要設定的檔案標頭文字
	/// dateformat: 日期格式
	/// timezone: 時區
	case fileHeader(rule: RuleFlag, header: String = "", dateformat: String = "system", timezone: String = "system")

	/// 在 `extension` 上偏好使用 `<>` 約束取代 `where` 型態約束
	case genericExtensions(rule: RuleFlag)

	/// 確保檔案標頭中的檔案名稱與實際檔案名稱相同
	case headerFileName(rule: RuleFlag)

	/// 將 `await` 關鍵字移動到表達式的開頭
	case hoistAwait(rule: RuleFlag)

	/// 將表達式間的 `let` 與 `var` 提取到表達式開頭
	case hoistPatternLet(rule: RuleFlag)

	/// 將表達式間的 `try` 提取到表達式開頭
	case hoistTry(rule: RuleFlag)

	/// 縮進控制
	///
	/// 可選選項：
	/// - indent: 縮進空格數量或是使用 "tab" 使用製表符
	/// - tabwidth: 製表符寬度，預設為 `unspecified` 未指定
	/// - indentcase: `switch-case` 內 `case` 是否縮進，預設不縮進
	/// - ifdef: 在 `#if` 中是否縮進
	/// - xcodeindentation: 符合 Xcode 縮進設定
	/// - indentstrings: 多行字串縮進
	case indent(
		rule: RuleFlag,
		indent: String,
		tabwidth: String = "unspecified",
		indentcase: Bool = false,
		ifdef: String = "indent",
		xcodeindentation: String = "disabled",
		indentstrings: Bool = false
	)

	/// 當 `init(coder:)` 內容沒有任何實現時加上不可用標籤
	case initCoderUnavailable(rule: RuleFlag)

	/// 使用 `.isEmpty` 取代 `.count == 0` 的表達式
	case isEmpty(rule: RuleFlag)
}

extension FormatRule {

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
			if let ruleFlag = option as? RuleFlag {
				command.append(contentsOf: ["--\(ruleFlag)", name])
				guard case .enable = ruleFlag else {
					print("規則 \(name) 未啟用")
					break
				}
				continue
			}
			let option: String = switch option {
			case let option as Option: String(describing: option)
			case let option as Bool: option ? "true" : "false"
			case let option as String: option
			default: ""
			}
			if let label, !label.isEmpty, label.first != "." {
				command.append(contentsOf: ["--\(label)", option])
			} else {
				// !!!: 如未指定參數標籤時標籤會為 "." 開頭的參數偏移數字，此時需要以規則名稱開頭
				command.append(contentsOf: ["--\(name)", option])
			}
		}
		return command
	}
}

extension FormatRule {

	// 所有使用中的規則與其設定值
	static let allRules: [Self] = [

		  // 與預設相同選擇 "ID,URL,UUID"
		.acronyms(rule: .enable, "ID,URL,UUID")

		, // 偏好逗號取代 `&&` 在判斷式中
		.andOperator(preferComma: .enable)

		, // 偏好使用 `AnyObject`
		.anyObjectProtocol(preferAnyObject: .enable)

		, // 偏好使用 `@main`
		.applicationMain(preferMain: .enable)

		, // 啟用
		.assertionFailures(rule: .enable)

		, // 啟用
		.blankLineAfterImports(rule: .enable)

		, // 不在 `switch` 中的每個 `case` 間插入空白行
		.blankLineAfterSwitchCase(rule: .disable)

		, // 在 MARK 註解周圍加上空白行
		.blankLinesAroundMark(rule: .enable, lineaftermarks: [.enable, .convertToTrueOrFlase])

		, // 移除區塊間尾端的空白行
		.blankLinesAtEndOfScope(rule: .enable)

		, // 移除區塊區間開頭的空白行（但是保留類型宣告的開頭空白行）
		.blankLinesAtStartOfScope(rule: .enable, typeblanklines: "preserve")

		, // 移除鏈式函數間的空白行
		.blankLinesBetweenChainedFunctions(rule: .enable)

		, // 不移除 `import` 聲明間的空白行
		.blankLinesBetweenImports(rule: .disable)

		, // 在宣告空間間插入空白行
		.blankLinesBetweenScopes(rule: .enable)

		, // 轉換多行註解區塊為連續的單行註解（包含文件註解）
		.blockComments(rule: .enable)

		, // 大括弧開頭不使用 allman 縮排樣式
		.braces(rule: .enable, allman: false)

		, // 總是使用 `if/switch` 簡化賦值
		.conditionalAssignment(rule: .enable, condassignment: "always")

		, // 限制空白行最多只有一行
		.consecutiveBlankLines(rule: .enable)

		, // 限制空白最多只有一個
		.consecutiveSpaces(rule: .enable)

		, // 保持 `switch-case` 間隔一致
		.consistentSwitchCaseSpacing(rule: .enable)

		, // 宣告前總是使用文件風格註解，而程式碼中總是使用一般註解
		.docComments(rule: .enable)

		, // 移除重複的 `import` 宣告
		.duplicateImports(rule: .enable)

		, // 都放置於同一行
		.elseOnSameLine(rule: .enable, guardelse: "same-line")

		, // 清除空的大括弧中的內容
		.emptyBraces(rule: .enable)

		, // 不自動轉換為 `enum`
		.enumNamespaces(rule: .disable)

		, // 偏好將訪問控制關鍵字放置於內部成原宣告前
		.extensionAccessControl(rule: .enable, extensionacl: "on-declarations")

		, // 偏好使用 `<>` 取代 `where` 約束
		.genericExtensions(rule: .enable)

		, // 檢查標頭檔案名稱
		.headerFileName(rule: .enable)

		, // 將 `await` 移動到表達式的開頭
		.hoistAwait(rule: .enable)

		, // 將表達式中的 `var` 與 `let` 提取到表達式開頭
		.hoistPatternLet(rule: .enable)

		, // 將表達式中的 `try` 提取到表達式開頭
		.hoistTry(rule: .enable)

		, // 縮進設定使用製表符其餘設定為預設值
		.indent(rule: .enable, indent: "tab")

		, // 啟用
		.initCoderUnavailable(rule: .enable)

		, // 此規則有時會導致未實現 `isEmpty` 但是轉換使用導致編譯問題所以不啟用
		.isEmpty(rule: .disable)
	]

	/// 將設定的規則轉換為命令行指令
	static var allToCommand: [String] { Self.allRules.map { $0.command }.flatMap { $0 } }
}

extension FormatRule {

	/// 用於描述啟用與否的旗標，其包含是否啟用、用途與轉換格式
	///
	/// - Important: 當參數列表包含此型態的參數且為不啟用時會直接關閉對應的規則
	struct Option: OptionSet {

		static let disable: Option = .init(rawValue: 0)

		static let enable: Option = .init(rawValue: 1)

		/// 轉換為 "true" 或 "false" 字串
		static let convertToTrueOrFlase: Self = .init(rawValue: 1 << 2)

		var rawValue: Int

		private var _custom: String = ""

		init(rawValue: Int) {
			self.rawValue = rawValue
		}

		init(rawValue: Int, with custom: String) {
			self.init(rawValue: rawValue)
			self._custom = custom
		}
	}
}

extension FormatRule.Option: CustomStringConvertible {

	var description: String {
		if self.contains(.convertToTrueOrFlase) {
			self.contains(.enable) ? "true" : "false"
		} else {
			""
		}
	}
}
