*network Propertoes
*Preceived threat of COVID
tab Density
tab AvgValence1
tab Diameter
tab TriadicClosure

tab NumBlocks
tab NumLinks
tab NumSolid
tab NumDashed
tab PerNeut
tab PerPos
tab PerNeg
tab PerAmb
tab NumNeut
tab NumPos
tab NumNeg
tab NumAmb

tab CentralNodeValue
tab ZDensityLog
tab ZTriadicClosureLog
tab ZNumLinksLog
tab ZNumBlocksLog
tab ZNumSolidLog
tab ZNumDashedLog
tab ZDiameter

tab ZAvgValence1 
tab ZPerNeut 
tab ZPerPos 
tab ZPerNeg 
tab ZPerAmb 
tab ZCValenceXR 

sum ZCentralNodeValue if Country ==1
sum ZDensityLog if Country ==1
sum ZTriadicClosureLog if Country ==1
sum ZNumLinksLog if Country ==1
sum ZNumBlocksLog if Country ==1
sum ZNumSolidLog if Country ==1
sum ZNumDashedLog if Country ==1
sum ZDiameter if Country ==1

sum ZCentralNodeValue if Country ==2
sum ZDensityLog if Country ==2
sum ZTriadicClosureLog if Country ==2
sum ZNumLinksLog if Country ==2
sum ZNumBlocksLog if Country ==2
sum ZNumSolidLog if Country ==2
sum ZNumDashedLog if Country ==2
sum ZDiameter if Country ==2

sum DensityLog if Country ==1
sum TriadicClosureLog if Country ==1
sum NumLinksLog if Country ==1
sum NumBlocksLog if Country ==1
sum NumSolidLog if Country ==1
sum NumDashedLog if Country ==1
sum Diameter if Country ==1

sum DensityLog if Country ==2
sum TriadicClosureLog if Country ==2
sum NumLinksLog if Country ==2
sum NumBlocksLog if Country ==2
sum NumSolidLog if Country ==2
sum NumDashedLog if Country ==2
sum Diameter if Country ==2

sum ZAvgValence1 if Country ==1
sum ZPerNeut if Country ==1
sum ZPerPos if Country ==1
sum ZPerNeg if Country ==1
sum ZPerAmb if Country ==1
sum ZCValenceXR if Country ==1

sum ZAvgValence1 if Country ==2
sum ZPerNeut if Country ==2
sum ZPerPos if Country ==2
sum ZPerNeg if Country ==2
sum ZPerAmb if Country ==2
sum ZCValenceXR if Country ==2

sum AvgValence1 if Country ==1
sum PerNeut if Country ==1
sum PerPos if Country ==1
sum PerNeg if Country ==1
sum PerAmb if Country ==1
sum ZCValenceXR if Country ==1

sum AvgValence1 if Country ==2
sum PerNeut if Country ==2
sum PerPos if Country ==2
sum PerNeg if Country ==2
sum PerAmb if Country ==2
sum ZCValenceXR if Country ==2

glm ZPCTScale i.Country, robust
glm ZPCTScale i.Country, cluster(Country)

pwcorr ZCentralNodeValue ZDensityLog ZNumBlocksLog ZNumLinksLog ZNumDashedLog ZNumSolidLog ZTriadicClosureLog ZDiameter, star(0.05)sig
pwcorr ZCentralNodeValue ZDensityLog ZNumBlocksLog ZNumLinksLog ZNumDashedLog ZNumSolidLog ZTriadicClosureLog ZDiameter, star(0.05)sig, if Country == 1
pwcorr ZCentralNodeValue ZDensityLog ZNumBlocksLog ZNumLinksLog ZNumDashedLog ZNumSolidLog ZTriadicClosureLog ZDiameter, star(0.05)sig, if Country == 2


tab ZDensity Country
sum ZDensity if Country ==1 
sum ZDensity if Country ==2

tab ZDensityLog Country
sum ZDensityLog if Country ==1 
sum ZDensityLog if Country ==2

tab ZNumBlocks Country
sum ZNumBlocks if Country ==1 
sum ZNumBlocks if Country ==2

tab ZNumLinksLog Country
sum ZNumLinksLog if Country ==1 
sum ZNumLinksLog if Country ==2

tab ZNumDashedLog Country
sum ZNumDashedLog if Country ==1 
sum ZNumDashedLog if Country ==2


glm ZDensityLog ZNumBlocksLog i.Country, cluster(Country)
glm ZDensityLog ZNumBlocksLog if Country == 1, robust
glm ZDensityLog ZNumBlocksLog if Country == 2, robust

glm ZDensityLog ZNumLinksLog i.Country, cluster(Country)
glm ZDensityLog ZNumLinksLog if Country == 1, robust
glm ZDensityLog ZNumLinksLog if Country == 2, robust

glm ZNumBlocksLog ZNumLinksLog i.Country, cluster(Country)
glm ZNumBlocksLog ZNumLinksLog if Country == 1, robust
glm ZNumBlocksLog ZNumLinksLog if Country == 2, robust


glm ZDensityLog ZTriadicClosureLog i.Country, cluster(Country)
glm ZDensityLog ZTriadicClosureLog if Country == 1, robust
glm ZDensityLog ZTriadicClosureLog if Country == 2, robust

glm ZDensityLog ZDiameter i.Country, cluster(Country)
glm ZDensityLog ZDiameter if Country == 1, robust
glm ZDensityLog ZDiameter if Country == 2, robust

glm ZDensityLog ZNumDashedLog i.Country, cluster(Country)
glm ZDensityLog ZNumDashedLog if Country == 1, robust
glm ZDensityLog ZNumDashedLog if Country == 2, robust

glm ZNumSolidLog ZNumDashedLog i.Country, cluster(Country)
glm ZNumSolidLog ZNumDashedLog if Country == 1, robust
glm ZNumSolidLog ZNumDashedLog if Country == 2, robust

pwcorr ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb ZCValenceXR, star(0.05)sig
pwcorr ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb ZCValenceXR, star(0.05)sig, if Country == 1
pwcorr ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb ZCValenceXR, star(0.05)sig, if Country == 2



pwcorr ZDensityLog ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb CValenceXR, star(0.05)sig
pwcorr ZDensityLog ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut PerAmb CValenceXR, star(0.05)sig, if Country == 1
pwcorr ZDensityLog ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb CValenceXR, star(0.05)sig, if Country == 2

pwcorr ZCentralNodeValue ZDensityLog ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb ZCValenceXR, star(0.05)sig
pwcorr ZCentralNodeValue ZDensityLog ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut PerAmb ZCValenceXR, star(0.05)sig, if Country == 1
pwcorr ZCentralNodeValue ZDensityLog ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb ZCValenceXR, star(0.05)sig, if Country == 2

pwcorr ZCentralNodeValue ZDensityLog ZNumBlocksLog ZNumLinksLog ZNumSolidLog ZTriadicClosureLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb ZCValenceXR, star(0.05)sig
pwcorr ZCentralNodeValue ZDensityLog ZNumBlocksLog ZNumLinksLog ZNumSolidLog ZTriadicClosureLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut PerAmb ZCValenceXR, star(0.05)sig, if Country == 1
pwcorr ZCentralNodeValue ZDensityLog ZNumBlocksLog ZNumLinksLog ZNumSolidLog ZTriadicClosureLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb ZCValenceXR, star(0.05)sig, if Country == 2
 
tab ZPerPos Country
sum ZPerPos if Country ==1 
sum ZPerPos if Country ==2

tab ZPerNeg Country
sum ZPerNeg if Country ==1 
sum ZPerNeg if Country ==2

tab ZPerNeut Country
sum ZPerNeut if Country ==1 
sum ZPerNeut if Country ==2

tab ZPerAmb Country
sum ZPerAmb if Country ==1 
sum ZPerAmb if Country ==2


regress ZAvgValence1 ZAvgValence2 i.Country, cluster(Country)
regress ZAvgValence1 ZAvgValence2 if Country == 1, robust
regress ZAvgValence1 ZAvgValence2 if Country == 2, robust

regress ZAvgValence1 ZPerPos i.Country, cluster(Country)
regress ZAvgValence1 ZPerPos if Country == 1, robust
regress ZAvgValence1 ZPerPos if Country == 2, robust

regress ZAvgValence1 ZPerNeg i.Country, cluster(Country)
regress ZAvgValence1 ZPerNeg if Country == 1, robust
regress ZAvgValence1 ZPerNeg if Country == 2, robust

glm ZPCTScale c.ZPerPos i.Country, robust
glm ZPCTScale c.ZPerPos i.Country, cluster(Country)

glm ZPCTScale c.ZPerNeg i.Country, robust
glm ZPCTScale c.ZPerNeg i.Country, cluster(Country)

glm ZPCTScale c.ZPerNeut i.Country, robust
glm ZPCTScale c.ZPerNeut i.Country, cluster(Country)

glm ZPCTScale c.ZPerAmb i.Country, robust
glm ZPCTScale c.ZPerAmb i.Country, cluster(Country)


glm ZPCTScale c.ZPerPos c.ZPerNeg c.ZPerNeut c.ZPerAmb i.Country, robust
glm ZPCTScale c.ZPerPos c.ZPerNeg c.ZPerNeut c.ZPerAmb i.Country, cluster(Country)
glm ZPCTScale c.ZPerPos c.ZPerNeg c.ZPerNeut c.ZPerAmb i.Country, cluster(Country)

glm ZPCTScale c.ZPerPos c.ZPerNeg c.ZPerAmb i.Country, robust
glm ZPCTScale c.ZPerPos c.ZPerNeg c.ZPerAmb i.Country, cluster(Country)

glm ZPCTScale c.ZPerNeg c.ZPerAmb i.Country, robust
glm ZPCTScale c.ZPerNeg c.ZPerAmb i.Country, cluster(Country)
glm ZPCTScale c.ZPerPos c.ZPerAmb i.Country, robust
glm ZPCTScale c.ZPerPos c.ZPerAmb i.Country, cluster(Country)

glm ZPCTScale c.ZAvgValence1 c.ZPerPos i.Country, robust
glm ZPCTScale c.ZAvgValence1 c.ZPerPos i.Country, cluster(Country)

glm ZPCTScale c.ZPerPos c.ZAvgValence1 i.Country, robust
glm ZPCTScale c.ZPerPos c.ZAvgValence1 i.Country, cluster(Country)

glm ZPCTScale c.ZAvgValence1 i.Country, robust
glm ZPCTScale c.ZAvgValence1 i.Country, cluster(Country)


glm ZPCTScale c.ZAvgValence1 c.ZPerPos c.ZPerNeg c.ZPerNeut c.ZPerAmb i.Country, robust
glm ZPCTScale c.ZAvgValence1 c.ZPerPos c.ZPerNeg c.ZPerNeut c.ZPerAmb i.Country, cluster(Country)

glm ZPCTScale c.ZAvgValence1 c.ZPerNeg c.ZPerNeut c.ZPerAmb i.Country, robust
glm ZPCTScale c.ZAvgValence1 c.ZPerNeg c.ZPerNeut c.ZPerAmb i.Country, cluster(Country)

glm ZPCTScale c.ZAvgValence1 c.ZPerNeg c.ZPerNeut i.Country, robust
glm ZPCTScale c.ZAvgValence1 c.ZPerNeg c.ZPerNeut i.Country, cluster(Country)

glm ZPCTScale c.ZAvgValence1 c.ZPerNeg  i.Country, robust
glm ZPCTScale c.ZAvgValence1 c.ZPerNeg  i.Country, cluster(Country)

glm ZPCTScale c.ZAvgValence1 i.Country, robust
glm ZPCTScale c.ZAvgValence1 i.Country, cluster(Country)




glm ZAvgValence1 ZDensityLog, robust
glm ZAvgValence1 ZDensityLog i.Country, cluster(Country)

glm ZAvgValence1 ZDensityLog, robust
glm ZAvgValence1 ZDensityLog i.Country, cluster(Country)




***stepwise all network plus controls
glm ZPCTScale c.ZDensityLog c.CentralNodeValue ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut  ZPerAmb  ZCValenceX, cluster(Country)

glm ZPCTScale c.ZDensityLog c.ZCentralNodeValue ZAvgValence1 ZPerNeg , cluster(Country)


*****ALL
*No Controls
glm ZPCTScale c.ZDensityLog c.CentralNodeValue ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut  ZPerAmb  ZCValenceX i.Country, cluster(Country)

glm ZPCTScale ZAvgValence1 c.CentralNodeValue c.ZDensityLog ZPerNeg i.Country, cluster(Country)


*Controls
glm ZPCTScale c.CentralNodeValue c.ZDensityLog c.ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut  ZPerAmb ZCValenceX c.Age c.EdTotal i.Gender i.Country, cluster(Country)


glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZPerNeg c.Age c.EdTotal i.Gender i.Country, cluster(Country)


*Extra Controls
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut ZPerAmb ZCValenceXR c.Age c.EdTotal i.Gender i.Country c.ZNFAScale c.ZNFSScale, cluster(Country)

glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZAvgValence1 c.Age c.EdTotal i.Gender i.Country c.ZNFAScale c.ZNFSScale, cluster(Country)



**Canada
*No Controls
glm ZPCTScale c. CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut  ZPerAmb CValenceXR if Country == 1, robust


glm ZPCTScale ZAvgValence1 c.CentralNodeValue ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg if Country == 1, robust

*Controls
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut  ZPerAmb CValenceXR c.Age c.EdTotal i.Gender if Country == 1, robust

glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg ZTriadicClosureLog c.Age c.EdTotal i.Gender i.Gender if Country == 1, robust

**Extra Controls
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut  ZPerAmb CValenceXR c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 1, robust

glm ZPCTScale ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg ZPerPos ZTriadicClosureLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 1, robust

*glm ZPCTScale TriadicClosureLog NumLinksLog NumBlocksLog Diameter AvgValence1 c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 1, robust


**Germany
*No Contronls
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut  ZPerAmb CValenceXR if Country == 2, robust

glm ZPCTScale c.ZDensityLog ZNumBlocksLog if Country == 2, robust

*Controls
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut  ZPerAmb ZCValenceX c.Age c.EdTotal i.Gender if Country == 2, robust


glm ZPCTScale c.ZDensityLog ZNumBlocksLog c.Age c.EdTotal i.Gender if Country == 2, robust


**Extra Controls
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZNumLinksLog ZNumSolidLog ZNumDashedLog ZNumBlocksLog ZDiameter ZAvgValence1 ZPerPos ZPerNeg ZPerNeut  ZPerAmb CValenceXR c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 2, robust


glm ZPCTScale c.ZDensityLog ZNumBlocksLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 2, robust



***Stepwise outcomes
*All
glm ZPCTScale c.ZDensityLog c.CentralNodeValue ZAvgValence1 ZPerNeg , cluster(Country)
glm ZPCTScale ZAvgValence1 c.CentralNodeValue c.ZDensityLog ZPerNeg i.Country, cluster(Country)
glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZPerNeg c.Age c.EdTotal i.Gender i.Country, cluster(Country)
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZAvgValence1 c.Age c.EdTotal i.Gender i.Country c.ZNFAScale c.ZNFSScale, cluster(Country)


**Canada
glm ZPCTScale ZAvgValence1 c.CentralNodeValue ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg if Country == 1, robust
glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg ZTriadicClosureLog c.Age c.EdTotal i.Gender i.Gender if Country == 1, robust
glm ZPCTScale ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg ZPerPos ZTriadicClosureLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 1, robust

***German
glm ZPCTScale c.ZDensityLog ZNumBlocksLog if Country == 2, robust
glm ZPCTScale c.ZDensityLog ZNumBlocksLog c.Age c.EdTotal i.Gender if Country == 2, robust
glm ZPCTScale c.ZDensityLog ZNumBlocksLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 2, robust



**alternative
glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 1, robust






*****Time Controls ------ don't matter after you add demographic covariates. 
tab DataCollection
glm ZPCTScale i.DataCollection, robust
glm ZPCTScale i.DataCollection, cluster(Country)
glm ZPCTScale i.DataCollection if Country == 1, robust
glm ZPCTScale i.DataCollection if Country == 2, robust




***Stepwise outcomes
*All
glm ZPCTScale c.ZDensityLog c.CentralNodeValue ZAvgValence1 ZPerNeg i.DataCollection, cluster(Country)
glm ZPCTScale ZAvgValence1 c.CentralNodeValue c.ZDensityLog ZPerNeg i.Country i.DataCollection, cluster(Country)
glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZPerNeg c.Age c.EdTotal i.Gender i.Country i.DataCollection, cluster(Country)
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZAvgValence1 c.Age c.EdTotal i.Gender i.Country c.ZNFAScale c.ZNFSScale i.DataCollection, cluster(Country)


**Canada
glm ZPCTScale ZAvgValence1 c.CentralNodeValue ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg  i.DataCollection if Country == 1, robust
glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg ZTriadicClosureLog c.Age c.EdTotal i.Gender i.DataCollection if Country == 1, robust
glm ZPCTScale ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg ZPerPos ZTriadicClosureLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale i.DataCollection if Country == 1, robust

***German
glm ZPCTScale c.ZDensityLog ZNumBlocksLog i.DataCollection if Country == 2, robust
glm ZPCTScale c.ZDensityLog ZNumBlocksLog c.Age c.EdTotal i.Gender i.DataCollection if Country == 2, robust
glm ZPCTScale c.ZDensityLog ZNumBlocksLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale i.DataCollection if Country == 2, robust



**alternative
glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale i.DataCollection if Country == 1, robust










***Complexity added as a covariate
***Stepwise outcomes
*All
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZAvgValence1 c.Age c.EdTotal i.Gender i.Country c.ZNFAScale c.ZNFSScale, cluster(Country)
glm ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZAvgValence1 c.Age c.EdTotal i.Gender i.Country c.ZNFAScale c.ZNFSScale c.ZComplex c.ZSimple, cluster(Country)

regress ZPCTScale c.CentralNodeValue c.ZDensityLog ZTriadicClosureLog ZAvgValence1 c.Age c.EdTotal i.Gender i.Country c.ZNFAScale c.ZNFSScale c.ZComplex c.ZSimple, cluster(Country)

**Canada
glm ZPCTScale ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg ZPerPos ZTriadicClosureLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 1, robust

glm ZPCTScale ZDiameter ZNumBlocksLog ZNumLinksLog ZPerNeg ZPerPos ZTriadicClosureLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale c.ZComplex c.ZSimple if Country == 1, robust

***German
glm ZPCTScale c.ZDensityLog ZNumBlocksLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 2, robust
glm ZPCTScale c.ZDensityLog ZNumBlocksLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale c.ZComplex c.ZSimple if Country == 2, robust



**alternative
glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale if Country == 1, robust

glm ZPCTScale ZAvgValence1 ZDiameter ZNumBlocksLog ZNumLinksLog ZTriadicClosureLog c.Age c.EdTotal i.Gender c.ZNFAScale c.ZNFSScale c.ZComplex c.ZSimple if Country == 1, robust







****Supplementary materials
glm c.ZPCTScale  c.ZPerPos##i.Country, cluster(Country)
glm c.ZPCTScale  c.ZAvgValence1##i.Country, cluster(Country)

glm c.ZPCTScale  c.ZPerAmb##i.Country, cluster(Country)
glm c.ZPCTScale  c.ZCValenceXR##i.Country, cluster(Country)
glm c.ZPCTScale  c.ZPerNeg##i.Country, cluster(Country)
glm c.ZPCTScale  c.ZPerNeut##i.Country, cluster(Country)


glm c.ZDensityLog  ZNumBlocksLog if Country == 1, robust
glm c.ZDensityLog  ZNumLinksLog if Country == 1, robust


glm c.ZDensityLog  ZNumBlocksLog if Country == 2, robust
glm c.ZDensityLog  ZNumLinksLog if Country == 2, robust

sktest ZAvgValence1 if Country == 1
sktest ZAvgValence1 if Country == 2

sktest ZPerPos if Country == 1
sktest ZPerPos if Country == 2

sktest ZPerNeg if Country == 1
sktest ZPerNeg if Country == 2

sktest ZPerNeut if Country == 1
sktest ZPerNeut if Country == 2

sktest ZPerAmb if Country == 1
sktest ZPerAmb if Country == 2

sktest ZCValenceXR if Country == 1
sktest ZCValenceXR if Country == 2


glm c.ZPerPos  c.ZDensityLog##c.ZCValenceXR, cluster(Country)
glm c.ZPerPos  c.ZDensityLog##c.ZCValenceXR if Country == 1, robust
glm c.ZPerPos  c.ZDensityLog##c.ZCValenceXR if Country == 2, robust


glm c.ZPerNeg  c.ZDensityLog##c.ZCValenceXR, cluster(Country)
glm c.ZPerNeg  c.ZDensityLog##c.ZCValenceXR if Country == 1, robust
glm c.ZPerNeg  c.ZDensityLog##c.ZCValenceXR if Country == 2, robust


glm c.ZPCTScale c.ZPerPos i.Country , cluster(Country)
glm c.ZPCTScale c.ZPerPos   if Country == 1, robust
glm c.ZPCTScale c.ZPerPos   if Country == 2, robust


glm c.ZPCTScale c.ZPerNeg  i.Country , cluster(Country)
glm c.ZPCTScale c.ZPerNeg   if Country == 1, robust
glm c.ZPCTScale c.ZPerNeg   if Country == 2, robust

glm c.ZAvgValence1  c.ZCValenceXR i.Country, cluster(Country)
glm c.ZAvgValence1  c.ZCValenceXR if Country == 1, robust
glm c.ZAvgValence1  c.ZCValenceXR if Country == 2, robust
