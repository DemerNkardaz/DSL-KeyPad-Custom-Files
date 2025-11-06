; @NOTE: "ZH-CN Translation created with DeepSeek just for testing purposes. I think it’s very wrong"

Class Mod__Zhongwen_Test {
	static tools := ModTools(A_LineFile)

	static __New() {
		this.languageInitializationEvent := Event.OnEvent("Language", "Initialized", (*) => (
			Language.supported["zh-CN"].Set("locale", True),
			Language.supported["zh-CN"].Set("generatedLocale", True)
		))

		this.localeInitializationEvent := Event.OnEvent("Locale", "Initialized", (*) => (
			LocaleGenerator.AddRule("zh-CN", "conjunction", LocaleGenerator.ReferenceToRule("en-US", "conjunction")),
			LocaleGenerator.wordSeparators.Set("zh-CN", ""),
			LocaleGenerator.wordAltSeparators.Set("zh-CN", "")
		))
	}
}