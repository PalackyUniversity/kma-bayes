benlaw <- function(d){log10(1+(1/d))}
benlaw(1)
benlaw(2)
benlaw(3)
benlaw(4)
benlaw(5)
benlaw(6)
benlaw(7)
benlaw(8)
benlaw(9)
data.frame(benlaw(1:9))
sum(benlaw(1:9))
plot(1:9, benlaw(1:9))
popisky<-c(1, 2, 3, 4, 5, 6, 7, 8, 9)
barplot(benlaw(1:9), names.arg = popisky, col="blue")

#install.packages("benford.analysis") #nutno nainstalovat, pokud jeste neni
library(benford.analysis)

Benford2 <- read_excel("C:/Users/matya/OneDrive/Plocha/Benford2.xlsx")
View(Benford2)

#Katastralni vymera
Vymera1<-benford(Benford2$`Katastrální výmìra`,
                    sign='positive',
                    number.of.digits = 1)
Vymera1
plot(Vymera1)

Vymera2<-benford(Benford2$`Katastrální výmìra`,
                 sign='positive',
                 number.of.digits = 2)
Vymera2
plot(Vymera2)

#Pocet obyvatel
Obyvatele1<-benford(Benford2$`Poèet obyvatel`,
                   sign='positive',
                   number.of.digits = 1)
Obyvatele1
plot(Obyvatele1)

Obyvatele2<-benford(Benford2$`Poèet obyvatel`,
              sign='positive',
              number.of.digits = 2)
Obyvatele2
plot(Obyvatele2)

#Prijmy
Prijmy1<-benford(Benford2$`Pøíjmy`,
                    sign='positive',
                    number.of.digits = 1)
Prijmy1
plot(Prijmy1)

Prijmy2<-benford(Benford2$`Pøíjmy`,
                 sign='positive',
                 number.of.digits = 2)
Prijmy2
plot(Prijmy2)

#Vydaje
Vydaje1<-benford(Benford2$`Výdaje`,
                 sign='positive',
                 number.of.digits = 1)
Vydaje1
plot(Vydaje1)

Vydaje2<-benford(Benford2$`Výdaje`,
                 sign='positive',
                 number.of.digits = 2)
Vydaje1
plot(Vydaje2)