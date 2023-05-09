# Groupe de travail pour Wav2Vec en français

## Table des matières

- [Introduction](#introduction)
- [Canaux](#canaux)
- [Participer à Wav2Vec](#Participer-à-Wav2Vec)
- [Processus pour Wav2Vec fr](#Processus-pour-Wav2Vec-fr)
- [Bien démarrer](#bien-démarrer)
  - [Installation et configuration](#Installation-et-configuration)
  - [Où trouver des jeux de données](#Ou-trouver-des-jeux-de-données)
  - [Speech-to-Text et Text-to-Speech](#Speech-to-Text-et-Text-to-Speech)
  - [La parole vers le texte et le texte vers la parole](#La-parole-vers-le-texte-et-le-texte-vers-la-parole)
- [Exemples](#exemples)
  - [Convertir la parole vers le texte](#Convertir-la-parole-vers-le-texte)
  - [Utiliser Wav2Vec pour vos projets webs](#Utiliser-Wav2Vec-pour-vos-projets-web)
- [Projets disponibles](#projets-disponibles)


Vous trouverez dans ce document l'ensemble des instructions, documentations... pour le projet Common Voice.

# Introduction

Le projet Wav2Vec est un autre projet de la fondation Mozilla, pour transformer les ondes sonores en texte à partir de l'algorithme d'apprentissage proposé par [Common Voice](https://github.com/Common-Voice/commonvoice-fr/tree/master/CommonVoice).

# Canaux

- **Wav2Vec** utilise le canal **Common Voice fr** sur [Matrix](https://github.com/mozfr/besogne/wiki/Matrix) pour la discussion et la coordination : [s’inscrire au groupe](https://chat.mozilla.org/#/room/#common-voice-fr:mozilla.org) 
- [Discourse Mozilla Francophone](https://discourse.mozilla.org/c/voice/fr)
- [Discourse Mozilla (anglais)](https://discourse.mozilla.org/c/voice)

# Participer à Wav2Vec _pour tous_

Le projet **Wav2Vec** utilise des jeux de données du projet **Common Voice fr**, vous pouvez aider à faire grandir cette base de données : [Participer à Common Voice](https://github.com/Common-Voice/commonvoice-fr/tree/master/CommonVoice#Participer-à-Common-Voice).

# Processus pour Wav2Vec fr

C'est un processus en deux grosses étapes :

Vous aidez à convertir du texte vers l'audio et l'audio en texte.

## Bien démarrer

### Installation et configuration

- Les détails d'installation et de configuration sont disponible à la page de [Contribution](https://github.com/Common-Voice/commonvoice-fr/blob/master/Wav2Vec/CONTRIBUTING.md)

### Où trouver des jeux de données

- <https://commonvoice.mozilla.org/fr/datasets>

### TranScorerLM

Pour entraîner Wav2Vec sur les données, nous utilisons l'outil [TranScorerLM](https://github.com/wasertech/TranScorerLM) permettant d'entraîner un tranformer à devenir un scorer CTC pour la transciption de la voix.

- [Modèles Wav2Vec](https://huggingface.co/models?pipeline_tag=automatic-speech-recognition&language=fr&sort=downloads&search=wav2vec)

### La parole vers le texte et le texte vers la parole (en fr)

- Common Voice Corpora Creator : [FR](https://github.com/Common-Voice/commonvoice-fr/voice-corpus-tool) [EN](https://github.com/mozilla/voice-corpus-tool)
- Common Voice Sentence Collector : [FR](https://github.com/Common-Voice/commonvoice-fr/sentence-collector) [EN](https://github.com/Common-Voice/sentence-collector)

### Convertir la parole vers le texte

# Projets disponibles

- [Listen](https://gitlab.com/waser-technologies/technologies/listen)