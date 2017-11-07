require(rvest)
require(data.table)
require(stringr)
require(testthat)

url <- "https://www.leboncoin.fr/ventes_immobilieres/offres/ile_de_france/occasions/?f=c"

webpage <- read_html(url)

cat_data_html <- html_nodes(webpage, ".tabsSwitchNumbers")
cat_data <- html_text(cat_data_html)
cat_data <- str_replace_all(cat_data, "\ ", "")
cat_data <- as.numeric(cat_data)

offres_data_html <- html_nodes(webpage, ".item_title")
offres_data <- html_text(offres_data_html)

expect_equal(cat_data[1], cat_data[2] + cat_data[3])
nb_pages <- ceiling(cat_data[3] / length(offres_data))

begin <- "https://www.leboncoin.fr/ventes_immobilieres/offres/ile_de_france/occasions/?o=1&f=c"
end <- "https://www.leboncoin.fr/ventes_immobilieres/offres/ile_de_france/occasions/?o=23863&f=c"
