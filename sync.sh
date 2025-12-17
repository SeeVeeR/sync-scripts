#!/usr/bin/env bash

USER="svr"
HOST="192.168.0.13"

# Корневые папки
SRC_MINT="/data/network_storage"
SRC_SERVER="/mnt/storage/network_storage"

# Папки
LINUX_BOOKS="программирование/Linux/книги/"
LINUX_VIDEO="программирование/Linux/видео/"

# Опции rsync (одно место для настройки)
RSYNC_OPTS="-avz --delete"

###########################################################

sync_folder() {
  local FOLDER="$1"

  echo
  echo "[INFO] Синхронизация папки: $FOLDER"

  echo "[CHECK] Dry-run. Изменения НЕ применяются."
  read -p "Нажми Enter для выполнения dry-run..."

  rsync $RSYNC_OPTS --dry-run -e ssh \
    "$SRC_MINT/$FOLDER" \
    "$USER@$HOST:$SRC_SERVER/$FOLDER"

  echo
  echo "[RUN] Реальная синхронизация."
  read -p "Если всё ок, нажми Enter для запуска..."

  rsync $RSYNC_OPTS -e ssh \
    "$SRC_MINT/$FOLDER" \
    "$USER@$HOST:$SRC_SERVER/$FOLDER"

  echo "[OK] Синхронизация завершена: $FOLDER"
}


###########################################################
# Вызовы

sync_folder "$LINUX_BOOKS"
sync_folder "$LINUX_VIDEO"
