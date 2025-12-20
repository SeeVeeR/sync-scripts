#!/usr/bin/env bash
# TODO: Добавить папку "Документы" для синхронизации

USER="svr"
HOST="192.168.0.13"

# Корневые папки
SRC_MINT="/data/network_storage"
SRC_SERVER="/mnt/storage/network_storage"

# Папки
LINUX_BOOKS="программирование/Linux/книги/"
LINUX_VIDEO="программирование/Linux/видео/"
OBSIDIAN="obsidian/"

# Опции rsync (одно место для настройки)
RSYNC_OPTS="-avz --delete"

# Префиксы сообщений
MSG_INFO="[INFO]"
MSG_CHECK="[CHECK]"
MSG_RUN="[RUN]"
MSG_OK="[OK]"


###########################################################

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



###########################################################
# Вызовы

# sync_folder "$LINUX_BOOKS"
# sync_folder "$LINUX_VIDEO"
sync_folder "$OBSIDIAN"
