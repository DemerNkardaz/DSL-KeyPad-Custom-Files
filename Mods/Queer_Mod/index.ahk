Class Mod__Queer_Mod {
	static tools := ModTools(A_LineFile)

	static __New() {
		; Load data files that will be used to modify existing entries.
		local charactersModifyData := JSON.LoadFile(this.tools.paths.data "\characters_modify.json", "UTF-8")
		; Load data files that will be used to add new entries.
		local charactersData := JSON.LoadFile(this.tools.paths.data "\characters.json", "UTF-8")
		; Load data which affect UI character lists, to show the new entries and modifications in the GUI.
		local uiMainGuiData := JSON.LoadFile(this.tools.paths.data "\ui_main_panel_lists.json", "UTF-8")
		;  Load data for new domain types, to allow using them in character names generation.
		local domainsData := JSON.LoadFile(this.tools.paths.data "\domains.json", "UTF-8")

		; Call action when character library counts raw entries, to modify them before they are processed by the library.
		Event.OnEvent("Character Library", "Raw Entries Counted", Handle)

		; Call action when library has processed the default entries, to add new ones from the mod.
		; “ChrLib.AddDomain” adds new domain types (like “gender”, “sexuality”, etc.) to allow be used in character names generation.
		; “ChrReg” registers new characters to the library. Third parameter “True” turns off progress GUI on registration process.
		Event.OnEvent("Character Library", "Default Ready", () => (ChrLib.AddDomain(domainsData*), ChrReg(charactersData, , True)))

		; Call action when UI instance of type “Panel” is created, to merge the mod data with the main GUI data and show the new entries in the lists.
		Event.OnEvent("UI Instance [Panel]", "Created", SetPanelData) ; Event → function(ClassInstance) { ... }

		return

		Handle(&registrar, &rawEntries, &nameToID) { ; “&nameToID” is not used in this mod, but it existed in event.
			this.ModifyHandler(&charactersModifyData, &registrar, &rawEntries)
		}

		SetPanelData(ClassInstance) {
			ClassInstance.GetColumnsData(&columnsData)
			ClassInstance.MergeListViewData(&uiMainGuiData, &columnsData)
			return
		}
	}

	static ModifyHandler(&charactersModifyData, &registrar, &rawEntries) {
		if charactersModifyData is Array && charactersModifyData.Length >= 2 {
			Loop charactersModifyData.Length // 2 {
				local index := A_Index * 2 - 1
				local entryName := charactersModifyData[index]

				if registrar.IsRawEntryExists(&entryName) { ; Modify only existing entries, skip if entry with such name does not exist in the library.
					local entry := charactersModifyData[index + 1]
					registrar.ModifyRawEntry(&entryName, &rawEntries, &entry)
				}
			}
		}
	}
}