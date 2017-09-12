library(jsonlite)

# Sortirani podaci o nazivima timova i njihovim zvanicnim bojama

team <-
  c(
    "ATL",
    "BKN",
    "BOS",
    "CHA",
    "CHI",
    "CLE",
    "DAL",
    "DEN",
    "DET",
    "GSW",
    "HOU",
    "IND",
    "LAC",
    "LAL",
    "MEM",
    "MIA",
    "MIL",
    "MIN",
    "NOP",
    "NYK",
    "OKC",
    "ORL",
    "PHI",
    "PHX",
    "POR",
    "SAC",
    "SAS",
    "TOR",
    "UTA",
    "WAS"
  )
color <-
  c(
    "#E03A3E",
    "#FFFFFF",
    "#008348",
    "#1D1160",
    "#CE1141",
    "#860038",
    "#007DC5",
    "#4FA8FF",
    "#006BB6",
    "#006BB6",
    "#CE1141",
    "#00275D",
    "#ED174C",
    "#552582",
    "#23375B",
    "#98002E",
    "#00471B",
    "#002B5C",
    "#002B5C",
    "#006BB6",
    "#007DC3",
    "#007DC5",
    "#006BB6",
    "#E56020",
    "#F0163A",
    "#724C9F",
    "#B6BFBF",
    "#CE1141",
    "#002B5C",
    "#002566"
  )
auxcolor <-
  c(
    "#C3D600",
    "#000000",
    "#FFFFFF",
    "#008CA8",
    "#000000",
    "#FDBB30",
    "#C4CED3",
    "#FFB20F",
    "#ED174C",
    "#FFC72D",
    "#C4CED3",
    "#FFC633",
    "#006BB6",
    "#FDB927",
    "#6189B9",
    "#F9A01B",
    "#EEE1C6",
    "#C6CFD4",
    "#B4975A",
    "#F58426",
    "#F05133",
    "#C4CED3",
    "#ED174C",
    "#1D1160",
    "#B6BFBF",
    "#8E9090",
    "#FFFFFF",
    "#C4CED3",
    "#F9A01B",
    "#F5002F"
  )

# Primer strukture podataka za vizualizaciju

generateRandoms <- function() {
  return (toJSON(
    data.frame(
      x = rnorm(30),
      y = runif(30),
      team = team,
      color = color,
      auxcolor = auxcolor
    )
  ))
}

# Funkcije za prikupljanje i pripremu podataka iz lokalnih .csv datoteka

getInternalData <- function() {
  files <- list.files('data', full.names = TRUE)
  data <- lapply(files, read.csv, stringsAsFactors = FALSE)
  return (prepareDataFrame(data))
}

# Potrebno je transformisati ucitane podatke u listu koja sadrzi dva data.frame objekta:
# TeamPerGame (performanse tima) i OponentPerGame (performanse protivnika)

prepareDataFrame <- function(data) {
  prep <- lapply(data, function(pg) {
    pg <- as.data.frame(pg)
    rownames(pg) <- pg$Team
    pg <- pg[, 4:dim(pg)[2]]
  })
  names(prep) <- c('opg', 'tpg')
  return (prep)
}

# PCA analiza (analiza glavnih komponenti)
# pgd je skracenica od PerGameData tj. jedan od dva data.frame objekta tpg i opg
# funkcija promp sa parametrom skaliranja vraca ocene timova na PC osama kao i vrednosti opterecenja (mera uticaja) promenljivih
# prcomp$x - df sa ocenama
# prcomp$rotation - df sa opterecenjima promenljivih
# summary(prcomp) - df sa merom uticaja svake od glavnih komponenti

performTeamPCA <- function(pgd) {
  return (performPCA(pgd$tpg))
}

performOpponentPCA <- function(pgd) {
  return (performPCA(pgd$opg))
}

performPCA <- function(ogd) {
  pcaTeam <- prcomp(ogd, scale. = TRUE)
  teamOrder <- match(team, rownames(pcaTeam$x))
  
  pcaScores <- pcaTeam$x[teamOrder,]
  pcaLoadings <- pcaTeam$rotation
  pcaVarianceExplained <- round(summary(pcaTeam)$importance[2,], 2)
  pcaCorrelations <- as.data.frame(cor(ogd[teamOrder,], pcaScores))
  
  return (list(
    scores = data.frame(
      x = pcaScores[, 1],
      y = pcaScores[, 2],
      team = team,
      color = color,
      auxcolor = auxcolor
    ),
    pcainfo = list(
      pcl = pcaLoadings,
      pcva = pcaVarianceExplained,
      pcc = pcaCorrelations,
      varnames = rownames(pcaLoadings),
      pcaNames = colnames(pcaLoadings)
    )
  ))
}