* Encoding: UTF-8.
* Use Mplus to run a Latent Profile or Class Analysis from within SPSS
* By Jamie DeCoster

* This program allows users to identify a Latent Profile or Class analysis that
* they want to test on an SPSS data set. The program then
* converts the active data set to Mplus format, writes a program
* that will perform the path analysis in Mplus, then loads the important
* parts of the Mplus output into the SPSS output window.

* The only difference between an LPA and an LCA is whether you identify
* your variables as continuous (LPA) or categorical (LCA).

**** Usage: MplusLPA(inpfile, modellabel, runModel, viewOutput, suppressSPSS,
variableList, groups, starts, stiterations, optseed, svalues,
estimator, useobservations, 
categorical, censored, count, nominal, idvariable,
modelDatasetName, meanDatasetName, datasetLabels, 
savedata, saveCprob, processors, waittime)
**** "inpfile" is a string identifying the directory and filename of
* Mplus input file to be created by the program. This filename must end with
* .inp . The data file will automatically be saved to the same directory. This
* argument is required.
**** "modellabel" is a string that indicates what label should be added to the output at the
* top of your model. If this is not specified, the label defaults to "MplusLPA"
**** "runModel" is a boolean argument indicating whether or not you want the 
* program to actually run the program it creates based on the model you define. 
* You may choose to not run the model when you want to use the program to 
* load an existing output file into SPSS. However, when doing this, you should 
* first load the corresponding data set so that the function can determine the 
* appropriate translation between the Mplus variable names and SPSS variable 
* names. By default, the model is run.
**** "viewOutput" is a boolean argument indicating whether or not you want the 
* program to read the created output into SPSS. You may choose not to read 
* the output into SPSS when you know that it will take a very long time to run and
* you do not want to tie up SPSS while you are waiting for Mplus to finish. If you 
* choose not to view the output, then the program will also not create a dataset 
* for the coefficients. By default, the output is read into SPSS.
**** "suppressSPSS" is a boolean argument indicating whether or not you want
* the program to supress SPSS output while running the model. Typically this
* output is not useful and merely clogs up the output window. However, if your
* model is not running correctly, the SPSS output can help you see where
* the errors are. Setting this argument to True will not suppress the Mplus
* output. By default, the SPSS output is not suppressed.
**** "variableList" is a list of strings identifying the SPSS variables that you 
* want included in your latent profile/class analysis. 
**** "groups" is the number of profiles or classes you want the analysis to
* create.
**** "starts" is an optional argument indicating the number of random starts
* that you want to use in the analysis. The Mplus default is 20, but it is not
* unreasonable to increase this to 1000, 2000, or 5000 if you have 
* problems with estimation. The number of final stage optimizations
* is set to be .20*the number of random starts.
**** "stiterations" is an optional argument indicating the number of initial
* stage iterations. The Mplus default is 10, but it is not unreasonable to 
* increase this to 20, 40, or 100 if you have problems with estimation.
**** "optseed" is a number indicating the seed that should be used
* to define randomization in the analysis. If this argument is omitted 
* then Mplus will choose one or more random seeds for the analysis.
**** "svalues" is a lists that allows you to swap the order of the
* profiles in the analysis. The number in the first
* list is the new number for the original first profile, the number in the
* second slot is the new number for the original second profile, etc.
* This is usually combined with a defined optseed so that you know 
* the ordering of the original profiles.
**** "estimator" is a string specifying the estimation method to be used. 
* Valid values are ML, MLM, MLMV, MLR, MLF, MUML, WLS, WLSM,
* WLSMV, ULS, ULSMV, GLS, and BAYES. If this argument is omitted,
* the Mplus default will be used, which depends on the data and model
* types you are using (most commonly MLR).
**** "useobservations" is a string specifying a selection
* criterion that must be met for observations to be included in the 
* analysis. This is an optional argument that defaults to None, indicating
* that all observations are to be included in the analysis. This should not be
* used if you have a cluster variable - in that case, use "subpopulation".
**** "categorical" is an optional argument that identifies a list of variables
* that should be treated as categorical by Mplus. Note that what Mplus
* calls categorical is typically called "ordinal" in other places. Use the
* "nominal" command described below for true categorical variables.
**** "censored" is an optional argument that identifies a list of variables
* that should be treated as censored by Mplus.
**** "count" is an optional argument that identifies a list of variables 
* that should be treated as count variables (i.e., for Poisson regression)
* by Mplus.
**** "nominal" is an optional argument that identifies a list of variables
* that should be treated as nominal variables by Mplus.
**** "idvariable" is an optional argument that identifies an identifier variable
* for your data set. This is needed if you are saving latent scores and want
* to merge them into another data set.
**** "auxiliary" is an optional argument that identifies a list of variables
* that are used to assist with estimating missing values but which are
* not to be included in the model. This defaults to None, which would
* indicate that there are no auxiliary variables in the analysis.
**** "modelDatasetName" is an optional argument that identifies the name of
* an SPSS dataset that should be used to save information about 
* the overall model.
**** "meanDatasetName" is an optional argument that identifies the name
* of an SPSS dataset that should be used to save the variable means
* for each group.
**** "datasetLabels" is an optional argument that identifies a list of
* labels that would be added to the dataset. This can be useful if you are 
* appending the results from multiple analyses to the same dataset.
**** "savedata" is an optional argument that allows you to save the data file 
* used in the analysis to a file. The value of
* this argument should be set to the name of the data file that should be created.
* The saved file will be placed in the same directory as the .inp file. This defaults to
* None, which does not save the data file.
**** "saveCprob" is an optional boolean argument that determines whether the 
* class or profile probabilities are included in the saved data file.
**** "processors" is an optional argument that specifies how many logical processors 
* Mplus should use when running the analysis. You should not specify more 
* processors than are available in your machine. If this argument is omitted, Mplus will
* use 1 processor.
**** "waittime" is an optional argument that specifies how many seconds
* the program should wait after running the Mplus program before it 
* tries to read the output file. This defaults to 5. You should be sure that
* you leave enough time for Mplus to finish the analyses before trying
* to import them into SPSS

**** Example 1 - Random starts: 
MplusLPA(inpfile = "D:/Personality/Mplus/model.inp,
modellabel = "3-group LPA",
variableList = ["Openness", "Concientiousness", "Extraversion",
"Agreeableness", "Neuroticism"], 
groups = 3,
starts = 500,
stiterations = 20,
modelDatasetName = "Personality",
savedata = "D:/Personality/Mplus/model.txt",
saveCprob = True,
waittime = 20)
* This program would conduct a 3-group latent profile analysis of the Big 5
personality scales.
* It would use 500 random starts and 20 initial stage iterations.
* Information about the profile analysis would be saved to an SPSS data
set named "Personality".
* The full data set including the assigned profile as well as the probabilities 
associated with each profile would be saved to the file 
"D:/Personality/Mplus/model.txt".

**** Example 2 - Running a specific random seed: 
MplusLPA(inpfile = "D:/Personality/Mplus/model.inp,
modellabel = "3-group LPA",
variableList = ["Openness", "Concientiousness", "Extraversion",
"Agreeableness", "Neuroticism"], 
groups = 3,
optseed = 76609,
svalues = [3, 1, 2],
modelDatasetName = "Personality",
savedata = "D:/Personality/Mplus/model.txt",
saveCprob = True,
waittime = 20)
* This program would conduct a 3-group latent profile analysis of the Big 5
personality scales.
* Instead of using random starts, this program conducts a single run using
seed 76609.
* The order of the profiles is changed so that what was the last profile
is now the first, what was the first profile is now the second, and what was the 
second profile is now the third. 
* Typically you would first identify what random seed you want to run, then
run the program initially without having anything in svalues to understand
what the original profiles look like, and then rerun it using the svales argument
to set the profile order to be what you want.
* Information about the profile analysis would be saved to an SPSS data
set named "Personality".
* The full data set including the assigned profile as well as the probabilities 
associated with each profile would be saved to the file 
"D:/Personality/Mplus/model.txt".

set printback = off.
begin program python3.
import spss, spssaux, os, sys, time, re, tempfile, SpssClient
from subprocess import Popen, PIPE

import SpssClient
import tempfile
import os

def _titleToPane():
    """See titleToPane(). This function does the actual job"""
    outputDoc = SpssClient.GetDesignatedOutputDoc()
    outputItemList = outputDoc.GetOutputItems()
    textFormat = SpssClient.DocExportFormat.SpssFormatText
    filename = tempfile.mktemp() + ".txt"
    for index in range(outputItemList.Size()):
        outputItem = outputItemList.GetItemAt(index)
        if outputItem.GetDescription() == "Page Title":
            outputItem.ExportToDocument(filename, textFormat)
            with open(filename) as f:
                outputItem.SetDescription(f.read().rstrip())
            os.remove(filename)
    return outputDoc

import SpssClient
import sys

def titleToPane(spv=None):
    """Copy the contents of the TITLE command of the designated output document
    to the left output viewer pane"""
    try:
        outputDoc = None
        SpssClient.StartClient()
        if spv:
            SpssClient.OpenOutputDoc(spv)
        outputDoc = _titleToPane()
        if spv and outputDoc:
            outputDoc.SaveAs(spv)
    except Exception as e:
        print("Error filling TITLE in Output Viewer [%s]" % str(e))
    finally:
        SpssClient.StopClient()

def MplusSplit(splitstring, linelength):
    returnstring = ""
    curline = splitstring
    while len(curline) > linelength:
        splitloc = linelength
        while curline[splitloc] == " " or curline[splitloc - 1] == " ":
            splitloc -= 1
        returnstring += curline[:splitloc] + "\n"
        curline = curline[splitloc:]
    returnstring += curline
    return returnstring

def SPSSspaceSplit(splitstring, linelength):
    stringwords = splitstring.split()
    returnstring = "'"
    curline = ""
    for word in stringwords:
        if len(word) > linelength:
            break
        if len(word) + len(curline) < linelength - 1:
            curline += word + " "
        else:
            returnstring += curline + "' +\n'"
            curline = word + " "
    returnstring += curline[:-1] + "'"
    return returnstring

def numericMissing(definition):
    for varnum in range(spss.GetVariableCount()):
        if spss.GetVariableType(varnum) == 0:
            # for numeric variables
            submitstring = """
missing values %s (%s).""" % (spss.GetVariableName(varnum), definition)
            spss.Submit(submitstring)

def exportMplus(filepath):
    ######
    # Get list of current variables in SPSS data set
    ######
    SPSSvarlist = []
    for varnum in range(spss.GetVariableCount()):
        SPSSvarlist.append(spss.GetVariableName(varnum))

    ##########
    # Replace non-alphanumeric characters with _ in the variable names
    ##########
    nonalphanumeric = [".", "@", "#", "$"]
    for t in range(spss.GetVariableCount()):
        oldname = spss.GetVariableName(t)
        newname = ""
        for i in range(len(oldname)):
            if oldname[i] in nonalphanumeric:
                newname = newname + "_"
            else:
                newname = newname + oldname[i]
        newname = newname.lstrip("_")
        for i in range(t):
            compname = spss.GetVariableName(i)
            if newname.lower() == compname.lower():
                newname = "var" + "%05d" % (t + 1)
        if oldname != newname:
            submitstring = "rename variables (%s = %s)." % (oldname, newname)
            spss.Submit(submitstring)

    #########
    # Rename variables with names > 8 characters
    #########
    for t in range(spss.GetVariableCount()):
        if len(spss.GetVariableName(t)) > 8:
            name = spss.GetVariableName(t)[0:8]
            for i in range(spss.GetVariableCount()):
                compname = spss.GetVariableName(i)
                if name.lower() == compname.lower():
                    name = "var" + "%05d" % (t + 1)
            submitstring = "rename variables (%s = %s)." % (spss.GetVariableName(t), name)
            spss.Submit(submitstring)

    # Obtain lists of variables in the dataset
    varlist = []
    numericlist = []
    stringlist = []
    for t in range(spss.GetVariableCount()):
        varlist.append(spss.GetVariableName(t))
        if spss.GetVariableType(t) == 0:
            numericlist.append(spss.GetVariableName(t))
        else:
            stringlist.append(spss.GetVariableName(t))

    ###########
    # Automatically recode string variables into numeric variables
    ###########
    # First renaming string variables so the new numeric vars can take the 
    # original variable names
    submitstring = "rename variables"
    for var in stringlist:
        submitstring = submitstring + "\n " + var + "=" + var + "_str"
    submitstring = submitstring + "."
    spss.Submit(submitstring)

    # Recoding variables
    if len(stringlist) > 0:
        submitstring = "AUTORECODE VARIABLES="
        for var in stringlist:
            submitstring = submitstring + "\n " + var + "_str"
        submitstring = submitstring + "\n /into"
        for var in stringlist:
            submitstring = submitstring + "\n " + var
        submitstring = submitstring + """
   /BLANK=MISSING
   /PRINT."""
        spss.Submit(submitstring)
    
    # Dropping string variables
    submitstring = "delete variables"
    for var in stringlist:
        submitstring = submitstring + "\n " + var + "_str"
    submitstring = submitstring + "."
    spss.Submit(submitstring)

    # Set all missing values to be -999
    submitstring = "RECODE "
    for var in varlist:
        submitstring = submitstring + " " + var + "\n"
    submitstring = submitstring + """ (MISSING=-999).
EXECUTE."""
    spss.Submit(submitstring)

    numericMissing("-999")

    ########
    # Convert date and time variables to numeric
    ########
    # SPSS actually stores dates as the number of seconds that have elapsed since October 14, 1582.
    # This syntax takes variables with a date type and puts them in their natural numeric form

    submitstring = """numeric ddate7663804 (f11.0).
alter type ddate7663804 (date11).
ALTER TYPE ALL (DATE = F11.0).
alter type ddate7663804 (adate11).
ALTER TYPE ALL (ADATE = F11.0).
alter type ddate7663804 (sdate11).
ALTER TYPE ALL (SDATE = F11.0).
alter type ddate7663804 (edate11).
ALTER TYPE ALL (EDATE = F11.0).
alter type ddate7663804 (jdate11).
ALTER TYPE ALL (JDATE = F11.0).
alter type ddate7663804 (datetime17).
ALTER TYPE ALL (DATETIME = F11.0).
alter type ddate7663804 (time11).
ALTER TYPE ALL (TIME = F11.0).
alter type ddate7663804 (qyr6).
ALTER TYPE ALL (QYR = F11.0).
alter type ddate7663804 (moyr6).
ALTER TYPE ALL (MOYR = F11.0).
alter type ddate7663804 (ymdhms16).
ALTER TYPE ALL (YMDHMS = F11.0).
alter type ddate7663804 (wkday3).
ALTER TYPE ALL (WKDAY = F11.0).
alter type ddate7663804 (month3).
ALTER TYPE ALL (MONTH = F11.0).

delete variables ddate7663804."""
    spss.Submit(submitstring)

    ######
    # Obtain list of transformed variables
    ######
    submitstring = """MATCH FILES /FILE=*
  /keep="""
    for var in varlist:
        submitstring = submitstring + "\n " + var
    submitstring = submitstring + """.
EXECUTE."""
    spss.Submit(submitstring)
    MplusVarlist = []
    for varnum in range(spss.GetVariableCount()):
        MplusVarlist.append(spss.GetVariableName(varnum))

    ############
    # Create data file
    ############
    # Break filename over multiple lines
    splitfilepath = SPSSspaceSplit(filepath, 60)

    # Save data as a tab-delimited text file
    submitstring = """SAVE TRANSLATE OUTFILE=
    %s
  /TYPE=TAB
  /MAP
  /REPLACE
  /CELLS=VALUES
    /keep""" % (splitfilepath)
    for var in varlist:
        submitstring = submitstring + "\n " + var
    submitstring = submitstring + "."
    spss.Submit(submitstring)

    ##############
    # Rename variables back to original values
    ##############
    submitstring = "rename variables"
    for s, m in zip(SPSSvarlist, MplusVarlist):
        submitstring += "\n(" + m + "=" + s + ")"
    submitstring += "."
    spss.Submit(submitstring)

    return MplusVarlist

class MplusPAprogram:
    def __init__(self):
        self.title = "TITLE:\n"
        self.data = "DATA:\n"
        self.variable = "VARIABLE:\n"
        self.define = "DEFINE:\n"
        self.analysis = "ANALYSIS:\n"
        self.model = "MODEL:\n"
        self.constraint = "MODEL CONSTRAINT:\n"
        self.output = "OUTPUT:\n"
        self.savedata = "SAVEDATA:\n"
        self.plot = "PLOT:\n"
        self.montecarlo = "MONTECARLO:\n"

    def setTitle(self, titleText):
        self.title += titleText

    def setData(self, filename):
        self.data += "File is\n"
        splitName = MplusSplit(filename, 75)
        self.data += "'" + splitName + "';"

    def setVariable(self, fullList, variableList, groups, useobservations=None, 
                    categorical=None, censored=None, count=None, nominal=None, 
                    idvariable=None, auxiliary=None):
        self.variable += "Names are\n"
        for var in fullList:
            self.variable += var + "\n"
        self.variable += ";\n\n"

        # Determine usevariables
        useList = variableList[:]
        self.variable += "Usevariables are\n"
        for var in useList:
            self.variable += var + "\n"

        # Other variable additions
        if useobservations:
            self.variable += ";\n\nuseobservations are " + useobservations
        if idvariable:
            self.variable += ";\n\nidvariable is " + idvariable
        if auxiliary:
            self.variable += ";\n\nauxiliary = (m) " 
            for var in auxiliary:
                self.variable += var + "\n"

        vartypeList = [categorical, censored, count, nominal]
        varnameList = ["categorical", "censored", "count", "nominal"]
        for t in range(len(vartypeList)):
            if vartypeList[t]:
                self.variable += ";\n\n{0} = ".format(varnameList[t])
                for var in vartypeList[t]:
                    self.variable += var + "\n"
        self.variable += ";\n\nMISSING ARE ALL (-999);"
        self.variable += "\n\nclasses = group (" + str(groups) + ");"

    def setAnalysis(self, estimator=None, starts=None, stiterations=None, 
                    optseed=None, processors=None):
        self.analysis += "type = mixture;"
        if estimator:
            self.analysis += "\nestimator = {0};".format(estimator)
        if starts:
            self.analysis += "\nstarts = {0} {1};".format(str(starts), str(int(starts/5)))
        if stiterations:
            self.analysis += "\nstiterations = {0};".format(str(stiterations))
        if optseed:
            self.analysis += "\noptseed = {0};".format(str(optseed))
        if processors:
            self.analysis += "\nprocessors = {0};".format(str(processors))

    def setOutput(self, svalues=None):
        if svalues:
            self.output += "\nsvalues ("
            for o in svalues:
                self.output += str(o) + " "
            self.output += ");"

    def setSavedata(self, savedata=None, saveCprob=False):
        if savedata:
            splitName = MplusSplit(savedata, 75)
            self.savedata += "\nfile = \n'{0}';".format(splitName)
            if saveCprob:
                self.savedata += "\nsave = cprob;"

    def write(self, filename):
        # Write input file
        sectionList = [self.title, self.data, self.variable, self.define,
                       self.analysis, self.model, self.constraint, self.output, 
                       self.savedata, self.plot, self.montecarlo]
        with open(filename, "w") as outfile:
            for sec in sectionList:
                if sec[-2:] != ":\n":
                    outfile.write(sec)
                    outfile.write("\n\n")

import os
from subprocess import Popen

def batchfile(directory, filestem):
    # Write batch file
    batchFile = open(os.path.join(directory, filestem + ".bat"), "w")
    batchFile.write("cd " + directory + "\n")
    batchFile.write("call mplus \"" + filestem + ".inp" + "\"\n")
    batchFile.close()

    # Run batch file
    p = Popen(os.path.join(directory, filestem + ".bat"), cwd=directory)

def removeBlanks(processString):
    if processString is None:
        return None
    else:
        for t in range(len(processString), 0, -1):
            if processString[t - 1] != "\n":
                return processString[0:t]

class MplusLPAoutput:
    def __init__(self, modellabel, filename, Mplus, SPSS, groups, estimator):
        self.label = modellabel
        with open(filename, "rb") as infile:
            fileText = infile.read().decode('utf-8')
        outputList = fileText.split("\n")

        if estimator == "BAYES":
            self.header = """                                               Posterior  One-Tailed         95% C.I.
                                   Estimate       S.D.      P-Value   Lower 2.5%  Upper 2.5%  Sig"""
        else:
            self.header = """                                                                   Two-Tailed 
                                   Estimate       S.E.  Est./S.E.    P-Value"""
        self.summary = None
        self.starts = None
        self.warnings = None
        self.fit = None
        self.counts = None
        self.quality = None
        self.classMeans = None

        # Summary
        for t in range(len(outputList)):
            if "SUMMARY OF ANALYSIS" in outputList[t]:
                start = t
                break
        for t in range(start, len(outputList)):
            if "Observed dependent variables" in outputList[t]:
                end = t
                break
        self.summary = "\n".join(outputList[start:end])
        self.summary = removeBlanks(self.summary)
        
        # Random starts
        noStarts = 1
        for t in range(end, len(outputList)):
            if "RANDOM STARTS" in outputList[t]:
                start = t
                noStarts = 0
                break
        if noStarts == 0:                
            for t in range(start, len(outputList)):
                if "MODEL ESTIMATION TERMINATED NORMALLY" in outputList[t] or "MODEL FIT" in outputList[t]:
                    end = t
                    break
            self.starts = "\n".join(outputList[start:end])
            self.starts = removeBlanks(self.starts)
            
        # Warnings
        start = end
        for t in range(start, len(outputList)):
            if "MODEL FIT INFORMATION" in outputList[t]:
                end = t
                break
        self.warnings = "\n".join(outputList[start:end])
        self.warnings = removeBlanks(self.warnings)

        # Fit statistics
        if "MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings:
            start = end
            for t in range(start, len(outputList)):
                if "FINAL CLASS COUNTS" in outputList[t]:
                    end = t
                    break
            self.fit = "\n".join(outputList[start:end])
            self.fit = removeBlanks(self.fit)

        # Class counts
        start = end
        for t in range(start, len(outputList)):
            if "CLASSIFICATION QUALITY" in outputList[t] or "MODEL RESULTS" in outputList[t]:
                end = t
                break
        self.counts = "\n".join(outputList[start:end])
        self.counts = removeBlanks(self.counts)
        
        # Classification quality
        start = end
        noQuality = 1
        for t in range(end, len(outputList)):
            if "CLASSIFICATION QUALITY" in outputList[t]:
                start = t
                noQuality = 0
                break
        if noQuality == 0:
            for t in range(start, len(outputList)):
                if "MODEL RESULTS" in outputList[t]:
                    end = t
                    break
            self.quality = "\n".join(outputList[start:end])
            self.quality = removeBlanks(self.quality)
            
        # Class Means
        for t in range(end, len(outputList)):
            if "Latent Class 1" in outputList[t]:
                start = t
                break
        for t in range(start, len(outputList)):
            if "Categorical Latent Variables" in outputList[t] or "QUALITY OF NUMERICAL RESULTS" in outputList[t]:
                end = t
                break
        self.classMeans = "\n".join(outputList[start:end])
        self.classMeans = removeBlanks(self.classMeans)
            
        # Replacing variable names
        # In the Coefficients section, initially room for 17
        # A) Increasing overall width from 61 to 75 = gain of 14
        # In the Modification indices section, 
        # there is initially room for 2 vars X 10 characters
        # A) Increasing overall width from 67 to 77 = gain of 5 for each var
        # B) Drop STD EPC = gain of 6 for each var
        # C) Change "StdYX E.P.C." to "StdYX EPC" = gain of 2 for each var
        # Making all variables length of 23

        # Variables
        for var1, var2 in zip(Mplus, SPSS):
            var1 += " " * (8 - len(var1))
            var1 = " " + var1 + " "
            if len(var2) < 23:
                var2 += " " * (23 - len(var2))
            else:
                var2 = var2[:23]
            var2 = " " + var2 + " "

            # Class means
            if self.classMeans is not None:
                self.classMeans = self.classMeans.replace(var1.upper(), var2)

    # Print function
    def toSPSSoutput(self):
        spss.Submit("title '" + self.label + "'.")
        spss.Submit("title 'SUMMARY'.")
        print(self.summary)
        if self.starts is not None:
            spss.Submit("title 'RANDOM STARTS'.")
            print(self.starts)
        spss.Submit("title 'WARNINGS'.")
        print(self.warnings)
        if "MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings:
            spss.Submit("title 'FIT STATISTICS'.")
            print(self.fit)
        spss.Submit("title 'CLASS COUNTS'.")
        print(self.counts)
        if self.quality is not None:
            spss.Submit("title 'CLASSIFICATION QUALITY'.")
            print(self.quality)
        spss.Submit("title 'CLASS MEANS'.")
        print(self.header)
        print(self.classMeans)

    # Save model info to dataset
    def modelToSPSSdata(self, modelDatasetName, groups, labelList=[]):
        # Determine active data set so we can return to it when finished
        activeName = spss.ActiveDataset()
        # Set up data set if it doesn't already exist
        tag, err = spssaux.createXmlOutput('Dataset Display', omsid='Dataset Display', subtype='Datasets')
        datasetList = spssaux.getValuesFromXmlWorkspace(tag, 'Datasets')

        if modelDatasetName not in datasetList:
            spss.StartDataStep()
            datasetObj = spss.Dataset(name=None)
            dsetname = datasetObj.name
            datasetObj.varlist.append("Groups", 0)
            datasetObj.varlist.append("FreeParam", 0)
            datasetObj.varlist.append("LL", 0)
            datasetObj.varlist.append("Entropy", 0)
            datasetObj.varlist.append("AIC", 0)
            datasetObj.varlist.append("BIC", 0)
            datasetObj.varlist.append("ABIC", 0)
            datasetObj.varlist.append("MinimumN", 0)
            datasetObj.varlist.append("MinimumProp", 0)
            datasetObj.varlist.append("LLreplicated", 0)
            datasetObj.varlist.append("NonPosDef", 0)
            spss.EndDataStep()
            submitstring = """dataset activate {0}.
dataset name {1}.""".format(dsetname, modelDatasetName)
            spss.Submit(submitstring)

        spss.StartDataStep()
        datasetObj = spss.Dataset(name=modelDatasetName)
        spss.SetActive(datasetObj)

        # Label variables
        variableList = []
        for t in range(spss.GetVariableCount()):
            variableList.append(spss.GetVariableName(t))
        for t in range(len(labelList)):
            if "label{0}".format(str(t)) not in variableList:
                datasetObj.varlist.append("label{0}".format(str(t)), 50)
        spss.EndDataStep()

        # Set ordinal variables to f8
        submitstring = "alter type Groups FreeParam MinimumN LLreplicated NonPosDef (f8)."
        spss.Submit(submitstring)

        # Set continuous variables to f8.3
        submitstring = "alter type LL to ABIC MinimumProp (f8.3)."
        spss.Submit(submitstring)

        # Process random starts
        LLreplicated = 0
        if self.starts is None:
            LLreplicated = None
        else:
            if "VALUE HAS BEEN REPLICATED" in self.starts:
                LLreplicated = 1
    
        # Process Warnings
        NonPosDef = 0
        if "NON-POSITIVE DEFINITE" in self.warnings:
            NonPosDef = 1

        # Process fit statistics
        block = self.fit
        blockLines = block.split("\n")
        for line in blockLines:
            if "Free Parameters" in line:
                words = ' '.join(line.split()).split(" ")
                FreeParam = int(words[4])
            if "H0 Value" in line:
                words = ' '.join(line.split()).split(" ")
                LL = float(words[2])
            if "Akaike" in line:
                words = ' '.join(line.split()).split(" ")
                AIC = float(words[2])
            if "Bayesian" in line:
                words = ' '.join(line.split()).split(" ")                
                BIC = float(words[2])
            if "Adjusted BIC" in line:
                words = ' '.join(line.split()).split(" ")
                ABIC = float(words[3])
                
        # Process class counts
        block = self.counts
        blockLines = block.split("\n")
        for t in range(len(blockLines)):
            if "Class Counts and Proportions" in blockLines[t]:
                start = t + 5
                break
        MinimumN = float('inf')
        for t in range(start, start + groups):
            line = blockLines[t]
            words = ' '.join(line.split()).split(" ")
            n = round(float(words[1]))
            if n < MinimumN:
                MinimumN = n
                MinimumProp = float(words[2])

        # Process classification quality
        if self.quality is None:
            Entropy = None
        else:
            block = self.quality
            blockLines = block.split("\n")
            for line in blockLines:
                if "Entropy" in line:
                    words = ' '.join(line.split()).split(" ")    
                    Entropy = float(words[1])
                    break
    
        # Determine values for dataset
        dataValues = [groups, FreeParam, LL, Entropy, AIC, BIC, ABIC, MinimumN, MinimumProp, LLreplicated, NonPosDef]

        # Put values in dataset
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=modelDatasetName)
        datasetObj.cases.append(dataValues)
        spss.EndDataStep()

        # Return to original data set
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=activeName)
        spss.SetActive(datasetObj)
        spss.EndDataStep()
        
    # Save means to dataset
    def meansToSPSSdata(self, meanDatasetName, groups, labelList=[]):
        # Determine active data set so we can return to it when finished
        activeName = spss.ActiveDataset()
        # Set up data set if it doesn't already exist
        tag, err = spssaux.createXmlOutput('Dataset Display', omsid='Dataset Display', subtype='Datasets')
        datasetList = spssaux.getValuesFromXmlWorkspace(tag, 'Datasets')

        if meanDatasetName not in datasetList:
            spss.StartDataStep()
            datasetObj = spss.Dataset(name=None)
            dsetname = datasetObj.name
            datasetObj.varlist.append("Groups", 0)
            datasetObj.varlist.append("GroupNum", 0)
            datasetObj.varlist.append("N", 0)
            datasetObj.varlist.append("VarName", 50)
            datasetObj.varlist.append("VarMean", 0)
            datasetObj.varlist.append("VarSE", 0)
            spss.EndDataStep()
            submitstring = """dataset activate {0}.
dataset name {1}.""".format(dsetname, meanDatasetName)
            spss.Submit(submitstring)

        spss.StartDataStep()
        datasetObj = spss.Dataset(name=meanDatasetName)
        spss.SetActive(datasetObj)

        # Label variables
        variableList = []
        for t in range(spss.GetVariableCount()):
            variableList.append(spss.GetVariableName(t))
        for t in range(len(labelList)):
            if "label{0}".format(str(t)) not in variableList:
                datasetObj.varlist.append("label{0}".format(str(t)), 50)
        spss.EndDataStep()

        # Set ordinal variables to f8
        submitstring = "alter type Groups N GroupNum (f8)."
        spss.Submit(submitstring)

        # Set continuous variables to f8.3
        submitstring = "alter type VarMean VarSE (f8.3)."
        spss.Submit(submitstring)

        # Extract class counts
        block = self.counts
        blockLines = block.split("\n")
        for t in range(len(blockLines)):
            if "Class Counts and Proportions" in blockLines[t]:
                start = t + 5
                break
        groupNs = []
        for t in range(start, start + groups):
            line = blockLines[t]
            words = ' '.join(line.split()).split(" ")
            groupNs.append(int(words[1]))
                
        # Extract info from class means output
        block = self.classMeans
        blockLines = block.split("\n")
        dataValues = []
        t = 0
        for g in range(groups):
            while "Means" not in blockLines[t]:
                t += 1
            t += 1
            while len(blockLines[t]) > 1:
                line = blockLines[t]
                words = ' '.join(line.split()).split(" ")
                dataValues.append([groups, g + 1, groupNs[g], words[0], float(words[1]), float(words[2])])
                t += 1

        # Put values in dataset
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=meanDatasetName)
        for t in dataValues:
            datasetObj.cases.append(t)
        spss.EndDataStep()

        # Return to original data set
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=activeName)
        spss.SetActive(datasetObj)
        spss.EndDataStep()

def MplusLPA(inpfile, modellabel="MplusLPA",
             runModel=True, viewOutput=True, suppressSPSS=False, 
             variableList=None, groups=None, starts=None, stiterations=None,
             optseed=None, svalues=None,
             estimator=None, useobservations=None, 
             categorical=None, censored=None, count=None, nominal=None,
             idvariable=None, auxiliary=None, 
             modelDatasetName=None, 
             meanDatasetName=None,
             datasetLabels=[], 
             savedata=None, saveCprob=False, 
             processors=None, waittime=5):

    spss.Submit("display scratch.")

    # Redirect output
    if suppressSPSS:
        submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
    /DESTINATION VIEWER = NO 
    /TAG = 'NoJunk'."""
        spss.Submit(submitstring)

    # Find directory and filename
    for t in range(len(inpfile)):
        if inpfile[-t] == "/":
            break
    outdir = inpfile[:-t+1]
    fname, fext = os.path.splitext(inpfile[-(t-1):])

    # Obtain list of variables in data set
    SPSSvariables = [spss.GetVariableName(varnum) for varnum in range(spss.GetVariableCount())]
    SPSSvariablesCaps = [var.upper() for var in SPSSvariables]

    # Restore output
    if suppressSPSS:
        submitstring = """OMSEND TAG = 'NoJunk'."""
        spss.Submit(submitstring)

    # Check for errors
    error = 0
    if fext.upper() != ".INP":
        print("Error: Input file specification does not end with .inp")
        error = 1
    if not os.path.exists(outdir):
        print("Error: Output directory does not exist")
        error = 1
    if estimator:
        estimator = estimator.upper()
        if estimator not in ["ML", "MLM", "MLMV", "MLR", "MLF", "MUML", "WLS", "WLSM", "WLSMV", "ULS", "ULSMV", "GLS", "BAYES"]:
            print("Error: Estimator not valid")
            error = 1

    if error == 0:
        # Redirect output
        if suppressSPSS:
            submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
    /DESTINATION VIEWER = NO 
    /TAG = 'NoJunk'."""
            spss.Submit(submitstring)

        # Export data
        dataname = outdir + fname + ".dat"
        MplusVariables = exportMplus(dataname)

        # Convert useobservations to Mplus
        if useobservations:
            MplusUseobservations = useobservations
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                z = re.compile(s, re.IGNORECASE)
                MplusUseobservations = z.sub(m, MplusUseobservations)

        # Convert idvariable to Mplus
        MplusIdvariable = None
        if idvariable:
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if idvariable.upper() == s:
                    MplusIdvariable = m

        # Convert variable list arguments to Mplus
        lvarList = [auxiliary, categorical, censored, count, nominal, variableList]
        MplusMeans = []
        MplusAuxiliary = []
        MplusCategorical = []
        MplusCensored = []
        MplusCount = []
        MplusNominal = []
        MplusVariableList = []
        lvarMplusList = [MplusAuxiliary, MplusCategorical, MplusCensored, MplusCount, MplusNominal, MplusVariableList]
        for t in range(len(lvarList)):
            if lvarList[t] is not None:
                for i in lvarList[t]:
                    lvarMplusList[t].append(i.upper())
                for i in range(len(lvarMplusList[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if lvarMplusList[t][i] == s:
                            lvarMplusList[t][i] = m

        # Create input program
        pathProgram = MplusPAprogram()
        pathProgram.setTitle("Created by MplusLPA")
        pathProgram.setData(dataname)
        pathProgram.setVariable(MplusVariables, MplusVariableList, groups, MplusUseobservations, 
                                MplusCategorical, MplusCensored, MplusCount, MplusNominal, MplusIdvariable,
                                MplusAuxiliary)
        pathProgram.setAnalysis(estimator, starts, stiterations, optseed, processors)
        pathProgram.setOutput(svalues)
        pathProgram.setSavedata(savedata, saveCprob)
        pathProgram.write(outdir + fname + ".inp")

        # Run input program
        if runModel:
            batchfile(outdir, fname)
            time.sleep(waittime)

        # Restore output
        if suppressSPSS:
            submitstring = """OMSEND TAG = 'NoJunk'."""
            spss.Submit(submitstring)

        if viewOutput:
            pathOutput = MplusLPAoutput(modellabel, outdir + fname + ".out", 
                                        MplusVariables, SPSSvariables, groups, estimator)
            pathOutput.toSPSSoutput()

            # Redirect output
            if suppressSPSS:
                submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
    /DESTINATION VIEWER = NO 
    /TAG = 'NoJunk'."""
                spss.Submit(submitstring)

            # Create dataset
            if modelDatasetName:
                pathOutput.modelToSPSSdata(modelDatasetName, groups, datasetLabels)
            if meanDatasetName:
                pathOutput.meansToSPSSdata(meanDatasetName, groups, datasetLabels)                

            # Restore output
            if suppressSPSS:
                submitstring = """OMSEND TAG = 'NoJunk'."""
                spss.Submit(submitstring)

    # Replace titles
    titleToPane()
end program python3.
set printback = on.

************
* Version History
************
* 2021-12-30 Created
* 2022-01-02 Cut unneeded code
* 2022-01-03 Added code to run LPA
* 2022-01-04 Read LPA output
* 2022-01-04a Create dataset with LPA info
* 2022-01-05 Finished creating model data set
* 2022-01-06 Created means data set
* 2022-01-06a Allowed macro to work with only 1 group
* 2022-01-07 Removed extra print statements
* 2022-01-30 Added Ns to mean data set
* 2022-02-03 Fixed start and stiterations implementation
* 2022-02-13 Added processors argument
* 2022-03-21 Added additional date types
* 2022-03-28 Allowed splitting of savedata filename
* 2022-03-30 Initialized MplusIdvariable
* 2022-07-19 Used round() instead of int() when calculating minimum n
* 2022-07-26 Corrected data type error when saving model data set
* 2024-05-29 Updated to Python 3
