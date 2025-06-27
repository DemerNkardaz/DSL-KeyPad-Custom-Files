Class OldMongolianMod {
	static dir := mods["Old Mongolian Sample Mod"]

	static __New() {
		; Подготовка новых символов
		local mongolianBlock := [
			"old_mongolian_n_let_[a,e,i,o,u]", {
				unicode: [
					"1820",
					"1821",
					"1822",
					"1823",
					"1824",
				],
				options: {
					; Указывает клавишу для отображения в GUI
					; $ автоматически заменяется на букву после let_
					altLayoutKey: "$",
					; указывает использовать имя из локализации с постфиксом «_LTL»
					; необязателен, True по умолчанию для имён формата:
					; <script>_<case>_<type>_<letter>[_<endPart>][__<postfix>]*
					useLetterLocale: True,
				},
			},
			"old_mongolian_n_let_ue", {
				unicode: "1826",
				options: { altLayoutKey: ">! U" },
			},
		]

		; Регистрация перфикса «old_mongolian» для корректной генерации локализации
		ChrLib.scriptsValidator.Push("old_mongolian")

		; Регистрация новых символов
		ChrReg(mongolianBlock, , True)

		; Эти два действия необходимы для сохранения записей после смены языка
		; (записи пересоздаются при смене языка)
		;
		; Добавление группы в список дополнительных групп вкладки «Письменности»
		; Пустая строка добавляет пустую запись во вкладке (разделитель)
		Panel.externalGroups.scripts.Push("", "Old Mongolian")
		; Добавление ключа локализации (необязательно)
		Panel.externalGroupKeys.scripts.Set("Old Mongolian", Locale.Read.Bind(Locale, "old_mongolian_mod__alt_mode_old_mongolian"))

		; Создание массива с записями символов для вставки во вкладку «Письменности»
		local insertingGroup := Panel.LV_InsertGroup({
			type: "Alternative Layout",
			group: ["", "Old Mongolian"],
			groupKey: Map(
				"Old Mongolian", Locale.Read("old_mongolian_mod__alt_mode_old_mongolian")
			),
		})

		; Вставка записей во вкладку «Письменности»
		Panel.LV_Content.scripts.Push(insertingGroup*)

		; Добавление привязок для режима Альтернативного ввода
		bindingMaps["Script Specified"].Set(
			"Old Mongolian", Map(
				; Обязательный параметр, если мы не делаем пару латиница-кириллица
				"ForceSingle", True,
				; Привязки для клавиш без модификаторов
				"Flat", Map(
					"A", "old_mongolian_n_let_a",
					"E", "old_mongolian_n_let_e",
					"I", "old_mongolian_n_let_i",
					"O", "old_mongolian_n_let_o",
					"U", "old_mongolian_n_let_u",
				),
				"Moded", Map(
					; Привязки для клавиш с модификаторами
					"U", Map(
						"<^>!", "old_mongolian_n_let_ue",
					),
				)
			)
		)

		; Добавление нового режима Альтернативного ввода
		Scripter.data["Alternative Modes"].Push(
			"Old Mongolian", {
				preview: ["ᠠᠯᠲᠠᠨ ᠵᠤᠯᠠ ᠭᠦᠵᠡᠭᠡᠯᠵᠡᠭᠡᠨ᠎ᠡ"],
				fonts: [""],
				locale: "old_mongolian_mod__alt_mode_old_mongolian",
				bindings: ["Old Mongolian"],
				uiid: "OldMongolian",
				icons: [Format("file::{}\Resources\old_mongolian.ico", this.dir)],
			}
		)
	}
}