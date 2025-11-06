; @NOTE: "ZH-CN Translation created with DeepSeek just for testing purposes. I think it's very wrong"

Class Mod__Zhongwen_Test {
	static tools := ModTools(A_LineFile)

	static GENERATED_FORMATS := Map(
		"titlePostfix", (&data, &postfixText) => (
			postfixText
		),
		"titleAltPostfix", (&data, &postfixText) => (
			postfixText
		),
		"titlePostfixMulti", (&data, &postfixText) => (
			Locale.Read(data.pfx "postfix.and", data.lang)
			postfixText
		),
		"titleAltPostfixMulti", (&data, &postfixText) => (
			Locale.Read(data.pfx "postfix.and", data.lang)
			postfixText
		),
		"title", (&data) => (
			(data.titlePostfixText != "" ? "{prejuction}" : "")
			data.titlePostfixText
			(data.titlePostfixText != "" ? "{conjuction}" : "")
			data.lBeforeTitle
			(data.boundsCollector["script"][data.langCode].Length > 0 ? data.boundsCollector["script"][data.langCode][1] : "")
			Locale.Read(data.pfx "prefix." data.lScript (!data.isGermanic ? data.scriptAdditive : ""), data.lang, , , , data.lVariant)
			(data.boundsCollector["script"][data.langCode].Length > 0 ? data.boundsCollector["script"][data.langCode][2] : "")
			data.lBeforeType
			data.localedCase Locale.Read(data.pfx "type." data.lType, data.lang)
			data.lAfterType
			(data.isGermanic && data.scriptAdditive != "" ? Locale.Read(data.pfx "prefix." data.lScript data.scriptAdditive, data.lang, , , , data.lVariant) : "")
			data.lBeforeletter
			data.postLetter
			data.lAfterletter
			data.lSecondName
			data.lCopyNumber
			data.proxyMark
			data.lAfterTitle
		),
		"titleAlt", (&data) => (
			(data.titlePostfixText != "" ? "{prejuction}" : "")
			data.titlePostfixText
			(data.titlePostfixText != "" ? "{conjuction}" : "")
			data.lBeforeAltTitle
			Locale.Read(data.pfx "type." data.lType, data.lang)
			data.lBeforeletter
			data.postLetter
			data.lAfterletter
			data.lSecondName
			data.proxyMark
			data.lAfterAltTitle
		),
		"tagBase", (&data) => (
			(data.titlePostfixText != "" ? "{prejuction}" : "")
			data.titlePostfixText
			(data.titlePostfixText != "" ? "{conjuction}" : "")
			data.lBeforeTitle
			(!data.isGermanic ? data.localedCase data.lBeforeType Locale.Read(data.pfx "type." data.lType, data.lang) data.lAfterType : "")
			data.lBeforeletter
			data.postLetter
			data.lAfterletter
			data.lSecondName
			data.lCopyNumber
			data.lAfterTitle
		),
		"tag", (&data, tagBase) => (
			Locale.Read(data.pfx "tag." data.lScript, data.lang, , , , data.lVariant)
			(data.isGermanic ? Locale.Read(data.pfx "type." data.lType, data.lang) : "")
			data.tagScriptAdditive
			tagBase
		),
		"hiddenTagBase", (&data) => (
			(data.titlePostfixText != "" ? "{prejuction}" : "")
			data.titlePostfixText
			(data.titlePostfixText != "" ? "{conjuction}" : "")
			data.lHiddenBeforeTitle
			(!data.isGermanic ? data.localedCase data.lHiddenBeforeType (Locale.Read(data.pfx "type." data.lType, data.lang, True, &hidden) ? hidden : Locale.Read(data.pfx "type." data.lType, data.lang)) data.lHiddenAfterType : "")
			data.lHiddenBeforeletter
			data.hiddenLetter
			data.lHiddenAfterletter
			data.lSecondName
			data.lCopyNumber
			data.lHiddenAfterTitle
		),
		"hiddenTag", (&data, hiddenTagBase) => (
			data.tagScriptAtStart ?
				(
					(Locale.Read(data.pfx "tag." data.lScript ".__hidden", data.lang, True, &hidden, , data.lVariant) ? hidden : Locale.Read(data.pfx "tag." data.lScript, data.lang, , , , data.lVariant))
					(data.isGermanic ? (Locale.Read(data.pfx "type." data.lType ".__hidden", data.lang, True, &hidden) ? hidden : Locale.Read(data.pfx "type." data.lType, data.lang)) : "")
					data.hiddenTagScriptAdditive
					hiddenTagBase
				)
			: (
				hiddenTagBase
				(Locale.Read(data.pfx "tag." data.lScript ".__hidden", data.lang, True, &hidden, , data.lVariant) ? hidden : Locale.Read(data.pfx "tag." data.lScript, data.lang, , , , data.lVariant))
			)
		),
		"additiveTitle", (&data) => (
			data.lAdditionalBeforeTitle
			(data.boundsCollector["script"][data.lang].Length > 0 ? data.boundsCollector["script"][data.lang][1] : "")
			Locale.Read(data.pfx "prefix." data.curScript (!data.curIsGermanic ? data.curScriptAdditive : ""), data.lang, , , , data.curLVariant)
			(data.boundsCollector["script"][data.lang].Length > 0 ? data.boundsCollector["script"][data.lang][2] : "")
			data.lAdditionalBeforeType
			data.localedCase data.typeTag
			data.lAdditionalAfterType
			(data.curIsGermanic && data.scriptAdditive != "" ? Locale.Read(data.pfx "prefix." data.curScript data.curScriptAdditive, data.lang, , , , data.curLVariant) : "")
			data.lAdditionalBeforeLetter
			data.additionalPostLetter
			data.lAdditionalAfterLetter
			data.lAdditionalCopyNumber
			data.proxyMark
			data.lAdditionalAfterTitle
		),
		"additiveTagBase", (&data) => (
			data.lAdditionalBeforeTitle
			data.scriptTag
			data.lAdditionalBeforeType
			data.localedCase data.typeTag
			data.lAdditionalAfterType
			data.lAdditionalBeforeLetter
			data.additionalPostLetter
			data.lAdditionalAfterLetter
			data.lAdditionalCopyNumber
			data.lAdditionalAfterTitle
		),
		"additiveHiddenTagBase", (&data) => (
			data.lHiddenAdditionalBeforeTitle
			data.scriptHiddenTag
			data.lHiddenAdditionalBeforeType
			data.localedHiddenCase data.typeHiddenTag
			data.lHiddenAdditionalAfterType
			data.lHiddenAdditionalBeforeletter
			data.additionalHiddenLetter
			data.lHiddenAdditionalAfterletter
			data.lAdditionalCopyNumber
			data.lHiddenAdditionalAfterTitle
		),
	)

	static __New() {
		this.languageInitializationEvent := Event.OnEvent("Language", "Initialized", (*) => (
			Language.supported["zh-CN"].Set("locale", True),
			Language.supported["zh-CN"].Set("generatedLocale", True)
		))

		this.localeInitializationEvent := Event.OnEvent("Locale", "Initialized", (*) => (
			LocaleGenerator.AddRule("zh-CN", "prejuction", (str, lang, *) => RegExReplace(str, "\{prejuction\}", Locale.Read("generated.postfix.zh_dai", lang))),
			LocaleGenerator.AddRule("zh-CN", "conjunction", (str, lang, *) => RegExReplace(str, "\{conjuction\}", Locale.Read("generated.postfix.zh_de", lang))),
			LocaleGenerator.wordSeparators.Set("zh-CN", ""),
			LocaleGenerator.wordAltSeparators.Set("zh-CN", ""),
			LocaleGenerator.SetFormatEntry("zh-CN", this.GENERATED_FORMATS)
		))
	}
}