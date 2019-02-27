#!/bin/sh

# © Copyright IBM Corp. 2018
#
# All Rights Reserved.
#
# This software is the confidential and proprietary information
# of the IBM Corporation. (‘Confidential Information’). Redistribution
# of the source code or binary form is not permitted without prior authorization
# from the IBM Corporation.

if ! [ "${ACTION}" == "install" ]; then
	echo "Action (${ACTION}) is not install, skipping framework stripping"
	exit 0
fi

code_sign() {
  /usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements "$1"
}

strip_file() {
	echo "Stripping framework: $1"
	EXTRACT=
	for arch in ${VALID_ARCHS}; do
		EXTRACT="${EXTRACT} -extract ${arch}"
	done
	lipo ${EXTRACT} -output $1 $1
}

cd "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"

for file in $(find . -type f); do
  if ! [[ "$(file "$file")" == *"dynamically linked shared library"* ]]; then
    continue
  fi

  strip_file "${file}" || exit 1
  if [ "${CODE_SIGNING_REQUIRED}" == "YES" ]; then
	code_sign "${file}" || exit 1
  fi
done
