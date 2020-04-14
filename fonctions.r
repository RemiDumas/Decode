#
# fonction install_and_load ####
# installe et charge plusieurs packages R.
# Vérifie si les packages son installés. 
# Installe ceux qui ne le sont pas et charge tous les packages dans la session R.
#

install_and_load <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# chargement des packages ####
packages <- c("tidyverse", "rvest", "purrr", "stringr", "gt", "lubridate", "glue", "httr", "xml2")
install_and_load(packages)

#
# Liste des régions et liens vers les tableaux de bord
# de la conjoncture sur Insee.fr.
#

reg_tablinks <- data.frame(
  stringsAsFactors = FALSE,
  reg = c("FR","01", "02", "03", "04", "06", "11", "24", "27", "28", "32", "44", "52", "53", "75", "76", "84", "93", "94"),
  libelle = c(
    "France",
    "Guadeloupe",
    "Martinique",
    "Guyane",
    "La Réunion",
    "Mayotte",
    "Île-de-France",
    "Centre-Val de Loire",
    "Bourgogne-Franche-Comté",
    "Normandie",
    "Hauts-de-France",
    "Grand Est",
    "Pays de la Loire",
    "Bretagne",
    "Nouvelle-Aquitaine",
    "Occitanie",
    "Auvergne-Rhône-Alpes",
    "Provence-Alpes-Côte d'Azur",
    "Corse"
  ),
  links = c(
    "https://insee.fr/fr/statistiques/2107840",
    "https://insee.fr/fr/statistiques/2122307",
    "https://insee.fr/fr/statistiques/2122310",
    "https://insee.fr/fr/statistiques/2122304",
    "https://insee.fr/fr/statistiques/2120921",
    "https://insee.fr/fr/statistiques/2122332",
    "https://insee.fr/fr/statistiques/2109644",
    "https://insee.fr/fr/statistiques/2121821",
    "https://insee.fr/fr/statistiques/2121815",
    "https://insee.fr/fr/statistiques/2122336",
    "https://insee.fr/fr/statistiques/2121818",
    "https://insee.fr/fr/statistiques/2121812",
    "https://insee.fr/fr/statistiques/2122397",
    "https://insee.fr/fr/statistiques/2121844",
    "https://insee.fr/fr/statistiques/2121832",
    "https://insee.fr/fr/statistiques/2109662",
    "https://insee.fr/fr/statistiques/2121840",
    "https://insee.fr/fr/statistiques/2122219",
    "https://insee.fr/fr/statistiques/2122216"
  )
)


# recupération des données sur le tableau de bord de la conjoncture
region <- "75"

data_conj <- read_html(reg_tablinks %>% filter(reg == region) %>% pull(links))

tab_00recap <- data_conj %>% 
  html_nodes("#produit-tableau-figure1") %>% # on pointe sur cet élement
  html_table(fill = TRUE) %>% #on récupere le tableau
  as.data.frame() %>% # sinon on a une liste d'un seul élement
  setNames(.[1,]) %>% #les bons en-tetes
  slice(-1) %>% # la premiere ligne est inutile désormais
  filter(.[[1]] !=.[[2]]) %>% # on vire les lignes des chapitres
  select(-Régionale, -Nationale)# on vire ces deux dernières colonnes, les fleches n'aparaissent pas

tab_05empsal <- data_conj %>% 
  html_nodes("#tableau-Figure0101p-1") %>% # on pointe sur cet élement
  html_table(fill = TRUE) %>% #on récupere le tableau
  as.data.frame() %>% # sinon on a une liste d'un seul élement

  data_conj %>% 
  html_nodes("#tableau-Figure0101p-1")  # on pointe sur cet élement

data <- data_conj %>% 
  html_table(fill = TRUE) %>% setNames(paste0("tab",1:31))

list2env(data, envir = .GlobalEnv)

tab2[1,2] <- "Territoire"
emploitot_dep <- tab2 %>% slice(-1) %>% 
  gather(key = triman, value = emploi)

data_conj %>% 
  html_nodes("#graphique-Figure0304-2") %>% 
  html_text()
