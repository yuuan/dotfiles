; Ctrl + [ で ESC キー
;^[::Send, {Esc}

; Ctrl + 無変換 で ESC キー
;^vk1Dsc07B::Send, {Esc}

; 無変換キー自体を有効化
;vk1Dsc07B::Send {vk1Dsc07B}

; 無変換 + ↑ で ホイールアップ
;vk1Dsc07B & Up:: Send, {WheelUp}

; 無変換 + ↓ で ホイールダウン
;vk1Dsc07B & Down:: Send, {WheelDown}

; 無変換 + ← で チルト左
;vk1Dsc07B & Left:: Send, {WheelLeft}

; 無変換 + → で チルト右
;vk1Dsc07B & Right:: Send, {WheelRight}

; Win + Ctrl + Shift + PageUp で DDC/CI 経由でコントラストを上げる
#^+PgUp::AdjustMonitorContrast(5)

; Win + Ctrl + Shift + PageDown で DDC/CI 経由でコントラストを下げる
#^+PgDn::AdjustMonitorContrast(-5)

; Firefox, Slack, Trello
#If WinActive("ahk_exe firefox.exe") || WinActive("ahk_exe slack.exe") || WinActive("ahk_exe Trello.exe") || WinActive("ahk_exe Notion.exe")

	; Ctrl + Space で Shift + Space * 4
	^Space::Send, +{Space 4}

	; Shift + Backspace で Backspace * 4
	+Backspace::Send, {Backspace 4}

#If

; DDC/CI 対応ディスプレイすべてのコントラストを delta だけ増減する
AdjustMonitorContrast(delta) {
	handles := GetPhysicalMonitors()
	if (handles.Length() = 0) {
		ShowContrastToolTip("DDC/CI 対応のディスプレイが見つかりません")
		return
	}

	values := ""
	for index, hMonitor in handles {
		; コントラストの下限・現在値・上限を取得する
		if (!DllCall("Dxva2\GetMonitorContrast", "Ptr", hMonitor, "UInt*", minimum, "UInt*", current, "UInt*", maximum, "Int"))
			continue

		value := current + delta
		if (value < minimum)
			value := minimum
		else if (value > maximum)
			value := maximum

		if (!DllCall("Dxva2\SetMonitorContrast", "Ptr", hMonitor, "UInt", value, "Int"))
			continue

		values .= (values = "" ? "" : " / ") . value
	}

	for index, hMonitor in handles
		DllCall("Dxva2\DestroyPhysicalMonitor", "Ptr", hMonitor)

	ShowContrastToolTip(values = "" ? "コントラストを変更できませんでした" : "コントラスト: " . values)
}

; 各モニタの物理モニタハンドル (PHYSICAL_MONITOR.hPhysicalMonitor) を集めて返す
GetPhysicalMonitors() {
	handles := []

	SysGet, monitorCount, MonitorCount
	Loop, %monitorCount%
	{
		SysGet, mon, Monitor, %A_Index%

		VarSetCapacity(rect, 16, 0)
		NumPut(monLeft,   rect,  0, "Int")
		NumPut(monTop,    rect,  4, "Int")
		NumPut(monRight,  rect,  8, "Int")
		NumPut(monBottom, rect, 12, "Int")

		; MONITOR_DEFAULTTONULL (0)
		hMonitor := DllCall("User32\MonitorFromRect", "Ptr", &rect, "UInt", 0, "Ptr")
		if (!hMonitor)
			continue

		if (!DllCall("Dxva2\GetNumberOfPhysicalMonitorsFromHMONITOR", "Ptr", hMonitor, "UInt*", count, "Int") || (count = 0))
			continue

		; PHYSICAL_MONITOR = HANDLE + WCHAR[128]
		size := A_PtrSize + 256
		VarSetCapacity(monitors, size * count, 0)
		if (!DllCall("Dxva2\GetPhysicalMonitorsFromHMONITOR", "Ptr", hMonitor, "UInt", count, "Ptr", &monitors, "Int"))
			continue

		Loop, %count%
			handles.Push(NumGet(monitors, (A_Index - 1) * size, "Ptr"))
	}

	return handles
}

ShowContrastToolTip(text) {
	ToolTip, %text%
	SetTimer, RemoveContrastToolTip, -1500
}

RemoveContrastToolTip:
	ToolTip
return
