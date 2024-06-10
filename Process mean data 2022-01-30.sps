* Encoding: UTF-8.
* Process Model subprogram
* by Jamie DeCoster

* This program graphs LPA group means with different charts
* for different numbers of profiles, and separate lines in each
* chart for each profile.

string groupLabel (a15).
compute groupLabel = concatenate(ltrim(str(GroupNum, f8)), " (n = ", ltrm(str(N, f8)), ")").
execute.

SORT CASES  BY Groups.
SPLIT FILE LAYERED BY Groups.

GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=VarName MEAN(VarMean)[name="MEAN_VarMean"] GroupLabel 
    MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: VarName=col(source(s), name("VarName"), unit.category())
  DATA: MEAN_VarMean=col(source(s), name("MEAN_VarMean"))
  DATA: GroupLabel=col(source(s), name("GroupLabel"), unit.category())
  GUIDE: axis(dim(1), label("VarName"))
  GUIDE: axis(dim(2), label("Mean VarMean"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("GroupLabel"))
  GUIDE: text.title(label("Multiple Line Mean of VarMean by VarName by GroupLabel"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: line(position(VarName*MEAN_VarMean), color.interior(GroupLabel), missing.wings())
END GPL.

split file off.

********
* Version History
********.
* 2022-01-07 Created
* 2022-01-30 Added Ns to Group labels
