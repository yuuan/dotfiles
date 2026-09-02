#!/usr/bin/env pwsh
#
# Claude Code のステータス行 (Windows 用)。stdin からセッション JSON を受け取り、1 行だけ出力する:
#   📁 dir / branch | 🔥 7d 41% / 5h 23% ↻14:30 | 🧠 42% (424K/1M) [Model]
# スキーマ: https://code.claude.com/docs/en/statusline
#
# statusline.zsh の移植で、出力は 1 文字単位で揃えてある。片方を直したらもう片方も直すこと。
#
# 描画のたびに起動されるので、起動コストを抑える:
#   - 呼び出し側で `-NoProfile` を渡してプロファイルを読ませない (zsh 版の `-f` に相当)
#   - JSON は jq ではなく ConvertFrom-Json で読み、起動するプロセスを git の 1 回だけに抑える
#
# 絵文字を直接埋め込んでいるので、BOM 無し UTF-8 のまま保存する
# (pwsh 7 以降は BOM 無しを UTF-8 として読む。Windows PowerShell 5.1 では化けるので #Requires で弾く)

#Requires -Version 7

$ESC = [char]0x1B
$CYAN = "$ESC[36m"
$GREEN = "$ESC[32m"
$YELLOW = "$ESC[33m"
$RED = "$ESC[31m"
$DIM = "$ESC[2m"
$RESET = "$ESC[0m"

# 値が無い項目は zsh 版と同じく「未設定」として扱いたいので、null と空文字をまとめて畳む
function Get-OrDefault($value, $fallback) {
	if ($null -eq $value -or ($value -is [string] -and $value -eq '')) { $fallback } else { $value }
}

# [Math]::Round は偶数丸めで jq の round とズレるため、0.5 を足して切り捨てる
function Get-Rounded([double]$value) {
	[long][Math]::Floor($value + 0.5)
}

function Format-Percentage([long]$pct) {
	$color = if ($pct -ge 90) { $RED } elseif ($pct -ge 70) { $YELLOW } else { $GREEN }

	"$color$pct%$RESET"
}

# PowerShell の / は整数同士でも小数を返し、long へのキャストも偶数丸めになる。
# zsh 版と丸め方を揃えるため、除算のたびに明示的に切り捨てる
function Format-Tokens([long]$tokens) {
	if ($tokens -ge 1000000) {
		if ($tokens % 1000000 -eq 0) {
			return "$([long][Math]::Floor($tokens / 1000000))M"
		}

		$tenths = [long][Math]::Floor(($tokens * 10 + 500000) / 1000000)

		return "$([long][Math]::Floor($tenths / 10)).$($tenths % 10)M"
	}

	if ($tokens -ge 1000) {
		return "$([long][Math]::Floor(($tokens + 500) / 1000))K"
	}

	"$tokens"
}

# rate_limits は Claude.ai のサブスクリプション、かつ最初の API 応答以降でのみ現れる。
# 5h / 7d はそれぞれ独立に欠けうるので、無い枠は丸ごと落とす
function Format-RateLimit([string]$label, $pct, $resetsAt) {
	if ($null -eq $pct) { return '' }

	$text = "$label $(Format-Percentage (Get-Rounded $pct))"

	# resets_at は Unix epoch 秒。ローカルタイムで表示する
	if ($null -ne $resetsAt) {
		$at = [DateTimeOffset]::FromUnixTimeSeconds([long]$resetsAt).ToLocalTime().ToString('HH:mm')
		$text += " $DIM↻$at$RESET"
	}

	$text
}

function Invoke-Main {
	# 絵文字を含む 1 行を出すので、コンソールの出力を UTF-8 に固定する
	[Console]::OutputEncoding = [Text.UTF8Encoding]::new($false)

	$raw = [Console]::In.ReadToEnd()

	$session = $null
	if (-not [string]::IsNullOrWhiteSpace($raw)) {
		try { $session = $raw | ConvertFrom-Json } catch { $session = $null }
	}

	if ($null -eq $session) {
		[Console]::Out.WriteLine("$RED[statusline error]$RESET could not read session JSON")
		return
	}

	$dir = Get-OrDefault $session.workspace.current_dir (Get-OrDefault $session.cwd '.')

	# git が無いマシンでも 1 行は出したいので、失敗はブランチ無しに畳む
	$branch = ''
	try { $branch = "$(& git -C $dir branch --show-current 2> $null)".Trim() } catch { }

	$location = "📁 $(Split-Path -Leaf $dir)"
	if ($branch -ne '') { $location += " / $branch" }

	$limits = $session.rate_limits
	$limitParts = @(
		(Format-RateLimit '7d' $limits.seven_day.used_percentage $null)
		(Format-RateLimit '5h' $limits.five_hour.used_percentage $limits.five_hour.resets_at)
	) | Where-Object { $_ -ne '' }

	$context = $session.context_window

	$tokens = ''
	$size = [long](Get-OrDefault $context.context_window_size 0)
	if ($size -gt 0) {
		$used = [long](Get-OrDefault $context.total_input_tokens 0)
		$tokens = " $DIM($(Format-Tokens $used)/$(Format-Tokens $size))$RESET"
	}

	# used_percentage は 0 と未設定を区別したいので、null のときだけ 0 に畳む
	$pct = if ($null -eq $context.used_percentage) { 0 } else { [long][Math]::Floor($context.used_percentage) }

	$model = Get-OrDefault $session.model.display_name 'Unknown'

	$segments = @($location)
	if ($limitParts.Count -gt 0) { $segments += "🔥 $($limitParts -join ' / ')" }
	$segments += "🧠 $(Format-Percentage $pct)$tokens $CYAN[$model]$RESET"

	[Console]::Out.WriteLine($segments -join ' | ')
}

Invoke-Main
