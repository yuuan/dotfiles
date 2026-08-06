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

; Firefox, Slack, Trello
#If WinActive("ahk_exe firefox.exe") || WinActive("ahk_exe slack.exe") || WinActive("ahk_exe Trello.exe") || WinActive("ahk_exe Notion.exe")

	; Ctrl + Space で Shift + Space * 4
	^Space::Send, +{Space 4}

	; Shift + Backspace で Backspace * 4
	+Backspace::Send, {Backspace 4}

#If
