Class Mod__Queer_Mod {
	static tools := ModTools(A_LineFile)

	static __New() {
		local charactersModifyData := JSON.LoadFile(this.tools.paths.data "\characters_modify.json", "UTF-8")
		local charactersData := JSON.LoadFile(this.tools.paths.data "\characters.json", "UTF-8")
		local uiMainGuiData := JSON.LoadFile(this.tools.paths.data "\ui_main_panel_lists.json", "UTF-8")
		local domainsData := JSON.LoadFile(this.tools.paths.data "\domains.json", "UTF-8")

		Event.OnEvent("Character Library", "Raw Entries Counted", Handle)

		Event.OnEvent("Character Library", "Default Ready", () => (ChrLib.AddScript(domainsData*), ChrReg(charactersData, , True)))
		Event.OnEvent("UI Instance [Panel]", "Created", SetPanelData)

		return

		Handle(&registrar, &rawEntries, &nameToID) {
			this.ModifyHandler(&charactersModifyData, &registrar, &rawEntries, &nameToID)
		}

		SetPanelData(ClassInstance) {
			ClassInstance.GetColumnsData(&columnsData)
			ClassInstance.MergeListViewData(&uiMainGuiData, &columnsData)
			return
		}
	}

	static ModifyHandler(&charactersModifyData, &registrar, &rawEntries, &nameToID) {
		if charactersModifyData is Array && charactersModifyData.Length >= 2 {
			Loop charactersModifyData.Length // 2 {
				local index := A_Index * 2 - 1
				local entryName := charactersModifyData[index]

				if registrar.IsRawEntryExists(&entryName) {
					local entry := charactersModifyData[index + 1]
					registrar.ModifyRawEntry(&entryName, &rawEntries, &entry)
				}
			}
		}
	}
}
