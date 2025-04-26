#Requires AutoHotkey v2
#SingleInstance Force

Insert:: (Send("+{Del}"), Sleep(50), Send("{Enter}"))

;; This script will delete the selected file and then press Enter to confirm the deletion.
