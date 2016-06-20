##### Modelling
# linear regression model to predict violent crime per city from all other variables, excluding
# variables representing specific kinds of violent crime
cityviollm <- lm(Violent_crime ~ . - Rape - Robbery - Aggravated_assualt - `Murder_and_non-neg_manslaughter` - City - State, fbi)
summary(cityviollm)

# linear regression model to predict violent crime per state from all other variables, 
# excluding variables representing specific types of violent crime
stateviollm <- lm(Violent_crime ~ . - Rape - Robbery - Aggravated_assualt - `Murder_and_non-neg_manslaughter`, states.data)
summary(stateviollm) # good performance using only population

# linear regression model to predict violent crime per city per capita from all other
# variables, exluding variables representing specific types of violent crime
cityviollmpc <- lm(Violent_crime ~ . - Rape - Robbery - Aggravated_assualt - `Murder_and_non-neg_manslaughter` - City - State, fbi.pc)
summary(cityviollmpc)

# linear regression model to predict violent crime per capita from all other variables
stateviollmpc <- lm(Violent_crime ~ . - Rape - Robbery - Aggravated_assualt - `Murder_and_non-neg_manslaughter`, states.data.pc)
summary(stateviollmpc)