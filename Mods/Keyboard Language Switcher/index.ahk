Class YN_KBDLangSwitcher {
	static langs := [ ;
		{ name: "el-GR", id: "408" }, ;
		{ name: "ru-RU", id: "419" }, ;
		{ name: "en-US", id: "409" }, ;
		{ name: "vi-VN", id: "42A" }, ;
		{ name: "ja-JP", id: "411" }, ;
		{ name: "zh-CN", id: "804" }, ;
		{ name: "zh-TW", id: "404" }, ;
		{ name: "ko-KR", id: "412" }, ;
	]

	static __New() {
		for i, each in this.langs {
			local call := this.LocalSwitcher.Bind(, "00000" each.id, 2)
			Hotkey("<^Numpad" (i - 1), call, "S")
		}
	}

	static LocalSwitcher(id, layout := 2) {
		layout := DllCall("LoadKeyboardLayout", "Str", id, "Int", layout)
		hwnd := DllCall("GetForegroundWindow")
		pid := DllCall("GetWindowThreadProcessId", "UInt", hwnd, "Ptr", 0)
		DllCall("PostMessage", "UInt", hwnd, "UInt", 0x50, "UInt", 0, "UInt", layout)
	}
}