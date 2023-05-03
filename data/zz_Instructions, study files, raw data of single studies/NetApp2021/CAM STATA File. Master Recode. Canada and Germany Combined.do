**Master Recode CAM2
*Dispcode - measure of completeness, scores below 30 are incompletes
*Country. 1= Canada, 2=Germany
*CAM_representativeness. Completely unrepresentative - completely representative
*Technical_Problems
*Age. 9 tier categorical. 6 year increments. Top 68+
*Gender. Female, Male, Non-binary, Prefer not
*ReligionImp. How important would you say religion is to your life. 1-Not important at all, 4-Very important
*ReligionR. Add Don't know category to not important at all. 
*Check1. Attention check
*FailCheck. Failed the attention check
*ReligiousEx. Would you describe yourself as a born-again or evangelical?
*EthnicCat - indicated ethnicity.  Note has missing observations, other categories is a mess. response list groups that are listed as possible choices. 
*EthnicCat2 - white vs. non-white
*Religion. religious ID by group
*ReligionText. religious ID open response
*PolOrient. Political orientation 7-point scale
*ZPolOrient. Standardized political orientation on the same 7-point scale. Generated to be combined with German Sample
*Education. 8 catgories. Grade school, some high school, trade school, some college, college(undergrad), graduate, doctorate
*EmploymentStatus. 1= employment status not effected by covid, 2 = employment effected by covid, 3= unemployed due to voide, 4= employed cause unspecified. 
*ZCovidActive standardized combined score of all covid activities measures
*ZCovidSocial. standardize combined score for all covid social activities, friends, family, old firends
*ZCovidMindful. standardized combined score for reading, exercise, meditating
*ZCovidHobby. standardized combined score for baking and gardening
*combined score based on rotate factor loadings
*Doubles repeated observations - 2 equals blank value
*AvgValence runs from negative to positive
*AvgValence1 - ambivalent nodes counted once 
*AvgValence2 - - ambivalent nodes counted twice - for this paper just use AvgValence1
*Diameter - maximum distance from one node to another - longest path in the graph
*TriadicClosure: total number of triangles divided by total number of possible triangles
*CentralNode - ID values, not statistical significance
*CentralNodeValue: using degree centality 
*is it appropriate to log this? Yes
*NOTE:  using e centricity calculating if you want to move from 1 node to any other node, what do you need to do. 
tab Country
tab Doubles
drop if Doubles > 1

tab dispcode
drop if dispcode < 30

tab CAM_representativeness
tab Technical_Problems
tab CAM_representativeness Cancellation
tab Cancellation
*drop if CAM_representativeness < 3
drop if Cancellation > 1

tab Check1
tab Check
recode Check1 (5=1) (else=2), into(FailCheck)
tab FailCheck
drop if FailCheck > 1

tab CAM_representativeness
tab Technical_Problems
tab Technical_Problems_text
tab Cancellation
tab Cancellation_reason
tab Previous_experiences
tab Previous_experiences_text

tab Green_ambivalent
tab Green_positive
tab Green_neutral
tab Green_negative
recode Green_ambivalent (0=0) (1=1), into(GA)
recode Green_positive (0=1) (1=0), into(GP)
recode Green_neutral (0=0) (1=1), into(GN)
recode Green_neutral (0=0) (1=1), into(GNe)


tab Red_ambivalent
tab Red_positive
tab Red_neutral
tab Red_negative
recode Red_ambivalent (0=0) (1=1), into(RA)
recode Red_positive (0=0) (1=1), into(RP)
recode Red_neutral (0=0) (1=1), into(RN)
recode Red_negative (0=1) (1=0), into(RNe)


tab Violette_ambivalent
tab Violette_positive
tab Violette_neutral
tab Violette_negative

recode Violette_ambivalent (1=0) (0=1), into(VA)
recode Violette_positive (0=0) (1=1), into(VP)
recode Violette_neutral (0=0) (1=1), into(VN)
recode Violette_negative (0=0) (1=1), into(VNe)


tab Yellow_ambivalent
tab Yellow_positive
tab Yellow_neutral
tab Yellow_negative

recode Yellow_ambivalent (0=0) (1=1), into(YA)
recode Yellow_positive (0=0) (1=1), into(YP)
recode Yellow_neutral (0=1) (1=0), into(YN)
recode Yellow_negative (0=0) (1=1), into(YNe)

gen CAMComprehension = GA+GP+GN+GNe+RA+RP+RN+RNe+VA+VP+VN+VNe+YA+YP+YN+YNe
tab CAMComprehension
tab NumBlock CAMComprehension
drop if CAMComprehension > 1


gen PerNeut = NumNeutral/NumBlock
gen PerPos = NumPos/NumBlock
gen PerNeg = NumNeg/NumBlock
gen PerAmb = NumAmb/NumBlock

gen PerSolid = NumSolid/NumLinks
gen PerDashed = NumDashed/NumLinks

tab NumBlocks
tab NumNeutral
gen NumNeut = NumNeutral
tab NumPos
tab NumNeg
tab NumAmb

tab AvgValence1
tab AvgValence2
tab Density
tab Diameter
tab TriadicClosure
tab CentralNodeValue

tab NumLinks
tab NumSolid
tab NumDashed
tab Density
tab PerNeut
tab PerPos
tab PerNeg
tab PerAmb
tab PerSolid
tab PerDashed
tab Diameter
tab TriadicClosure

sum NumBlocks
sum NumLinks
sum NumSolid
sum NumDashed
sum TriadicClosure
*number of dashed std exceeds effect size - unless
*std on number of links is very high
*number of solid also very high std. 
*numbers of blocks std is okay. 


drop if NumBlocks < 1
drop if NumLinks < 2

tab Unnamed0

sktest AvgValence1
sktest AvgValence2

sktest Density
sktest Diameter
sktest TriadicClosure
sktest CentralNodeValue


sktest NumBlocks
sktest NumLinks
sktest NumSolid

sktest NumNeutral
sktest NumPos
sktest NumNeg
sktest NumAmb
sktest PerDashed

sktest PerNeut
sktest PerPos
sktest PerNeg
sktest PerAmb
tab PerNeut
tab PerPos
tab PerNeg
tab PerAmb
tab CentralNodeValue

sktest CentralNodeValue
egen float ZCentralNodeValue = std(CentralNodeValue), mean(0) std(1)

gen DensityLog = log(Density)
tab DensityLog
sum DensityLog
sktest DensityLog

gen NumBlocksLog = log(NumBlocks)
sum NumBlocksLog
tab NumBlocksLog
sktest NumBlocksLog

gen NumLinksLog = log(NumLinks)
sktest NumLinksLog

gen NumSolid2= NumSolid+1
gen NumSolidLog = log(NumSolid2)
sktest NumSolidLog
sum NumSolidLog
tab NumSolidLog

gen NumDashed2= NumDashed+1
gen NumDashedLog = log(NumDashed2)
sktest NumDashedLog
sum NumDashedLog
tab NumDashedLog


gen NumNeutral2 = NumNeutral+1
gen NumNeutLog =log(NumNeutral2)
tab NumNeutLog
sktest NumNeutLog
*NumNeutralT2 still skewed

gen NumPosLog = log(NumPos)
sktest NumPosLog

tab NumNeg
gen NumNeg2= NumNeg+2
gen NumNegLog = log(NumNeg2)
sktest NumPosLog

tab NumAmb
gen NumAmb2= NumAmb+1
gen NumAmbLog = log(NumAmb2)
sktest NumAmbLog

tab TriadicClosure
gen TriadicClosure2 = TriadicClosure + 0.001
gen TriadicClosureLog = log(TriadicClosure2)
tab TriadicClosureLog
sktest TriadicClosureLog

tab CentralNodeValue
gen CentralNodeValueLog = log(CentralNodeValue)
sktest CentralNodeValueLog

gen CentralNodeValueX = CentralNodeValue+0.00000000001
gen CentralNodeValueXLog = log(CentralNodeValueX)
sktest CentralNodeValueXLog
sktest CentralNodeValue

gen PerNeut2= PerNeut+0.01
gen PerPos2= PerPos+0.01
gen PerNeg2= PerNeg+0.01
gen PerAmb2= PerAmb+0.01
gen PerSolid2 = PerSolid+0.01
gen PerDashed2 = PerDashed+0.01

gen PerNeutLog = log(PerNeut2)
gen PerPosLog = log(PerPos2)
gen PerNegLog = log(PerNeg2)
gen PerAmbLog = log(PerAmb2)
gen PerSolidLog = log(PerSolid2)
gen PerDashedLog = log(PerDashed2)

sktest PerNeutLog
sktest PerPosLog
sktest PerNegLog
sktest PerAmbLog

***Percentage transformed is more skewed. Stick to the original variables. 
***goes from positive to negative
**CValenceXR goes from negative to positive

tab CNValence
encode CNValence, generate(CNValence1)
recode CNValence1 (1=4) (2=6) (3=7) (4=5) (5=4) (7=1) (6=2) (8=3) (else=4), into(CValenceX)
recode CNValence1 (1=.) (2=6) (3=7) (4=5) (5=4) (7=1) (6=2) (8=3) (else=4), into(CValenceXN)
recode CNValence1 (1=4) (2=6) (3=7) (4=5) (5=.) (7=1) (6=2) (8=3) (else=4), into(CValenceXA)

recode CValenceX (1/3=1) (4=2) (5/7=3), into(CValenceXshort)

recode CNValence1 (1=4) (2=6) (3=7) (4=5) (5=4) (7=1) (6=2) (8=3) (else=.), into(CValenceX2)

recode CValenceX (7=1) (6=2) (5=3) (4=4) (3=5) (2=6) (1=7), into(CValenceXR)
recode CValenceXN (7=1) (6=2) (5=3) (4=4) (3=5) (2=6) (1=7), into(CValenceXNR)
recode CValenceXA (7=1) (6=2) (5=3) (4=4) (3=5) (2=6) (1=7), into(CValenceXAR)

recode CNValence1  (1=3) (2=2) (3=2) (4=2) (5=4) (7=1) (6=1) (8=1) (else=.), into(CValenceCat)
recode CNValence1  (1=8) (2=6) (3=7) (4=5) (5=4) (6=2) (7=1) (8=3) (else=.), into(CValenceCat2)

sktest CValenceXR
tab CValenceXR
tab CValenceCat
tab CValenceXshort
tab PerAmbLog 
tab Country

* drop if ïCountry > 1
* drop if ïCountry < 1

***cam properties
recode Country (1=.) (2=0), into(Germany)
recode Country (1=0) (2=.), into(Canada)

**demographic


tab Age
tab Age Country
tab Age Country, col
sum Age if Country == 1
sum Age if Country == 2

tab Gender Country,col
tab ReligionImp
recode ReligionImp (5=1), into(ReligionR)
tab ReligionR
tab ReligiousEx
recode Gender (3/4=3),into(Gender2)
tab Gender2

tab Arab
tab Black
recode Black (1=2) (0=.), into(BlackR)
tab Chinese
recode Chinese (1=3) (0=.), into(ChineseR)
tab Filipino
recode Filipino (1=4) (0=.), into(FilipinoR)
tab Indigenous
tab Inuit
tab Japanese
tab Jewish
recode  Jewish (1=5) (else=.), into(JewishR)
tab Korean
recode  Korean (1=6) (else=.), into(KoreanR)
tab LatinAmerican
recode  LatinAmerican (1=7) (else=.), into(LatinAmericanR)
tab Metis
recode  Metis (1=8) (else=.), into(MetisR)
tab SouthAsian
recode  SouthAsian (1=9) (else=.), into(SouthAsianR)
tab SoutheasAsian
recode  SoutheasAsian (1=10) (else=.), into(SoutheasAsianR)
tab WestAsian
tab White
recode  White (1=1) (else=.), into(WhiteR)
tab Other
recode  Other (1=11) (else=.), into(OtherR)
tab OtherText

generate Ethnicity = max(BlackR, WhiteR, ChineseR, FilipinoR, JewishR, KoreanR, LatinAmericanR, MetisR, SouthAsianR, WhiteR, OtherR ) if missing(BlackR, WhiteR, ChineseR, FilipinoR, JewishR, KoreanR, LatinAmericanR, MetisR, SouthAsianR, WhiteR, OtherR)
tab Ethnicity
recode Ethnicity (1=1 "White") (2=2 "Black") (3=3 "Asian") (4=3 "Asian") (5=1 "White") (6=1 "Asian") (7=4 "Latin") (8=5 "Indigenous") (9/10=3 "Asian") (11=6 "Other"), into(EthnicCat)
tab EthnicCat
recode EthnicCat (1=1 "White") (else=2 "Non-white"), into(EthnicCat2)
tab EthnicCat2


tab GBirth_mother
tab GBirth_father
recode GBirth_mother (1=0) (2=2), into(GBM)
recode GBirth_father (1=0) (2=3), into(FBM)
gen GParents = GBM+FBM
tab GParents
recode GParents (0=0) (2/3=1) (5=2), into(GParentsX)
recode GParents (0=0) (2=1) (3=2) (5=3), into(GParentsX2)

tab Religion
tab ReligionText

tab PolOrient
recode PolOrient (-77=.)
tab GPolOrient
tab ZPolOrient Country
*Note combined standardized score don't really work

tab Education 
tab PolOrient Education

tab GEducation
gen GEducation2 = GEducation - 4
gen EdTotal = max(Education, GEducation2) if missing(Education, GEducation2)
tab GEducation2

tab EdTotal Country, col
sum EdTotal if Country == 1
sum EdTotal if Country == 2

tab ReligionR Country, col
sum ReligionR if Country == 1
sum ReligionR if Country == 2

*Occupation

tab Occupation1
tab Occupation2
tab Occupation3
tab Occupation4
tab Occupation5
tab Occupation6
tab Occupation7
tab Occupation8
tab Occupation9

recode Occupation1 (1=1) (else=.), into(Occupation1R)
recode Occupation2 (1=2) (else=.), into(Occupation2R)
recode Occupation3 (1=1) (else=.), into(Occupation3R)
recode Occupation4 (1=2) (else=.), into(Occupation4R)
recode Occupation5 (1=3) (else=.), into(Occupation5R)
recode Occupation6 (1=4) (else=.), into(Occupation6R)
recode Occupation7 (1=1) (else=.), into(Occupation7R)
recode Occupation8 (1=1) (else=.), into(Occupation8R)
recode Occupation9 (1=1) (else=.), into(Occupation9R)

gen EmploymentStatus = max(Occupation1R, Occupation2R, Occupation3R, Occupation4R, Occupation5R, Occupation6R, Occupation7R, Occupation8R, Occupation9R) if missing(Occupation1R, Occupation2R, Occupation3R, Occupation4R, Occupation5R, Occupation6R, Occupation7R, Occupation8R, Occupation9R)
tab EmploymentStatus

recode Occupation1 (1=1) (else=.), into(Occupation1RB)
recode Occupation2 (1=1) (else=.), into(Occupation2RB)
recode Occupation3 (1=1) (else=.), into(Occupation3RB)
recode Occupation4 (1=1) (else=.), into(Occupation4RB)
recode Occupation5 (1=2) (else=.), into(Occupation5RB)
recode Occupation6 (1=2) (else=.), into(Occupation6RB)
recode Occupation7 (1=1) (else=.), into(Occupation7RB)
recode Occupation8 (1=1) (else=.), into(Occupation8RB)
recode Occupation9 (1=1) (else=.), into(Occupation9RB)

gen EmploymentStatus2 = max(Occupation1RB, Occupation2RB, Occupation3RB, Occupation4RB, Occupation5RB, Occupation6RB, Occupation7RB, Occupation8RB, Occupation9RB) if missing(Occupation1RB, Occupation2RB, Occupation3RB, Occupation4RB, Occupation5RB, Occupation6RB, Occupation7RB, Occupation8RB, Occupation9RB)
tab EmploymentStatus EmploymentStatus2


*NOTE: I need to know what the additional categories are?
recode GOccupation1 (1=1) (else=.), into(GOccupation1R)
recode GOccupation2 (1=2) (else=.), into(GOccupation2R)
recode GOccupation3 (1=1) (else=.), into(GOccupation3R)
recode GOccupation4 (1=2) (else=.), into(GOccupation4R)
recode GOccupation5 (1=3) (else=.), into(GOccupation5R)
recode GOccupation6 (1=4) (else=.), into(GOccupation6R)
recode GOccupation7 (1=1) (else=.), into(GOccupation7R)
recode GOccupation8 (1=1) (else=.), into(GOccupation8R)
recode GOccupation9 (1=1) (else=.), into(GOccupation9R)

gen GEmploymentStatus = max(GOccupation1R, GOccupation2R, GOccupation3R, GOccupation4R, GOccupation5R, GOccupation6R, GOccupation7R, GOccupation8R, GOccupation9R) if missing(GOccupation1R, GOccupation2R, GOccupation3R, GOccupation4R, GOccupation5R, GOccupation6R, GOccupation7R, GOccupation8R, GOccupation9R)
tab GEmploymentStatus

recode GOccupation1 (1=1) (else=.), into(GOccupation1RB)
recode GOccupation2 (1=1) (else=.), into(GOccupation2RB)
recode GOccupation3 (1=1) (else=.), into(GOccupation3RB)
recode GOccupation4 (1=1) (else=.), into(GOccupation4RB)
recode GOccupation5 (1=1) (else=.), into(GOccupation5RB)
recode GOccupation6 (1=1) (else=.), into(GOccupation6RB)
recode GOccupation7 (1=2) (else=.), into(GOccupation7RB)
recode GOccupation8 (1=2) (else=.), into(GOccupation8RB)
recode GOccupation9 (1=1) (else=.), into(GOccupation9RB)
recode GOccupation10 (1=1) (else=.), into(GOccupation10RB)
recode GOccupation11 (1=1) (else=.), into(GOccupation11RB)
recode GOccupation12 (1=1) (else=.), into(GOccupation12RB)
recode GOccupation13 (1=1) (else=.), into(GOccupation13RB)

gen GEmploymentStatus2 = max(GOccupation1RB, GOccupation2RB, GOccupation3RB, GOccupation4RB, GOccupation5RB, GOccupation6RB, GOccupation7RB, GOccupation8RB, GOccupation9RB, GOccupation10RB, GOccupation11RB, GOccupation12RB, GOccupation13RB) if missing(GOccupation1RB, GOccupation2RB, GOccupation3RB, GOccupation4RB, GOccupation5RB, GOccupation6RB, GOccupation7RB, GOccupation8RB, GOccupation9RB, GOccupation10RB, GOccupation11RB, GOccupation12RB, GOccupation13RB)
tab GEmploymentStatus2


tab GEmploymentStatus GEmploymentStatus2

gen Employ = max(EmploymentStatus2, GEmploymentStatus2) if missing(EmploymentStatus2, GEmploymentStatus2)
tab Employ Country, col

*Profession
tab Profession1
tab Profession2
tab Profession3
tab Profession4
tab Profession5
tab Profession6
tab Profession7
tab Profession8
tab Profession9
tab Profession10
tab Profession11
tab Profession12


*Theism, Nihilism, Humanism
*humanism sucks as a scale

tab Theism1
tab Theism2
pwcorr Theism1 Theism2, star(0.05)sig 

tab Humanism1
tab Humanism2
pwcorr Humanism1 Humanism2, star(0.05)sig 

tab Nihilism1
tab Nihilism2
pwcorr Nihilism1 Nihilism2, star(0.05)sig 

alpha Theism1 Theism2
alpha Humanism1 Humanism2
alpha Nihilism1 Nihilism2

*Theism    0.8086
*Humanism  0.0982   *Fail
*Nihilism  0.8144

factor Theism1 Theism2 Humanism1 Humanism2 Nihilism1 Nihilism2
factor Theism1 Theism2 
factor Humanism1 Humanism2 
factor Nihilism1 Nihilism2


*******
tab BFamily
tab BFriends
tab BOldFriends
tab BPrayMed
tab BExercise
tab BReading
tab BFood
tab BGardening
tab BText


pwcorr BFamily BFriends BOldFriends BPrayMed BExercise BReading BFood BGardening, star(0.05)sig 
factor BFamily BFriends BOldFriends BPrayMed BExercise BReading BFood BGardening
rotate


gen CovidSocial= BFamily+BFriends+BOldFriends
tab CovidSocial
egen float ZCovidSocial = std(CovidSocial), mean(0) std(1)
tab ZCovidSocial

gen CovidMindful= BPrayMed+BExercise+BReading
tab CovidMindful
egen float ZCovidMindful = std(CovidMindful), mean(0) std(1)

*Food loads by itself. as a third factor.  
*Factor 3 has a weak loading with gardening. 
gen CovidHobby= BFood+BFood
tab CovidHobby
egen float ZCovidHobby = std(CovidHobby), mean(0) std(1)

gen CovidActive =BFamily+BFriends+BOldFriends+BPrayMed+BExercise+BReading+BFood+BGardening
egen float ZCovidActive = std(CovidActive), mean(0) std(1)

pwcorr ZCovidSocial ZCovidMindful ZCovidHobby ZCovidActive , star(0.05)sig 


***Covid Causes Consequences
*CImmigrants = #of immigrants
*Cprevention = PreventionCatastrophy - disaster preparedness
*CCollaboration = international collaboration
*CHealthFund = healthcare funding
*CSafety = health and safety pratices
*CTravel = international travel for work and leisure
*CVirus = nature of the virus
*CDependent = international supply change
tab CImmigrants
tab CPrevention
tab CCollaboration
tab CHealthFund
tab CSafety
tab CTravel
tab CVirus
tab CDependent

recode CImmigrants (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1), into(CImmigrantsR)

*Important CDependent is cross loaded. between factor 1 and 2. Argument could be made to delete it. 
*Currently I have included in factor 1 but not 2 because it approaches the 0.5 threshold. 
factor CImmigrants CPrevention CCollaboration CHealthFund CSafety CTravel CVirus CDependent
rotate

factor CHealthFund CSafety CDependent
gen HealthSystem = CHealthFund+CSafety+CDependent
egen float ZHealthSystem = std(HealthSystem), mean(0) std(1)

factor CCollaboration CTravel CVirus CDependent
rotate
gen Praticalities =CCollaboration+CTravel+CVirus
egen float ZPraticalities = std(Praticalities), mean(0) std(1)

factor CImmigrantsR CPrevention
rotate
gen ImmigrantsvsPrep =CImmigrantsR+CPrevention
egen float ZImmigrantsvsPrep = std(ImmigrantsvsPrep), mean(0) std(1)


*Covid Causes and Consequences Ranking
tab RImmigrants
tab RPrevention
tab RCollaboration
tab RHealthFund
tab RSafety
tab RTravel
tab RVirus
tab RDependent

*after the current crisis to what extent do you favour the following?
tab ImmigrationR
tab BusinessTravelR
tab LeisureTravelR
tab TradeR
tab DomnesticP
tab FinancesHealth
tab InternationalC
tab SocialCare
tab Health


factor ImmigrationR BusinessTravelR LeisureTravelR TradeR DomnesticP FinancesHealth InternationalC SocialCare Health
rotate 

factor DomnesticP FinancesHealth InternationalC SocialCare Health
gen StructuralReforms = DomnesticP+FinancesHealth+InternationalC+SocialCare+Health


factor ImmigrationR BusinessTravelR LeisureTravelR TradeR
gen SocailReforms = ImmigrationR+BusinessTravelR+LeisureTravelR+TradeR

egen float ZStructuralReforms = std(StructuralReforms), mean(0) std(1)
egen float ZSocailReforms = std(SocailReforms), mean(0) std(1)

tab ZStructuralReforms
tab ZSocailReforms


**Cognition Affective Scales
tab WithoutReasons
tab Puzzles
tab Complexity
tab ThinkingPressure

alpha WithoutReasons Puzzles Complexity ThinkingPressure
alpha WithoutReasons Puzzles Complexity ThinkingPressure if Country ==1
alpha WithoutReasons Puzzles Complexity ThinkingPressure if Country ==2

factor WithoutReasons Puzzles Complexity ThinkingPressure
rotate 

alpha Puzzles Complexity
alpha Puzzles Complexity if Country ==1
alpha Puzzles Complexity if Country ==2

alpha ThinkingPressure WithoutReasons
alpha ThinkingPressure WithoutReasons if Country ==1
alpha ThinkingPressure WithoutReasons if Country ==2

*Thinking pressure/WReason low alpha

gen Complex = Puzzles+Complexity
gen Simple = ThinkingPressure+WithoutReasons

egen float ZComplex = std(Complex), mean(0) std(1)
egen float ZSimple = std(Simple), mean(0) std(1)

regress ZSimple ZComplex
***Control Scales 


tab Ownboss
tab WorkHard
tab DExternal
tab FatePlans

*Control Scale
*fails alpha
*very week factor loadings
alpha Ownboss WorkHard DExternal FatePlans 
alpha Ownboss WorkHard DExternal FatePlans if Country ==1
alpha Ownboss WorkHard DExternal FatePlans if Country ==2

factor Ownboss WorkHard DExternal FatePlans 
rotate
*very weak reliability

alpha Ownboss WorkHard
alpha DExternal FatePlans
*still weak. 




*Need for affect
tab NFA1 
tab NFA2 
tab NFA3 
tab NFA4 
tab NFA5 
tab NFA6 
tab NFA7 
tab NFA8 
tab NFA9 
tab NFA10

pwcorr NFA1 NFA2 NFA3 NFA4 NFA5 NFA6 NFA7 NFA8 NFA9 NFA10 , star(0.05)sig 
recode NFA6 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1), into(NFA6R)
recode NFA7 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1), into(NFA7R)
recode NFA8 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1), into(NFA8R)
recode NFA9 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1), into(NFA9R)
recode NFA10 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1), into(NFA10R)


pwcorr NFA1 NFA2 NFA3 NFA4 NFA5 NFA6R NFA7R NFA8R NFA9R NFA10R , star(0.05)sig 


alpha NFA1 NFA2 NFA3 NFA4 NFA5 NFA6R NFA7R NFA8R NFA9R NFA10R
alpha NFA1 NFA2 NFA3 NFA4 NFA5 NFA6R NFA7R NFA8R NFA9R NFA10R if Country ==1
alpha NFA1 NFA2 NFA3 NFA4 NFA5 NFA6R NFA7R NFA8R NFA9R NFA10R if Country ==2

* 0.7861

factor NFA1 NFA2 NFA3 NFA4 NFA5 NFA6R NFA7R NFA8R NFA9R NFA10R
rotate

factor NFA1 NFA2 NFA3 NFA4 NFA5
factor NFA6R NFA7R NFA8R NFA9R NFA10R

rotate

gen NFAScale= NFA1+NFA2+NFA3+NFA4+NFA5+NFA6R+NFA7R+NFA8R+NFA9R+NFA10R
egen float ZNFAScale = std(NFAScale), mean(0) std(1)

*PerceivedCoronaVirusThreat
tab RiskGroup
label define RiskGroup 1 "At Risk" 2 "No Risk" 3 "Uncertain"
label list RiskGroup

tab PCTQ1
tab PCTQ2
tab PCTQ3
alpha PCTQ1 PCTQ2 PCTQ3 if Country ==1
alpha PCTQ1 PCTQ2 PCTQ3 if Country ==2

gen PCTScale = PCTQ1+PCTQ2+PCTQ3 - 3 
egen float ZPCTScale = std(PCTScale), mean(0) std(1)
sktest ZPCTScale
gen ZPCTScaleLog = log(ZPCTScale)
sktest ZPCTScaleLog

tab ZPCTScale Country, col
sum ZPCTScale if Country == 1
sum ZPCTScale if Country == 2

*good

*
tab RestrictionS1
tab RestrictionS2
alpha RestrictionS1 RestrictionS2 if Country ==1
alpha RestrictionS1 RestrictionS2 if Country ==2
gen RestrictionS = RestrictionS1+RestrictionS2
egen float ZRestrictionS = std(RestrictionS), mean(0) std(1)

*weak

tab PunishmentS1
tab PunishmentS2
alpha PunishmentS1 PunishmentS2 if Country ==1
alpha PunishmentS1 PunishmentS2 if Country ==2

gen Punish = PunishmentS1+PunishmentS2
egen float ZPunish = std(Punish), mean(0) std(1)

*good

tab ReactanceS1
tab ReactanceS2
alpha ReactanceS1 ReactanceS2 if Country == 1
alpha ReactanceS1 ReactanceS2 if Country == 2

gen React = ReactanceS1+ReactanceS2
egen float ZReact = std(React), mean(0) std(1)

*great

tab ResearchS1
tab ResearchS2
alpha ResearchS1 ResearchS2 if Country == 1
alpha ResearchS1 ResearchS2 if Country == 2

gen Research = ResearchS1+ResearchS2
egen float ZResearch = std(Research), mean(0) std(1)

*weak

tab StimulusS1
tab StimulusS2
alpha StimulusS1 StimulusS2 if Country == 1
alpha StimulusS1 StimulusS2 if Country == 2

gen Stimulus= StimulusS1+StimulusS2
egen float ZStimulus = std(Stimulus), mean(0) std(1)

*good

tab InformationalCS1
tab InformationalCS2
alpha InformationalCS1 InformationalCS2 if Country == 1
alpha InformationalCS1 InformationalCS2 if Country == 2

gen Information= InformationalCS1+InformationalCS2
egen float ZInformation = std(Information), mean(0) std(1)

*good

tab FinancialS1
tab FinancialS2
alpha FinancialS1 FinancialS2 if Country == 1
alpha FinancialS1 FinancialS2 if Country == 2

gen Financial = FinancialS1+FinancialS2
egen float ZFinancial = std(Financial), mean(0) std(1)

*good

tab ResourceS1
tab ResourceS2
alpha ResourceS1 ResourceS2 if Country ==1
alpha ResourceS1 ResourceS2 if Country ==2

gen Resources = ResourceS1+ResourceS2
egen float ZResources = std(Resources), mean(0) std(1)

*good

tab PsychS1
tab PsychS1
alpha PsychS1 PsychS2 if Country ==1
alpha PsychS1 PsychS2 if Country ==2

gen Psych =PsychS1+PsychS2
egen float ZPsych = std(Psych), mean(0) std(1)

*good

*not point in running alpha on symptoms
tab SymptomsS1
tab SymptomsS2
tab SymptomsS3
alpha  SymptomsS1 SymptomsS2 SymptomsS3 if Country ==1
alpha  SymptomsS1 SymptomsS2 SymptomsS3 if Country ==2

gen SymptomsS =SymptomsS1+SymptomsS2+SymptomsS3
egen float ZSymptomsS = std(SymptomsS), mean(0) std(1)


*no point in running alpha on proximity
tab ProximityS1
tab ProximityS2
alpha ProximityS1 ProximityS2 if Country ==1
alpha ProximityS1 ProximityS2 if Country ==2

gen ProximityS = ProximityS1+ProximityS2
egen float ZProximityS = std(ProximityS), mean(0) std(1)

tab NewsS1
tab NewsS2
alpha NewsS1 NewsS2 if Country ==1
alpha NewsS1 NewsS2 if Country ==2

*good
gen News =NewsS1+NewsS2
egen float ZNews = std(News), mean(0) std(1)



**Need for Structure Scale
tab NFS1
tab	NFS2	
tab NFS3	
tab NFS4	
tab NFS5	
tab NFS6
recode NFS6 (1=7) (2=6) (3=5) (4=4) (5=3) (6=2) (7=1), into(NFS6R)
pwcorr NFS1 NFS2 NFS3 NFS4 NFS5 NFS6R, star(0.05)sig 

*good alpha 0.82
alpha NFS1 NFS2 NFS3 NFS4 NFS5 NFS6R if Country == 1
alpha NFS1 NFS2 NFS3 NFS4 NFS5 NFS6R if Country == 2

factor NFS1 NFS2 NFS3 NFS4 NFS5 NFS6R
rotate 

gen NFSScale = NFS1+NFS2+NFS3+NFS4+NFS5+NFS6R
egen float ZNFSScale = std(NFSScale), mean(0) std(1)

tab Comments


pwcorr ZNFSScale ZNFAScale ZPCTScale, star(0.05)sig 

regress ZNFSScale ZNFAScale, robust
regress ZNFSScale ZPCTScale, robust


*Three main scales
*****Need for structure scale ZNFSScale
*****Need for affect scale ZNFAScale
*****preceived threat of corona scale ZPCTScale

corr ZNFAScale Education

****Test Variables 
*ZCovidSocial
*ZCovidMindful
*ZCovidHobby
*ZCovidActive = all three measures combined
*above are all activity measures
pwcorr ZNFSScale ZCovidSocial ZCovidMindful ZCovidHobby ZCovidActive, star(0.05)sig 
pwcorr ZNFAScale ZCovidSocial ZCovidMindful ZCovidHobby ZCovidActive, star(0.05)sig 
pwcorr ZPCTScale ZCovidSocial ZCovidMindful ZCovidHobby ZCovidActive, star(0.05)sig 
pwcorr ZCovidSocial ZCovidMindful ZCovidHobby ZCovidActive, star(0.05)sig 
*significant correlation NFS and social behaviour during covid****
*significant correlation NFA and hobby covid****


****
pwcorr ZNFSScale ZHealthSystem ZPraticalities ZImmigrantsvsPrep, star(0.05)sig 
pwcorr ZNFAScale ZHealthSystem ZPraticalities ZImmigrantsvsPrep, star(0.05)sig 
pwcorr ZPCTScale ZHealthSystem ZPraticalities ZImmigrantsvsPrep, star(0.05)sig 
pwcorr ZHealthSystem ZPraticalities ZImmigrantsvsPrep, star(0.05)sig 

tab CImmigrants
tab RImmigrants
tab ImmigrationR

pwcorr ZNFSScale CImmigrants RImmigrants ImmigrationR, star(0.05)sig 
pwcorr ZNFAScale CImmigrants RImmigrants ImmigrationR, star(0.05)sig 
pwcorr ZPCTScale CImmigrants RImmigrants ImmigrationR, star(0.05)sig 
*signifiacnt correlations NFA CImmigrants ImmigrationR
*signifiacnt correlations PCT and  RImmigrants - ranking immmigrants as the cause

tab EthnicCat2
regress ZNFSScale CImmigrants  if EthnicCat2 == 1
regress ZNFSScale RImmigrants  if EthnicCat2 == 1
regress ZNFSScale ImmigrationR if EthnicCat2 == 1

regress ZNFSScale CImmigrants  if EthnicCat2 == 2
regress ZNFSScale RImmigrants  if EthnicCat2 == 2
regress ZNFSScale ImmigrationR if EthnicCat2 == 2


regress ZNFAScale CImmigrants  if EthnicCat2 == 1
regress ZNFAScale RImmigrants  if EthnicCat2 == 1
regress ZNFAScale ImmigrationR if EthnicCat2 == 1

regress ZNFAScale CImmigrants  if EthnicCat2 == 2
regress ZNFAScale RImmigrants  if EthnicCat2 == 2
regress ZNFAScale ImmigrationR if EthnicCat2 == 2


regress ZPCTScale CImmigrants  if EthnicCat2 == 1
regress ZPCTScale RImmigrants  if EthnicCat2 == 1
regress ZPCTScale ImmigrationR if EthnicCat2 == 1

regress ZPCTScale CImmigrants  if EthnicCat2 == 2
regress ZPCTScale RImmigrants  if EthnicCat2 == 2
regress ZPCTScale ImmigrationR if EthnicCat2 == 2


*******

pwcorr ZNFSScale ZStructuralReforms ZSocailReforms , star(0.05)sig 
pwcorr ZNFAScale ZStructuralReforms ZSocailReforms , star(0.05)sig 
pwcorr ZPCTScale ZStructuralReforms ZSocailReforms , star(0.05)sig 
*signifiacnt correlations NFA ZStructuralReforms
*signifiacnt correlations PCT ZStructuralReforms

pwcorr ZNFSScale ZComplex ZSimple , star(0.05)sig 
pwcorr ZNFAScale ZComplex ZSimple , star(0.05)sig 
pwcorr ZPCTScale ZComplex ZSimple , star(0.05)sig 

****
pwcorr ZNFSScale ZPunish ZReact ZResearch ZStimulus ZInformation ZFinancial ZResources ZPsych ZNews, star(0.05)sig 
*signifiacnt correlations PCT Finanical, News

pwcorr ZNFAScale ZPunish ZReact ZResearch ZStimulus ZInformation ZFinancial ZResources ZPsych ZNews, star(0.05)sig 
*signifiacnt correlations NFA Research, Stimulus, Resources, News

pwcorr ZPCTScale ZPunish ZReact ZResearch ZStimulus ZInformation ZFinancial ZResources ZPsych ZNews, star(0.05)sig 
*signifiacnt correlations PCT Punish, research, Stimulus, Finanical, Resources, Psych, zNews


***
***
egen float ZDensityLog = std(DensityLog), mean(0) std(1)
egen float ZTriadicClosureLog = std(TriadicClosureLog), mean(0) std(1)
egen float ZNumLinksLog = std(NumLinksLog), mean(0) std(1)
egen float ZNumBlocksLog = std(NumBlocksLog), mean(0) std(1)
egen float ZNumSolidLog = std(NumSolidLog), mean(0) std(1)
egen float ZNumDashedLog = std(NumDashedLog), mean(0) std(1)
egen float ZDiameter = std(Diameter), mean(0) std(1)

egen float ZAvgValence1 = std(AvgValence1), mean(0) std(1)
egen float ZAvgValence2 = std(AvgValence2), mean(0) std(1)
egen float ZPerNeut = std(PerNeut), mean(0) std(1)
egen float ZPerPos = std(PerPos), mean(0) std(1)
egen float ZPerNeg = std(PerNeg), mean(0) std(1)
egen float ZPerAmb = std(PerAmb), mean(0) std(1)
egen float ZCValenceXR = std(CValenceXR), mean(0) std(1)

regress c.ZDensityLog c.ZNumBlocksLog, cluster(Country)
regress c.ZDensityLog c.ZNumBlocksLog if Country == 1, robust
regress c.ZDensityLog c.ZNumBlocksLog if Country == 2, robust
