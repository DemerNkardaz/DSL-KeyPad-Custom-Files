Class Mod__Old_Mongolian_Example {
	static tools := ModTools(A_LineFile)

	static __New() {
		; Loading data
		; about character entries,
		; about bindings,
		; about Alternative mode and data
		; for displaying character entries in the main panel GUI
		local charactersData := JSON.LoadFile(this.tools.paths.data "\characters.json", "UTF-8")
		local bindsData := JSON.LoadFile(this.tools.paths.data "\binds.json", "UTF-8")
		local alternativeModeData := JSON.LoadFile(this.tools.paths.data "\alternative_modes.json", "UTF-8")
		local uiMainGuiData := JSON.LoadFile(this.tools.paths.data "\ui_main_panel_lists.json", "UTF-8")

		; Registration of “old_mongolian” script prefix for correct localization generation
		; Registration of new characters through “after completion of default inner character library registration” event

		; Omitted second argument — initialization type (“Internal library” ("Internal", by default) or “Custom recipes” ("Custom"))

		; True on the third argument disables progress bar display
		Event.OnEvent("Character Library", "Default Ready", () => (
			ChrLib.AddScript("old_mongolian"),
			ChrReg(charactersData, , True)
		))

		; Registration of new bindings through binding storage initialization event
		; Registration of new Alternative mode through mode storage initialization event
		Event.OnEvent("Binding Storage", "Initialized", () => BindReg(bindsData))
		Event.OnEvent("Scripter Storage", "Initialized", () => ScripterStore("Alternative Modes", alternativeModeData))
		; Adding new entries to the main panel GUI through panel instance creation event
		; Event returns class instance
		Event.OnEvent("UI Instance [Panel]", "Created", SetPanelData)

		return

		; Function for adding new entries to the main panel GUI, called by event
		SetPanelData(ClassInstance) {
			; Getting column information and adding new entries to the main panel GUI
			ClassInstance.GetColumnsData(&columnsData)
			ClassInstance.MergeListViewData(&uiMainGuiData, &columnsData)
			return
		}
	}
}