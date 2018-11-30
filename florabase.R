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


# 30 nov 2018: realised that not all WA taxa are on the list, so downloading all WA plant species from ALA
wa <- read.csv('records-2018-11-30-2.csv') %>% 
  rename(taxon_url = Species,
         scientificName_short = Species.Name,
         recordedBy = Scientific.Name.Authorship,
         taxonRank = Taxon.Rank,
         kingdom = Kingdom,
         phylum = Phylum,
         class = Class,
         order = Order,
         family = Family,
         genus = Genus,
         vernacularName = Vernacular.Name) %>% 
  mutate(scientificName = paste(scientificName_short, recordedBy)) %>% 
  dplyr::select(-Conservation, Invasive)

# filter out those taxa already in taxon2
wa.sub <- wa %>% 
  filter(!scientificName %in% as.character(taxon2$scientificName ) )
nrow(wa) - nrow(wa.sub)
nrow(wa)
nrow(wa.sub)


# create csv for import into Fulcrum
write.csv(wa.sub, file = 'wa_taxon_fulcrum.csv', row.names = F,
          na = '', quote = T)
