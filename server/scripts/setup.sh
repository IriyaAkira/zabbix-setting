#!/bin/bash
set -eu

# ===== 固定パス定義 =====
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
LOG_DIR="${SCRIPT_DIR}/logs"

# ===== ログディレクトリ作成 =====
mkdir -p "${LOG_DIR}"
LOG_DIR="$(cd "${LOG_DIR}" && pwd)"
LOG_FILE="${LOG_DIR}/${SCRIPT_NAME%.*}.log"

# ===== ログ関数 =====
log_info() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $1" | tee -a "${LOG_FILE}"
}
log_error() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" | tee -a "${LOG_FILE}" >&2
}

# ===== エラーハンドラ =====
trap 'log_error "Script failed at line $LINENO"' ERR

# ===== ログ開始 =====
log_info "===== Starting ${SCRIPT_NAME} (PID: $$) ====="

# ===== ログファイルの容量制限 =====
log_info "Starting log file size limit."
MAX_LINES=10000
if [[ -f "${LOG_FILE}" ]] && [[ $(wc -l < "${LOG_FILE}") -gt ${MAX_LINES} ]]; then
  tail -n "${MAX_LINES}" "${LOG_FILE}" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "${LOG_FILE}"
  log_info "Log file rotated (kept last ${MAX_LINES} lines)."
fi

# ===== Zabbix公式docker用githubリポジトリのクローン =====
REPO_URL="https://github.com/zabbix/zabbix-docker.git"
DEST_DIR="${HOME}/zabbix"

log_info "Start Cloning zabbix-docker repository"
if [ -d "${DEST_DIR}" ]; then
  log_error "${DEST_DIR} already exists."
  log_info "If you want to re-clone, remove it first: rm -rf ${DEST_DIR}"
else
    log_info "Cloning zabbix-docker repository: ${REPO_URL} -> ${DEST_DIR}"
    if git clone "${REPO_URL}" "${DEST_DIR}" 2>&1 | tee -a "${LOG_FILE}"; then
    log_info "git clone completed successfully."
    log_info "Listing ${DEST_DIR} contents:"
    ls -la "${DEST_DIR}" 2>&1 | tee -a "${LOG_FILE}"
    else
    log_error "git clone failed. See above for details."
    exit 1
    fi
fi

# ===== 設定変更 =====


# ===== ログ終了 =====
log_info "===== Finished ${SCRIPT_NAME} (PID: $$) ====="
