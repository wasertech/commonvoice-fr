#!/bin/sh

set -xe

export IMPORTERS_VALIDATE_LOCALE="--validate_label_locale $HOME/${MODEL_LANGUAGE}/validate_label.py"

export CV_RELEASE_FILENAME="cv-corpus-11.0-2022-09-21-fr.tar.gz"
export CV_RELEASE_SHA256="f763f9b1817280cd37db4d4161a9afc76257024d5bb54951a5987464e1e2ebb4"

export LINGUA_LIBRE_QID="21"
export LINGUA_LIBRE_ISO639="fra"
export LINGUA_LIBRE_ENGLISH="French"
export LINGUA_LIBRE_SKIPLIST="$HOME/${MODEL_LANGUAGE}/lingua_libre_skiplist.txt"

export M_AILABS_LANG="fr_FR"
export M_AILABS_SKIP="monsieur_lecoq,les_mysteres_de_paris"

export LM_ICONV_LOCALE="fr_FR.UTF-8"

export MODEL_EXPORT_ZIP_LANG="fr-fr"
