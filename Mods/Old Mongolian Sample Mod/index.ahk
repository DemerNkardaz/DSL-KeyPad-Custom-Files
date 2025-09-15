Class Mod__OldMongolian__Example {
	static tools := ModTools(A_LineFile)

	static __New() {
		; Загрузка данных
		; о записях символов,
		; о привязках,
		; о режиме Альтернативного ввода и данных
		; для отображения записей символов в GUI главной панели
		local charactersData := JSON.LoadFile(this.tools.paths.data "\characters.json", "UTF-8")
		local bindsData := JSON.LoadFile(this.tools.paths.data "\binds.json", "UTF-8")
		local alternativeModeData := JSON.LoadFile(this.tools.paths.data "\alternative_modes.json", "UTF-8")
		local uiMainGuiData := JSON.LoadFile(this.tools.paths.data "\ui_main_panel_lists.json", "UTF-8")

		; Регистрация перфикса письменности «old_mongolian» для корректной генерации локализации
		; Регистрация новых символов через событие «по завершении регистрации стандартной библиотеки символов»

		; Опущенный второй аргумент — тип инициализации («Внутренняя библиотека» ("Internal", по умочланию) либо «Пользовательские рецепты» ("Custom"))

		; True на третьем аргументе отключает показ прогресс-бара
		Event.OnEvent("Character Library", "Default Ready", () => (
			ChrLib.AddScript("old_mongolian"),
			ChrReg(charactersData, , True)
		))

		; Регистрация новых привязок через событие инициализации хранилища привязок
		; Регистрация нового режима Альтернативного ввода через событие инициализации хранилища режимов
		Event.OnEvent("Binding Storage", "Initialized", () => BindReg(bindsData))
		Event.OnEvent("Scripter Storage", "Initialized", () => ScripterStore("Alternative Modes", alternativeModeData))
		; Добавление новых записей в GUI главной панели через событие создания экземпляра панели
		; Событие возвращает экземпляр класса
		Event.OnEvent("UI Instance [Panel]", "Created", SetPanelData)

		return

		; Функция добавления новых записей в GUI главной панели, вызываемая событием
		SetPanelData(ClassInstance) {
			; Получение сведений о колонках и добавление новых записей в GUI главной панели
			ClassInstance.GetColumnsData(&columnsData)
			ClassInstance.MergeListViewData(&uiMainGuiData, &columnsData)
			return
		}
	}
}