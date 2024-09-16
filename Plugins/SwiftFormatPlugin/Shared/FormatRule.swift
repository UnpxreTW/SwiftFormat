//
//  FormatRule.swift
//  SwiftFormatPlugin
//
//  Copyright © 2024 UnpxreTW. All rights reserved.
//

/// 格式規則
///
/// - note: 已將預設值設定為偏好的設定值
enum FormatRule {

	/// 當設定的單字字首為大寫時轉換成全大寫，使用設定值 "ID,URL,UUID"
	case acronyms(
		rule: Flag

		,  // 要進行轉換的單字
		String = "ID,URL,UUID"
	)

	/// 偏好在 `if`、`guard`、`while` 中使用逗號取代 `&&`
	case andOperator(preferComma: Flag)

	/// 偏好在協議中中使用 `AnyObject` 取代 `class`
	case anyObjectProtocol(preferAnyObject: Flag)

	/// 偏好使用 `@main` 取代舊的 `@UIApplicationMain` 與 `@NSApplicationMain`
	case applicationMain(preferMain: Flag)

	/// 偏好 `assertionFailure` 與 `preconditionFailure` 取代判斷為 `false` 的測試
	case assertionFailures(rule: Flag)

	/// 在 `import` 區塊後加入空白行
	case blankLineAfterImports(rule: Flag)

	/// 在每個 `switch` 中的 `case` 間插入空白行
	case blankLineAfterSwitchCase(rule: Flag)

	/// 在 `MARK` 註解周圍加上空白行
	case blankLinesAroundMark(
		rule: Flag

		,  // 在 `MARK` 後加上空白行
		lineaftermarks: Option = [.enable, .convertToTrueOrFlase]
	)

	/// 移除區塊間尾端的空白行
	case blankLinesAtEndOfScope(rule: Flag)

	/// 移除區塊間開頭的空白行
	case blankLinesAtStartOfScope(
		rule: Flag

		,  // 設定保留型別宣告的開頭空白行
		typeblanklines: String = "preserve"
	)

	/// 移除鏈狀函數連結間的空白行（但保留換行符號）
	case blankLinesBetweenChainedFunctions(rule: Flag)

	/// 移除 `import` 引用間的空白行
	case blankLinesBetweenImports(rule: Flag)

	/// 在類、結構、枚舉、擴展、協定或函數宣告間插入空白行
	case blankLinesBetweenScopes(rule: Flag)

	/// 將多行註解區塊轉換為連續的單行註解
	case blockComments(rule: Flag)

	/// 大括弧格式
	case braces(
		rule: Flag

		,  // 是否使用 Allman 樣式的大括弧格式
		allman: Bool = false
	)

	/// 使用 `if/switch` 簡化賦值
	case conditionalAssignment(
		rule: Flag

		,  // 使用 `after-property` 只在變數宣告後進行簡化、`always` 總是簡化
		condassignment: String = "always"
	)

	/// 將連續的空白行替換為單個空白行
	case consecutiveBlankLines(rule: Flag)

	/// 將連續的空白替換為單個空白
	case consecutiveSpaces(rule: Flag)

	/// 保持 `switch` 中每個 `case` 的間隔一致
	case consistentSwitchCaseSpacing(rule: Flag)

	/// 在宣告前使用文件註解風格
	case docComments(
		rule: Flag

		,  // `before-declarations` 只在宣告前使用（預設值）、`always` 總是使用
		doccomments: String = "before-declarations"
	)

	/// 移除重複的 `import` 宣告
	case duplicateImports(rule: Flag)

	/// 分別決定 `else`、`guard、`while`、`catch` 等關鍵字與前一個大括弧的相對位置
	///
	/// 可選參數：
	/// - elseposition: `else` 與 `catch` 放置位置；`same-line` 與前一個大括弧同行（預設值）、`next-line` 下一行
	/// - guardelse: `guard-else` 放置位置；`same-line` 同一行、`next-line` 下一行、`auto` 自動（預設值）
	case elseOnSameLine(rule: Flag, elseposition: String = "same-line", guardelse: String = "auto")

	/// 移除空的大括弧組內部的內容
	///
	/// 可選選項
	/// - emptybraces: `no-space` 無空格（預設值）、`spaced` 單個空格、`linebreak` 換行符號
	case emptyBraces(rule: Flag, emptybraces: String = "no-space")

	/// 將只有 `static` 修飾成員的類別或是結構轉換為 `enum` 作為命名空間
	///
	/// 可選選項：
	/// - enumnamespaces: `always` 總是轉換（預設）、`structs-only` 只對結構進行轉換
	case enumNamespaces(rule: Flag, enumnamespaces: String = "always")

	/// 設定 `extension` 的訪問控制關鍵字放置於 `extension` 前或是其內部宣告成員宣告前
	///
	/// 可選選項：
	/// extensionacl: `on-extension` 放置於 extension 宣告前（預設值）、`on-declarations` 放置於成員宣告前
	case extensionAccessControl(rule: Flag, extensionacl: String = "on-extension")

	/// 設定檔案標頭
	///
	/// 可選選項：
	/// header: 可使用 `strip`、`ignore` 或是要設定的檔案標頭文字
	/// dateformat: 日期格式
	/// timezone: 時區
	case fileHeader(rule: Flag, header: String = "", dateformat: String = "system", timezone: String = "system")

	/// 在 `extension` 上偏好使用 `<>` 約束取代 `where` 型態約束
	case genericExtensions(rule: Flag)

	/// 確保檔案標頭中的檔案名稱與實際檔案名稱相同
	case headerFileName(rule: Flag)

	/// 將 `await` 關鍵字移動到表達式的開頭
	case hoistAwait(rule: Flag)

	/// 將表達式間的 `let` 與 `var` 提取到表達式開頭
	case hoistPatternLet(rule: Flag)

	/// 將表達式間的 `try` 提取到表達式開頭
	case hoistTry(rule: Flag)

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
		rule: Flag,
		indent: String,
		tabwidth: String = "unspecified",
		indentcase: Bool = false,
		ifdef: String = "indent",
		xcodeindentation: String = "disabled",
		indentstrings: Bool = false
	)

	/// 當 `init(coder:)` 內容沒有任何實現時加上不可用標籤
	case initCoderUnavailable(rule: Flag)

	/// 使用 `.isEmpty` 取代 `.count == 0` 的表達式
	case isEmpty(rule: Flag)

	/// 將前導逗號移動到分行符號前
	case leadingDelimiters(rule: Flag)

	/// 在檔案尾端加入空白行
	case linebreakAtEndOfFile(rule: Flag)

	/// 檔案使用的換行符號，使用預設的換行符號
	case linebreaks(rule: Flag, linebreaks: String = "lf")

	/// 在類型宣告或是 `extension` 外部加上 `MARK` 標記
	case markTypes(
		rule: Flag

		,  // 不對 `type` 宣告加上標記
		marktypes: String = "never"

		,  // 對於 `type` 的標記格式
		typemark: String = "MARK: - %t"

		,  // 對於 `extension` 使用標記
		markextensions: String = "always"

		,  // 對於 `extension` 使用的標記格式
		extensionmark: String = "MARK: - %t + %c"

		,
		groupedextension: String = "MARK: %c"
	)

	/// 修飾詞排序按照預設排序
	case modifierOrder(rule: Flag)

	/// 不使用擁有權修飾符
	case noExplicitOwnership(rule: Flag)

	/// 對於數字的格式化，使用底線分割提高可讀性
	case numberFormatting(
		rule: Flag

		,  // 小數的分組規則，可使用閾值或是 "none" 或是 "ignore"
		decimalgrouping: String = "3,6"

		,  // 二進制數字分組規則，可使用閾值或是 "none" 或是 "ignore"
		binarygrouping: String = "4,8"

		,  // 八進制數字分組規則，可使用閾值或是 "none" 或是 "ignore"
		octalgrouping: String = "4,8"

		,  // 十六進制數字分組規則，可使用閾值或是 "none" 或是 "ignore"
		hexgrouping: String = "4,8"

		,  // 是否啟用小數點的分組化
		fractiongrouping: String = "disabled"

		,  // 是否對科學記號數字進行分組
		exponentgrouping: String = "disabled"

		,  // 十六進制轉換為 "uppercase" 全大寫或是 "lowercase" 全部小寫
		hexliteralcase: String = "uppercase"

		,  // 對於數值 `e` 使用 "uppercase" 大寫或是 "lowercase" 小寫
		exponentcase: String = "lowercase"
	)

	/// 在等效時使用 `some` 關鍵字取代泛型約束宣告
	case opaqueGenericParameters(
		rule: Flag

		,  // 使用 `some Any` 取代不明確泛型宣告
		someany: Bool = true
	)

	/// 結構組織註解
	case organizeDeclarations(
		rule: Flag

		,  // 標記使用的範本（按照預設）
		categorymark: String = "MARK: %c"

		,  // 在不同的類別中插入結構組織註解
		markcategories: Bool = true

		,  // 在第一個組織前的宣告
		beforemarks: String = "typealias,struct"

		,  // 包含在 Lifecycle 組織中的宣告
		lifecycle: String = ""

		,  // 要進行組織結構的結構
		organizetypes: String = "class,actor,struct"

		,  // 在 `struct` 中要進行組織結構的最小行數
		structthreshold: Int = 0

		,  // 在 `class` 中要進行組織結構的最小行數
		classthreshold: Int = 0

		,  // 在 `enum` 中要進行組織結構的最小行數
		enumthreshold: Int = 0

		,  // 在 `extension` 中要進行組織結構的最小行數
		extensionlength: Int = 0

		,  // 按照 `visibility` 可見性宣告進行組織或是 `type` 宣告類型進行組織
		organizationmode: String = "visibility"
	)

	/// 將 `forEach` 轉換為一般 for loops 結構
	case preferForLoop(
		rule: Flag

		,  // 進行轉換 `convert` （預設）或是 `ignore` 略過
		anonymousforeach: String = "convert"

		,  // 轉換單行的 `forEach` 設定 `convert` 進行轉換或是 `ignore` 略過（預設）
		onelineforeach: String = "ignore"
	)

	/// 在等效時偏好轉換為 `keyPath` 語法
	case preferKeyPath(rule: Flag)

	/// 移除多餘的反引號
	case redundantBackticks(rule: Flag)

	/// 移除 `switch-case` 中多餘的 `break`
	case redundantBreak(rule: Flag)

	/// 移除單語句閉包，更改為直接執行語法
	case redundantClosure(rule: Flag)
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
			if let ruleFlag = option as? Flag {
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
			case let option as Int: "\(option)"
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
		  .acronyms(rule: .enable)
		, .andOperator(preferComma: .enable)
		, .anyObjectProtocol(preferAnyObject: .enable)
		, .applicationMain(preferMain: .enable)
		, .assertionFailures(rule: .enable)
		, .blankLineAfterImports(rule: .enable)
		, .blankLineAfterSwitchCase(rule: .disable)  // 不在 `switch` 中的每個 `case` 間插入空白行
		, .blankLinesAroundMark(rule: .enable)
		, .blankLinesAtEndOfScope(rule: .enable)
		, .blankLinesAtStartOfScope(rule: .enable)
		, .blankLinesBetweenChainedFunctions(rule: .enable)
		, .blankLinesBetweenImports(rule: .disable)
		, .blankLinesBetweenScopes(rule: .enable)
		, .blockComments(rule: .enable)
		, .braces(rule: .enable)
		, .conditionalAssignment(rule: .enable)
		, .consecutiveBlankLines(rule: .enable)
		, .consecutiveSpaces(rule: .enable)
		, .consistentSwitchCaseSpacing(rule: .enable)
		, .docComments(rule: .enable)
		, .duplicateImports(rule: .enable)

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

		, .leadingDelimiters(rule: .disable)  // 可依據上下文自行決定
		, .linebreakAtEndOfFile(rule: .enable)
		, .linebreaks(rule: .enable)
		, .markTypes(rule: .enable)
		, .modifierOrder(rule: .enable)
		, .noExplicitOwnership(rule: .disable)  // 不啟用此規則
		, .numberFormatting(rule: .enable)
		, .opaqueGenericParameters(rule: .enable)
		, .organizeDeclarations(rule: .enable)
		, .preferForLoop(rule: .disable)  // 不進行此轉換
		, .preferKeyPath(rule: .enable)
		, .redundantBackticks(rule: .enable)
		, .redundantBreak(rule: .enable)
		, .redundantClosure(rule: .disable)  // 根據上下文與美觀性決定
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
