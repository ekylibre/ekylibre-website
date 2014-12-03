---
title: Ekylibre 0.3.2.1 sorti
name: ekylibre-0-3-2-1
---
Cette nouvelle version d’Ekylibre correspond à la correction des bugs de l’installateur Debian/Ubuntu.

Il corrige des bugs liés à des dépendances non-satisfaites. Cette révision permet notamment de pouvoir installer Ekylibre sur des distribution plus ancienne comme Ubuntu Lucid. En cassant un peu avec la logique Debian classique, l’installateur s’occupe de récupérer les dernières versions des composants manquants (rubygems, rake et passenger) en prenant en compte les paquets officiels que s’ils sont installés avec des versions compatibles. Cela en fait un paquet un peu plus "tout terrain".
