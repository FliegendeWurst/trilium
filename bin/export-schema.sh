#!/usr/bin/env bash

SCHEMA_FILE_PATH=db/schema.sql

sqlite3 ~/trilium-data/document.db .schema | grep -v "sqlite_sequence" > "$SCHEMA_FILE_PATH" | grep -v "note_fulltext_"

echo "DB schema exported to $SCHEMA_FILE_PATH"