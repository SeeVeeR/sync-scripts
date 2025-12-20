#!/usr/bin/env bash

source ./sync.conf

RSYNC_OPTS="-avz --delete"

MSG_INFO="[INFO]"
MSG_CHECK="[CHECK]"
MSG_RUN="[RUN]"
MSG_OK="[OK]"

sync_folder() {
  local FOLDER="$1"

  echo
  echo "$MSG_INFO Синхронизация папки: $FOLDER"

  echo "$MSG_CHECK Dry-run. Изменения НЕ применяются."
  read -p "Нажми Enter для выполнения dry-run..."

  rsync $RSYNC_OPTS --dry-run -e ssh \
    "$SRC_MINT/$FOLDER" \
    "$USER@$HOST:$SRC_SERVER/$FOLDER"

  echo
  echo "$MSG_RUN Реальная синхронизация."
  read -p "Если всё ок, нажми Enter для запуска..."

  rsync $RSYNC_OPTS -e ssh \
    "$SRC_MINT/$FOLDER" \
    "$USER@$HOST:$SRC_SERVER/$FOLDER"

  echo "$MSG_OK Синхронизация завершена: $FOLDER"
}

# Запуски
# sync_folder "$LINUX_BOOKS"
# sync_folder "$LINUX_VIDEO"
sync_folder "${FOLDERS[2]}"
