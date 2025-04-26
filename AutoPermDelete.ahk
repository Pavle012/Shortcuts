;; This script will permanently delete the selected file / email and then press Enter to confirm the deletion.
;; It uses the Insert key to trigger the deletion process.

#SingleInstance Force

Insert:: (Send("+{Del}"), Sleep(50), Send("{Enter}"))