Class OldMongolianMod {
	static dir := mods["Old Mongolian Sample Mod"]

	static __New() {
		; Загрузка данных о записях символов
		local charactersData := JSON.LoadFile(this.dir "\Data\characters.json", "UTF-8")

		; Регистрация перфикса «old_mongolian» для корректной генерации локализации
		ChrLib.scriptsValidator.Push("old_mongolian")

		; Регистрация новых символов
		; True на третьем аргументе отключает показ прогресс-бара
		ChrReg(charactersData, , True)

		; Загрузка данных для отображения записей символов в GUI
		local uiMainGuiData := JSON.LoadFile(this.dir "\Data\ui_main_panel_lists.json", "UTF-8")
		local mainGuiInstance := globalInstances.MainGUI

		; Получение сведений о колонках и добавление новых записей в GUI
		mainGuiInstance.GetColumnsData(&columnsData)
		mainGuiInstance.MergeListViewData(&uiMainGuiData, &columnsData)

		; Загрузка данных о привязках
		local bindsData := JSON.LoadFile(this.dir "\Data\binds.json", "UTF-8")
		; Регистрация новых привязок
		BindReg(bindsData)

		; Загрузка данных о режиме Альтернативного ввода
		local alternativeModeData := JSON.LoadFile(this.dir "\Data\alternative_modes.json", "UTF-8")
		; Регистрация нового режима Альтернативного ввода
		ScripterStore("Alternative Modes", alternativeModeData)
	}
}