# Convert Florabase database into a format to import into Fulcrum
# Etienne Laliberte
# First created November 16 2018
# FloraBase version

# load libraries
library(tidyverse)


# read taxon data
# read bryoquel data
taxon <- read.csv('records-2018-11-17.csv')

# select columns and rename some of them
taxon2 <- taxon %>% 
  dplyr::select(scientificName,
                species,
                recordedBy,
                vernacularName,
                kingdom,
                phylum,
                class,
                order,
                family,
                genus,
                taxonRank,
                taxonConceptID,
                occurrenceID
                ) %>% 
  rename(taxon_url = taxonConceptID,
    taxon_photos_url = occurrenceID,
    scientificName_short = species
         )

# create csv for import into Fulcrum
write.csv(taxon2, file = 'florabase_taxon_fulcrum.csv', row.names = F,
          na = '', quote = F)
