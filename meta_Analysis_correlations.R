# sets the directory of location of this script as the current directory
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

rm(list=ls(all=TRUE))
graphics.off()

########################################
# load packages
########################################


library(tidyverse)


# library(rjson) # write JSON files


# library(igraph)

library(xlsx)
library(meta)

library(psych)

########################################
# load DATA network indicators
########################################
dir()
setwd("data/network indicators")

files_xlsx <- list.files(path = getwd(), pattern = "*.xlsx", full.names = FALSE)


list_NetworkParams <- list(); h=1
for(f in files_xlsx){
  tmp_name <- str_remove_all(string = f, pattern = "CAMindicator_|\\.xlsx")
  tmp_dat <-  xlsx::read.xlsx2(file = f, sheetIndex = 1)


  list_NetworkParams[[tmp_name]] <- tmp_dat

  tmp_dat$group <- tmp_name
  if(h==1){
    allstudies <- tmp_dat
  }else{
    allstudies <- rbind(allstudies, tmp_dat)
  }

  h=h+1
}

allstudies <- as.data.frame(allstudies)
allstudies$X. <- NULL
# allstudies$CAM_ID <- NULL
# allstudies$participantCAM <- NULL


allstudies[, 3:28] <- as.data.frame(sapply(allstudies[, 3:28], as.numeric))

table(allstudies$group)








########################################
# load DATA surveys
########################################
setwd("../surveys")
dir()



questionnaire_SAI2022 <- xlsx::read.xlsx2(file = "questionnaire_SAI2022.xlsx", sheetIndex = 1)
questionnaireCAM_SAI2022 <- xlsx::read.xlsx2(file = "questionnaireCAM_SAI2022.xlsx", sheetIndex = 1)
questionnaire_wide_FTI2021 <- xlsx::read.xlsx2(file = "dat_wide_merged_final_FTI2021.xlsx", sheetIndex = 1)
questionnaire_long_FTI2021 <- xlsx::read.xlsx2(file = "dat_long_merged_final_FTI2021.xlsx", sheetIndex = 1)
questionnaire_NetApp2021 <- read.csv(file = "CAM Study Data Canadian and German Samples Combined_NetApp2021.csv",
                                      header = TRUE, sep = ",")


setwd("../..")




questionnaire_SAI2022[, str_subset(string = colnames(questionnaire_SAI2022), pattern = "mean_")] <-
  as.data.frame(sapply(questionnaire_SAI2022[, str_subset(string = colnames(questionnaire_SAI2022), pattern = "mean_")], as.numeric))
questionnaire_SAI2022$total_min <- as.numeric(questionnaire_SAI2022$total_min)




########################################
########################################
########################################
# correlations
########################################
################# SAI2022 study
tmp_allstudies_filtered <- allstudies[allstudies$group == "SAI2022", ]
tmp_currentAnalysis <- left_join(x = tmp_allstudies_filtered, y = questionnaire_SAI2022, by = c("participantCAM" = "PROLIFIC_PID"))



hist(tmp_currentAnalysis$total_min)
summary(tmp_currentAnalysis$total_min)


tmp_currentCorrelation <- cbind(tmp_currentAnalysis[, 3:28], tmp_currentAnalysis[, str_subset(string = colnames(tmp_currentAnalysis), pattern = "mean_")])
psych::cor.plot(r = cor(tmp_currentCorrelation, use = "pairwise.complete.obs"),
                upper = FALSE, xlas = 2)


tmp_currentCorrelation <- cbind(tmp_currentAnalysis[, 3:10], tmp_currentAnalysis[, str_subset(string = colnames(tmp_currentAnalysis), pattern = "mean_")])
psych::cor.plot(r = cor(tmp_currentCorrelation, use = "pairwise.complete.obs"),
                upper = FALSE, xlas = 2)



plot(tmp_currentAnalysis$mean_acceptability ~ tmp_currentAnalysis$mean_valence_macro)
cor(tmp_currentAnalysis$mean_acceptability, tmp_currentAnalysis$mean_valence_macro, use = "pairwise.complete.obs")
abline(lm(formula = (tmp_currentAnalysis$mean_acceptability ~ tmp_currentAnalysis$mean_valence_macro)), col = "red")


plot(tmp_currentAnalysis$mean_emoPositive ~ tmp_currentAnalysis$mean_valence_macro)
cor(tmp_currentAnalysis$mean_emoPositive, tmp_currentAnalysis$mean_valence_macro, use = "pairwise.complete.obs")
abline(lm(formula = (tmp_currentAnalysis$mean_emoPositive ~ tmp_currentAnalysis$mean_valence_macro)), col = "red")


plot(tmp_currentAnalysis$mean_ClimateChangeConcern ~ tmp_currentAnalysis$mean_valence_macro)
cor(tmp_currentAnalysis$mean_ClimateChangeConcern, tmp_currentAnalysis$mean_valence_macro, use = "pairwise.complete.obs")
abline(lm(formula = (tmp_currentAnalysis$mean_ClimateChangeConcern ~ tmp_currentAnalysis$mean_valence_macro)), col = "red")



################## FTI2021_t1 study
tmp_allstudies_filtered <- allstudies[allstudies$group == "FTI2021_t1", ]
questionnaire_wide_FTI2021$loginID_t0


questionnaire_wide_FTI2021$loginID_t0 %in% str_remove_all(string = tmp_allstudies_filtered$participantCAM, pattern = "_[:digit:]*")


tmp_allstudies_filtered$participantCAM_adjusted <- str_remove_all(string = tmp_allstudies_filtered$participantCAM, pattern = "_[:digit:]*")

tmp_currentAnalysis <- left_join(x = tmp_allstudies_filtered, y = questionnaire_wide_FTI2021, by = c("participantCAM_adjusted" = "loginID_t0"))




tmp_currentAnalysis[, str_detect(string = colnames(tmp_currentAnalysis), pattern = "^tam_.+")] <-
  as.data.frame(sapply(tmp_currentAnalysis[, str_detect(string = colnames(tmp_currentAnalysis), pattern = "^tam_.+")], as.numeric))

tmp_currentAnalysis$tam_mean <- rowMeans(tmp_currentAnalysis[, str_detect(string = colnames(tmp_currentAnalysis), pattern = "^tam_.+")])



tmp_currentAnalysis[, str_detect(string = colnames(tmp_currentAnalysis), pattern = "^panas.*n_t0")] <-
  as.data.frame(sapply(tmp_currentAnalysis[, str_detect(string = colnames(tmp_currentAnalysis), pattern = "^panas.*n_t0")], as.numeric))

tmp_currentAnalysis$panas_negative_mean <- rowMeans(tmp_currentAnalysis[, str_detect(string = colnames(tmp_currentAnalysis), pattern = "^panas.*n_t0")])

tmp_currentAnalysis[, str_detect(string = colnames(tmp_currentAnalysis), pattern = "^panas.*p_t0")] <-
  as.data.frame(sapply(tmp_currentAnalysis[, str_detect(string = colnames(tmp_currentAnalysis), pattern = "^panas.*p_t0")], as.numeric))

tmp_currentAnalysis$panas_positive_mean <- rowMeans(tmp_currentAnalysis[, str_detect(string = colnames(tmp_currentAnalysis), pattern = "^panas.*p_t0")])



tmp_currentCorrelation <- cbind(tmp_currentAnalysis[, 3:28], tmp_currentAnalysis[, c("tam_mean", "panas_negative_mean", "panas_positive_mean")])
psych::cor.plot(r = cor(tmp_currentCorrelation, use = "pairwise.complete.obs"),
                upper = FALSE, xlas = 2)


tmp_currentCorrelation <- cbind(tmp_currentAnalysis[, 3:10], tmp_currentAnalysis[, c("tam_mean", "panas_negative_mean", "panas_positive_mean")])
psych::cor.plot(r = cor(tmp_currentCorrelation, use = "pairwise.complete.obs"),
                upper = FALSE, xlas = 2)



########################################
########################################
########################################
# correlations
########################################
colnames(allstudies)
psych::cor.plot(r = cor(allstudies[, 3:22], use = "pairwise.complete.obs"),
                upper = FALSE, xlas = 2)





psych::cor.plot(r = cor(allstudies[allstudies$group == "Feedback2022", 1:26], use = "pairwise.complete.obs"), upper = FALSE, xlas = 2)
psych::cor.plot(r = cor(allstudies[allstudies$group == "FTI2021_t1", 1:26], use = "pairwise.complete.obs"), upper = FALSE, xlas = 2)
psych::cor.plot(r = cor(allstudies[allstudies$group == "FTI2021_t2", 1:26], use = "pairwise.complete.obs"), upper = FALSE, xlas = 2)


a <- allstudies$CAM_ID
b <- a[allstudies$group == "SAI2022"]
###
tmp <- allstudies[allstudies$group == "SAI2022",]
tmp <- data.frame(density = tmp$density_macro, ID = b)
tmp[order(tmp$density),]
###

########################################
# meta-analysis of means can be conducted using the metamean function
########################################

# allstudies$num_nodes_macro

out_metanalysis <- allstudies %>%
  group_by(group) %>%
  summarise(n = n(),
            mean = mean(x = num_nodes_macro, na.rm = TRUE),
            sd = sd(x = num_nodes_macro, na.rm = TRUE))
colnames(out_metanalysis)[1] <- "CAMstudy"
out_metanalysis$forcedDesign <- c(FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE)



m.mean <- metamean(n = n,
                   mean = mean,
                   sd = sd,
                   studlab = CAMstudy,
                   data = out_metanalysis,
                   sm = "MRAW",
                   fixed = FALSE,
                   random = TRUE,
                   method.tau = "REML",
                   hakn = TRUE,
                   title = "Mean Number of Concepts")
summary(m.mean)




forest.meta(m.mean,
            sortvar = TE,
            prediction = TRUE,
            print.tau2 = FALSE,
            leftlabs = c("Author", "g", "SE"))







update.meta(m.mean,
            subgroup = forcedDesign,
            tau.common = FALSE)





out_metanalysis_noForced <- out_metanalysis[!out_metanalysis$forcedDesign, ]
m.mean_noForced <- metamean(n = n,
                   mean = mean,
                   sd = sd,
                   studlab = CAMstudy,
                   data = out_metanalysis_noForced,
                   sm = "MRAW",
                   fixed = FALSE,
                   random = TRUE,
                   method.tau = "REML",
                   hakn = TRUE,
                   title = "Mean Number of Concepts")
summary(m.mean)




forest.meta(m.mean_noForced,
            sortvar = TE,
            prediction = TRUE,
            print.tau2 = FALSE,
            leftlabs = c("Author", "g", "SE"))







########################################
# pooled using the metacor function, which uses the generic inverse variance pooling method
########################################
out_metanalysis <- allstudies %>%
  group_by(group) %>%
  summarise(n = n())
colnames(out_metanalysis)[1] <- "CAMstudy"
out_metanalysis$cor <- NA



whichParams <- c("density_macro", "num_nodes_macro")

h=1
for(c in out_metanalysis$CAMstudy){
  tmp <- allstudies[allstudies$group == c,whichParams]
  # print(c)
  # print(cor(tmp)[1,2])
  out_metanalysis$cor[h] <- cor(tmp)[1,2]
    h=h+1
}



m.cor <- metacor(cor = cor,
                 n = n,
                 studlab = CAMstudy,
                 data = out_metanalysis,
                 fixed = FALSE,
                 random = TRUE,
                 method.tau = "REML",
                 hakn = TRUE,
                 title = "Health and Wellbeing")
summary(m.cor)



forest.meta(m.cor,
            sortvar = TE,
            prediction = TRUE,
            print.tau2 = FALSE,
            leftlabs = c("Author", "g", "SE"))




hist(allstudies$density_macro[allstudies$group == "LW2020"])
hist(allstudies$density_macro[allstudies$group == "FTI2021_t1"])
hist(allstudies$density_macro[allstudies$group == "SAI2022"])





##############################################################################
out_metanalysis <- allstudies %>%
  group_by(group) %>%
  summarise(n = n())
colnames(out_metanalysis)[1] <- "CAMstudy"
out_metanalysis$cor <- NA



whichParams <- c("meanDistance_undirected_macro", "num_nodes_macro")

h=1
for(c in out_metanalysis$CAMstudy){
  tmp <- allstudies[allstudies$group == c,whichParams]
  # print(c)
  # print(cor(tmp)[1,2])
  out_metanalysis$cor[h] <- cor(tmp)[1,2]
  h=h+1
}



m.cor <- metacor(cor = cor,
                 n = n,
                 studlab = CAMstudy,
                 data = out_metanalysis,
                 fixed = FALSE,
                 random = TRUE,
                 method.tau = "REML",
                 hakn = TRUE,
                 title = "Health and Wellbeing")
summary(m.cor)



forest.meta(m.cor,
            sortvar = TE,
            prediction = TRUE,
            print.tau2 = FALSE,
            leftlabs = c("Author", "g", "SE"))





plot(allstudies[allstudies$group == "SAI2022", whichParams])
plot(allstudies[allstudies$group == "LW2020", whichParams])
