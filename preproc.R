reviews <- read.csv(file = "./data.csv", stringsAsFactors = FALSE)
# cleaning

colnames(reviews) <- c("X1", "Clothing_ID","Age", "Title" , "Review", "Rating", "Recommended_IND", 
                       "Positive_feedback_count", "Division_Name", "Department_Name", "Class_Name")

# reviews2 = remove_empty(reviews1, which=('rows'))
df <- reviews %>% 
  select(-c(1)) %>% 
  mutate(Age_Group = ifelse(Age<26, '18-25',
                            ifelse(Age<36, '26-35',
                                   ifelse(Age<46, '36-45',
                                          ifelse(Age<56, '46-55',
                                                 ifelse(Age<66, '56-65','66 & above'))))))

df <- df %>% mutate_if(is.character, str_trim)
df <- df[(df$Class_Name !="" | df$Department_Name!=""),]
df <- df[!is.na(df$Class_Name) | !is.na(df$Department_Name),]

df=df[!(df$Class_Name=='Chemises'|df$Class_Name=='Casual bottoms'),]

df=df[!(df$Department_Name=='Trend'),]
df=df[(df$Age<85),]

# df$Class_Name <- as.factor(df$Class_Name)
# df$Rating <- as.factor(df$Rating)
# 
df$Department_Name <- as.factor(df$Department_Name)
df$Division_name <- as.factor(df$Division_Name)
df$Class_Name <- as.factor(df$Class_Name)
df$Recommended_IND <- as.factor(df$Recommended_IND)
df$Clothing_ID <- as.factor(df$Clothing_ID)

write.csv(df, './clean_data.csv')