#!/usr/bin/env node

// Claude Code status line.
// Reads session JSON from stdin and prints one row:
//   📁 dir ∷ 🌿 branch | 5h 23% ↻14:30 | 7d 41% | 🧠 42% (424K/1M) | [Model]
// Schema: https://code.claude.com/docs/en/statusline

const { execFileSync } = require('child_process');
const path = require('path');

const CYAN = '\x1b[36m';
const GREEN = '\x1b[32m';
const YELLOW = '\x1b[33m';
const RED = '\x1b[31m';
const DIM = '\x1b[2m';
const RESET = '\x1b[0m';

let input = '';
process.stdin.on('data', chunk => (input += chunk));
process.stdin.on('end', () => {
    try {
        const data = JSON.parse(input);

        const model = data.model?.display_name || 'Unknown';
        const dir = data.workspace?.current_dir || data.cwd || '.';
        const ctx = data.context_window || {};
        // used_percentage is null until the first API response of a session,
        // and again right after /compact.
        const pct = Math.floor(ctx.used_percentage || 0);
        const used = ctx.total_input_tokens || 0;
        const size = ctx.context_window_size || 0;

        const tokens = size ? ` ${DIM}(${formatTokens(used)}/${formatTokens(size)})${RESET}` : '';
        const line = [
            [`📁 ${path.basename(dir)}`, gitBranch(dir)].filter(Boolean).join(' ∷ '),
            // rate_limits は Claude.ai のサブスクリプション、かつ最初の API 応答以降でのみ現れる。
            // 5h / 7d はそれぞれ独立に欠けうるので、無い枠は丸ごと落とす
            rateLimit('5h', data.rate_limits?.five_hour, true),
            rateLimit('7d', data.rate_limits?.seven_day, false),
            `🧠 ${percentage(pct)}${tokens}`,
            `${CYAN}[${model}]${RESET}`,
        ].filter(Boolean).join(' | ');

        console.log(line);
    } catch (error) {
        console.log(`${RED}[statusline error]${RESET} ${error.message}`);
    }
});

function rateLimit(label, window, showsReset) {
    if (window?.used_percentage == null) return '';

    let text = `${label} ${percentage(Math.round(window.used_percentage))}`;
    if (showsReset && window.resets_at) {
        text += ` ${DIM}↻${formatTime(window.resets_at)}${RESET}`;
    }
    return text;
}

function percentage(pct) {
    const color = pct >= 90 ? RED : pct >= 70 ? YELLOW : GREEN;
    return `${color}${pct}%${RESET}`;
}

// resets_at is Unix epoch seconds; render it in local time.
function formatTime(epochSeconds) {
    const at = new Date(epochSeconds * 1000);
    return `${String(at.getHours()).padStart(2, '0')}:${String(at.getMinutes()).padStart(2, '0')}`;
}

function gitBranch(cwd) {
    try {
        const branch = execFileSync('git', ['branch', '--show-current'], {
            cwd,
            encoding: 'utf8',
            stdio: ['pipe', 'pipe', 'ignore'],
        }).trim();
        return branch ? `🌿 ${branch}` : '';
    } catch {
        return '';
    }
}

function formatTokens(tokens) {
    if (tokens >= 1000000) {
        const m = tokens / 1000000;
        return `${Number.isInteger(m) ? m : m.toFixed(1)}M`;
    }
    if (tokens >= 1000) {
        return `${Math.round(tokens / 1000)}K`;
    }
    return String(tokens);
}
