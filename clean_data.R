## Clean data for participants

library(magrittr)
library(dplyr)
library(expss)

heart_failure <- readr::read_csv("data//heart_failure_raw.csv")

summary(heart_failure)

heart_failure %<>%
  mutate(anaemia  = recode_factor(anaemia, `0` = "No", `1` = "Yes"),
         diabetes = recode_factor(diabetes, `0` = "No", `1` = "Yes"),
         hypertension = recode_factor(high_blood_pressure, `0` = "No", `1` = "Yes"),
         sex = recode_factor(sex, `0` = "Female", `1` = "Male"),
         smoking = recode_factor(smoking, `0` = "No", `1` = "Yes"),
         deceased = recode_factor(DEATH_EVENT, `0` = "No", `1` = "Yes"),
         follow_up = time) %>%
  select(-c(DEATH_EVENT, high_blood_pressure, time))

heart_failure %<>% 
  apply_labels(age = "Age in years",
               anaemia = "Whether the patient has a decrease of red blood cells (No/Yes)",
               hypertension = "Whether the patient has high blood pressure (No/Yes)",
               creatinine_phosphokinase = "Level of the creatinine phosphokinase enzyme in the blood (mcg/L)",
               diabetes = "Whether the patient has diabetes (No/Yes)",
               ejection_fraction = "Percentage of blood leaving the heart at each contraction",
               platelets = "Platelets in de blood (kiloplatelets/mL)",
               sex = "Sex (Female/Male)",
               serum_creatinine = "Level of serum creatinine in the blood (mg/dL)",
               serum_sodium = "Level of serum sodium in the blood (mg/dL)",
               smoking = "Whether the patient smokes (No/Yes)",
               follow_up = "Follow-up period (days)",
               deceased = "Whether the patient decreased during the follow-up period")

heart_failure <- data.frame(heart_failure)

saveRDS(heart_failure, file = "data//heart_failure.RDS")
readRDS("data//heart_failure.RDS")


readr::write_csv(heart_failure, "data//heart_failure.csv")
readr::read_csv("data//heart_failure.csv", 
                col_types = "dfdfddddffffd")

haven::write_sav(heart_failure, "data//heart_failure.sav")
haven::read_sav("data//heart_failure.sav") %>%
  mutate(anaemia = haven::as_factor(anaemia),
         diabetes = haven::as_factor(anaemia),
         sex = haven::as_factor(anaemia),
         smoking = haven::as_factor(anaemia),
         hypertension = haven::as_factor(hypertension),
         deceased = haven::as_factor(deceased))

haven::write_dta(heart_failure, "data//heart_failure.dta")
haven::read_dta("data//heart_failure.dta") %>%
  mutate(anaemia = haven::as_factor(anaemia),
         diabetes = haven::as_factor(anaemia),
         sex = haven::as_factor(anaemia),
         smoking = haven::as_factor(anaemia),
         hypertension = haven::as_factor(hypertension),
         deceased = haven::as_factor(deceased))
