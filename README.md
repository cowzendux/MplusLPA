# MplusLPA
SPSS Python Extension function that will use Mplus to run a latent profile or latent class analysis from within SPSS

This program allows users to identify a Latent Profile or Class analysis that they want to test on an SPSS data set. The program then converts the active data set to Mplus format, writes a program that will perform the path analysis in Mplus, then loads the important parts of the Mplus output into the SPSS output window.

The only difference between an LPA and an LCA is whether you identify your variables as continuous (LPA) or categorical (LCA).

This and other SPSS Python Extension functions can be found at http://www.stat-help.com/python.html

## Usage: 
**MplusLPA(inpfile, modellabel, runModel, viewOutput, suppressSPSS, variableList, groups, starts, stiterations, estimator, useobservations, categorical, censored, count, nominal, idvariable, modelDatasetName, meanDatasetName, datasetLabels, savedata, saveCprob, waittime)**
* "inpfile" is a string identifying the directory and filename of Mplus input file to be created by the program. This filename must end with .inp . The data file will automatically be saved to the same directory. This argument is required.
* "modellabel" is a string that indicates what label should be added to the output at the top of your model. If this is not specified, the label defaults to "MplusLPA".
* "runModel" is a boolean argument indicating whether or not you want the program to actually run the program it creates based on the model you define. You may choose to not run the model when you want to use the program to load an existing output file into SPSS. However, when doing this, you should first load the corresponding data set so that the function can determine the appropriate translation between the Mplus variable names and SPSS variable names. By default, the model is run.
* "viewOutput" is a boolean argument indicating whether or not you want the program to read the created output into SPSS. You may choose not to read the output into SPSS when you know that it will take a very long time to run and you do not want to tie up SPSS while you are waiting for Mplus to finish. If you choose not to view the output, then the program will also not create a dataset for the coefficients. By default, the output is read into SPSS.
* "suppressSPSS" is a boolean argument indicating whether or not you want the program to supress SPSS output while running the model. Typically this output is not useful and merely clogs up the output window. However, if your model is not running correctly, the SPSS output can help you see where the errors are. Setting this argument to True will not suppress the Mplus output. By default, the SPSS output is not suppressed.
* "variableList" is a list of strings identifying the SPSS variables that you want included in your latent profile/class analysis. 
* "groups" is the number of profiles or classes you want the analysis to create.
* "starts" is an optional argument indicating the number of random starts that you want to use in the analysis. The Mplus default is 20, but it is not unreasonable to increase this to 100, 500, 1000, 2000, or 5000 if you have problems with estimation. The number of final stage optimizations is set to be .20\*the number of random starts.
* "stiterations" is an optional argument indicating the number of initial stage iterations. The Mplus default is 10, but it is not unreasonable to increase this to 20, 40, or 100 if you have problems with estimation.
* "estimator" is a string specifying the estimation method to be used. Valid values are ML, MLM, MLMV, MLR, MLF, MUML, WLS, WLSM, WLSMV, ULS, ULSMV, GLS, and BAYES. If this argument is omitted, the Mplus default will be used, which depends on the data and model types you are using (most commonly MLR).
* "useobservations" is a string specifying a selection criterion that must be met for observations to be included in the analysis. This is an optional argument that defaults to None, indicating that all observations are to be included in the analysis. This should not be used if you have a cluster variable - in that case, use "subpopulation".
* "categorical" is an optional argument that identifies a list of variables that should be treated as categorical by Mplus. Note that what Mplus calls categorical is typically called "ordinal" in other places. Use the "nominal" command described below for true categorical variables.
* "censored" is an optional argument that identifies a list of variables that should be treated as censored by Mplus.
* "count" is an optional argument that identifies a list of variables that should be treated as count variables (i.e., for Poisson regression) by Mplus.
* "nominal" is an optional argument that identifies a list of variables that should be treated as nominal variables by Mplus.
* "idvariable" is an optional argument that identifies an identifier variable for your data set. This is needed if you are saving latent classes and want to merge them into another data set.
* "auxiliary" is an optional argument that identifies a list of variables that are used to assist with estimating missing values but which are not to be included in the model. This defaults to None, which would indicate that there are no auxiliary variables in the analysis.
* "modelDatasetName" is an optional argument that identifies the name of an SPSS dataset that should be used to save information about the overall model.
* "meanDatasetName" is an optional argument that identifies the name of an SPSS dataset that should be used to save the variable means for each group.
* "datasetLabels" is an optional argument that identifies a list of labels that would be added to the dataset. This can be useful if you are appending the results from multiple analyses to the same dataset. These labels are included in both the model and mean datasets.
* "savedata" is an optional argument that allows you to save the data file used in the analysis to a file. The value of this argument should be set to the name of the data file that should be created. The saved file will be placed in the same directory as the .inp file. This defaults to None, which does not save the data file.
* "saveCprob" is an optional boolean argument that determines whether the class or profile probabilities are included in the saved data file.
* "waittime" is an optional argument that specifies how many seconds the program should wait after running the Mplus program before it tries to read the output file. This defaults to 5. You should be sure that you leave enough time for Mplus to finish the analyses before trying to import them into SPSS

## Example: 
**MplusLPA(inpfile = "D:/Personality/Mplus/model.inp",  
modellabel = "3-group LPA",  
variableList = ["Openness", "Concientiousness", "Extraversion", "Agreeableness", "Neuroticism"],  
groups = 3,  
starts = 500,  
stiterations = 20,  
modelDatasetName = "Personality",  
savedata = "D:/Personality/Mplus/model.txt",  
saveCprob = True,  
waittime = 20)**
* This program would conduct a 3-group latent profile analysis of the Big 5 personality scales.
* It would use 500 random starts and 20 initial stage iterations. 
* Information about the profile analysis would be saved to an SPSS data set named "Personality".
* The full data set including the assigned profile as well as the probabilities associated with each profile would be saved to the file "D:/Personality/Mplus/model.txt".
