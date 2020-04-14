# Decode - Données Établies de COnjoncture DEpartementale
Scraping de données à partir des tableaux de bord (TdB) de la conjoncture sur (http://www.insee.fr) (adresses du type: https://insee.fr/fr/statistiques/'idbank')

## Conditions necessaires
- Connection disponible vers Insee.fr

## Packages
- tidyverse
- rvest
- purrr
- stringr
- gt
- lubridate
- glue
- httr 
- xml2

## TODO
- ..

## Version

### v0.1:
- fichier fonctions.r
- liste des pages pour toutes les régions plus le tableau national
    + Code région (FR pour la France) CHR
    + Libellé région CHR
    + Lien CHR: (https://insee.fr/fr/statistiques/'idbank')
- Liste de tableaux sur les pages TdB régions

