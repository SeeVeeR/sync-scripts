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
  echo "Синхронизация папки $FOLDER"
  read -p "Если всё ок, нажми Enter для dry-run..."

  rsync $RSYNC_OPTS --dry-run -e ssh \
    "$SRC_MINT/$FOLDER" \
    "$USER@$HOST:$SRC_SERVER/$FOLDER"

  echo
  read -p "Если всё ок, нажми Enter для реальной синхронизации..."

  rsync $RSYNC_OPTS -e ssh \
    "$SRC_MINT/$FOLDER" \
    "$USER@$HOST:$SRC_SERVER/$FOLDER"
}

###########################################################
# Вызовы

sync_folder "$LINUX_BOOKS"
sync_folder "$LINUX_VIDEO"
