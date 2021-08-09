#########################################
## Subject: SIT718 - Real World Analytics
## File: Barlow-code.R
## Name: Dan Barlow
## Student #: 212142667
#########################################

#######################
# 2 - Factory: LP Model
#######################

library(lpSolveAPI)

lpfactory <- make.lp(9, 9) # 9 variables and 9 constraints

lp.control(lpfactory, sense= "maximize") #  can change sense to  "maximize/minimize"

set.objfn(lpfactory, c(25, 23, 25, 10, 8, 10, 5, 3, 5)) # set objective function

# set constraints
set.row(lpfactory, 1, c(1,1,1), indices = c(1,4,7))
set.row(lpfactory, 2, c(1,1,1), indices = c(2,5,8))
set.row(lpfactory, 3, c(1,1,1), indices = c(3,6,9))
set.row(lpfactory, 4, c(0.45,-0.55,-0.55), indices = c(1,4,7))
set.row(lpfactory, 5, c(0.55,-0.45,-0.45), indices = c(2,5,8))
set.row(lpfactory, 6, c(0.7,-0.3,-0.3), indices = c(3,6,9))
set.row(lpfactory, 7, c(-0.3,0.7,-0.3), indices = c(1,4,7))
set.row(lpfactory, 8, c(-0.4,0.6,-0.4), indices = c(2,5,8))
set.row(lpfactory, 9, c(-0.5,0.5,-0.5), indices = c(3,6,9))

set.rhs(lpfactory, c(3200, 3500, 3800, 0, 0, 0, 0, 0, 0))

set.constr.type(lpfactory, c("<=", "<=", "<=", ">=", ">=", ">=", ">=", ">=", ">="))

set.type(lpfactory, c(1:9),"real")

set.bounds(lpfactory, lower = rep(0, 9), upper = rep(Inf, 9))

solve(lpfactory)

objvalue<-get.objective(lpfactory)
objvalue

solution<-get.variables(lpfactory)
solution
sum(solution[c(1,4,7)])
sum(solution[c(2,5,8)])
sum(solution[c(3,6,9)])



##########################################
# 3 - Parlour Game: 2 Person Zero Sum Game
##########################################

## Payoff for Player 1

library(lpSolveAPI)

lpparlourP1 <- make.lp(0,7)

lp.control(lpparlourP1, sense="maximize")

set.objfn(lpparlourP1, c(0, 0, 0, 0, 0, 0, 1))

# set constraints
add.constraint(lpparlourP1, c(0, 0, 0, -60, 60, 0, 1), "<=", 0)
add.constraint(lpparlourP1, c(0, 0, -60, 0, 0, 60, 1), "<=", 0)
add.constraint(lpparlourP1, c(0, 60, 0, 0, 0, -60, 1), "<=", 0)
add.constraint(lpparlourP1, c(60, 0, 0, 0, -60, 0, 1), "<=", 0)
add.constraint(lpparlourP1, c(-60, 0, 0, 60, 0, 0, 1), "<=", 0)
add.constraint(lpparlourP1, c(0, -60, 60, 0, 0, 0, 1), "<=", 0)
add.constraint(lpparlourP1, c(1, 1, 1, 1, 1, 1, 0), "=", 1)

set.bounds(lpparlourP1, lower = c(0, 0, 0, 0, 0, 0, -Inf))

RowNames <- c("Row1", "Row2", "Row3", "Row4", "Row5", "Row6", "Row 7")
ColNames <- c("B1", "B2", "B3", "B4", "B5", "B6", "V")

dimnames(lpparlourP1) <- list(RowNames, ColNames)

solve(lpparlourP1)

get.objective(lpparlourP1)
get.variables(lpparlourP1)

write.lp(lpparlourP1, filename="P1.lp")

## Payoff for Player 2

library(lpSolveAPI)

lpparlourP2 <- make.lp(0,7)

lp.control(lpparlourP2, sense="minimize")

set.objfn(lpparlourP2, c(0, 0, 0, 0, 0, 0, 1))

# set constraints
add.constraint(lpparlourP2, c(0, 0, 0, 60, -60, 0, 1), ">=", 0)
add.constraint(lpparlourP2, c(0, 0, 60, 0, 0, -60, 1), ">=", 0)
add.constraint(lpparlourP2, c(0, -60, 0, 0, 0, 60, 1), ">=", 0)
add.constraint(lpparlourP2, c(-60, 0, 0, 0, 60, 0, 1), ">=", 0)
add.constraint(lpparlourP2, c(60, 0, 0, -60, 0, 0, 1), ">=", 0)
add.constraint(lpparlourP2, c(0, 60, -60, 0, 0, 0, 1), ">=", 0)
add.constraint(lpparlourP2, c(1, 1, 1, 1, 1, 1, 0), "=", 1)

set.bounds(lpparlourP2, lower = c(0, 0, 0, 0, 0, 0, -Inf))

RowNames <- c("Row1", "Row2", "Row3", "Row4", "Row5", "Row6", "Row 7")
ColNames <- c("A1", "A2", "A3", "A4", "A5", "A6", "V")

dimnames(lpparlourP2) <- list(RowNames, ColNames)

solve(lpparlourP2)

get.objective(lpparlourP2)
get.variables(lpparlourP2)

write.lp(lpparlourP1, filename="P2.lp")