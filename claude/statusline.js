#!/usr/bin/env node

// Claude Code status line.
// Reads session JSON from stdin and prints two rows:
//   [Model] 📁 dir 🌿 branch
//   ██████░░░░ 42% (420K/1M) | $1.23 | ⏱️ 5m 3s
// Schema: https://code.claude.com/docs/en/statusline

const { execFileSync } = require('child_process');
const path = require('path');

const CYAN = '\x1b[36m';
const GREEN = '\x1b[32m';
const YELLOW = '\x1b[33m';
const RED = '\x1b[31m';
const DIM = '\x1b[2m';
const RESET = '\x1b[0m';

const BAR_WIDTH = 10;

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
        const cost = data.cost?.total_cost_usd || 0;
        const durationMs = data.cost?.total_duration_ms || 0;

        const barColor = pct >= 90 ? RED : pct >= 70 ? YELLOW : GREEN;
        const filled = Math.min(BAR_WIDTH, Math.floor((pct / 100) * BAR_WIDTH));
        const bar = '█'.repeat(filled) + '░'.repeat(BAR_WIDTH - filled);

        const mins = Math.floor(durationMs / 60000);
        const secs = Math.floor((durationMs % 60000) / 1000);

        const first = [
            `${CYAN}[${model}]${RESET}`,
            `📁 ${path.basename(dir)}`,
            gitBranch(dir),
        ].filter(Boolean).join(' ');

        const tokens = size ? `${DIM}(${formatTokens(used)}/${formatTokens(size)})${RESET}` : '';
        const second = [
            `${barColor}${bar}${RESET} ${pct}%`,
            tokens,
            `${YELLOW}$${cost.toFixed(2)}${RESET}`,
            `⏱️ ${mins}m ${secs}s`,
        ].filter(Boolean).join(' ');

        console.log(first);
        console.log(second);
    } catch (error) {
        console.log(`${RED}[statusline error]${RESET} ${error.message}`);
    }
});

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
