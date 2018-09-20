#!/bin/bash
echo "insert the google doc url";
read FILEURL;
GOOGLE_SERVICEFILEID="$(echo $FILEURL | sed -n 's#.*\https\:\/\/docs\.google\.com\/\([^.]*\)\/d\/*.*#\1#;p')";
FILEID="$(echo $FILEURL | sed -n "s#.*\https\:\/\/docs\.google\.com\/$GOOGLE_SERVICEFILEID\/d\/\([^.]*\)\/.*#\1#;p")";
FILENAME="$(wget -q --show-progress --quiet -O - "https://drive.google.com/file/d/$FILEID/view" | sed -n -e 's!.*<title>\(.*\)\ \-\ Google\ Drive</title>.*!\1!p')";
case "$GOOGLE_SERVICEFILEID" in
"document")
  echo "insert the google document EXTENSION to download(to documents the suported formats are [docx/odt/rtf/PDF/txt/html/epub])";
  read FILEEXTENSION;
  case "$FILEEXTENSION" in
  "docx" | "odt" | "rtf" | "pdf" | "txt" | "epub")
    wget -q --show-progress -c "https://docs.google.com/document/export?format=$FILEEXTENSION&id=$FILEID&includes_info_params=true" -O "$FILENAME.$FILEEXTENSION"
  ;;
  "html")
      wget -q --show-progress -c "https://docs.google.com/document/export?format=zip&id=$FILEID&includes_info_params=true" -O "$FILENAME.zip"
  ;;
  *)
  echo "this is not a suported format,so pdf will be downloaded"
      wget -q --show-progress -c "https://docs.google.com/document/export?format=pdf&id=$FILEID&includes_info_params=true" -O "$FILENAME.pdf"
  ;;
esac
;;
"spreadsheets")
  echo "insert the google document EXTENSION to download(to presentation the suported formats are [xlsx/ods/PDF/html/csv/tsv])";
  read FILEEXTENSION;
  case "$FILEEXTENSION" in
  "xlsx" | "ods" | "pdf" | "csv" | "tsv")
    wget -q --show-progress -c "https://docs.google.com/spreadsheets/export?format=$FILEEXTENSION&id=$FILEID&includes_info_params=true" -O "$FILENAME.$FILEEXTENSION"
  ;;
  "html")
   wget -q --show-progress -c "https://docs.google.com/spreadsheets/export?format=zip/&id=$FILEID&includes_info_params=true" -O "$FILENAME.zip"
  ;;
  *)
  echo "this is not a suported format,so pdf will be downloaded"
  wget -q --show-progress -c "https://docs.google.com/spreadsheets/export?format=pdf&id=$FILEID&includes_info_params=true" -O "$FILENAME.pdf"
  ;;
  esac
;;
"presentation")
  echo "insert the google document EXTENSION to download(to presentation the suported formats are[pptx/odp/PDF/txt/jpg/png/svg])";
  read FILEEXTENSION;
  case "$FILEEXTENSION" in
  "pptx" | "odp" | "pdf" | "txt" | "jpg" | "png" | "svg")
  wget -q --show-progress -c "https://docs.google.com/presentation/export?format=$FILEEXTENSION&id=$FILEID&includes_info_params=true" -O "$FILENAME.$FILEEXTENSION"
  ;;
  "html")
   wget -q --show-progress -c "https://docs.google.com/presentation/export?format=zip/&id=$FILEID&includes_info_params=true" -O "$FILENAME.zip"
  ;;
  *)
  echo "this is not a suported format,so pdf will be downloaded"
  wget -q --show-progress -c "https://docs.google.com/presentation/export?format=pdf&id=$FILEID&includes_info_params=true" -O "$FILENAME.pdf"
  ;;
  esac
;;
"drawings")
  echo "insert the google document EXTENSION to download(if you insert a wrong or not suportated file extension it may not work)";
  read FILEEXTENSION;
  case "$FILEEXTENSION" in
  "jpg" | "png" | "svg" | "pdf")
    wget -q --show-progress -c "https://docs.google.com/drawings/export?format=$FILEEXTENSION&id=$FILEID&includes_info_params=true" -O "$FILENAME.$FILEEXTENSION"
  ;;
  *)
  echo "this is not a suported format,so pdf will be downloaded"
  wget -q --show-progress -c "https://docs.google.com/drawings/export?format=pdf&id=$FILEID&includes_info_params=true" -O "$FILENAME.pdf"
  ;;
  esac
;;
*)
echo "this is not a suported format"
;;
esac
