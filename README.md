In order to run you must have flex and yacc installed (ubuntu/debian):  
 **sudo apt-get install flex**
 **sudo apt-get install byacc**
After that you just need to run the Makefile:  
 **make**

And then execute it feeding a file containing the code to be analysed:  
 **./etapa2 < example**
 **./etapa2 < example-error**

The result will be a error message in case of syntactic error or nothing in case of success.

==================================================

To better understand what is the syntactic definition accepted, please take a look in the work description (in portuguese):
[Work description](https://bitbucket.org/bpsilva/compiler-01_lexical_analysis/src/f12e26addcca1d1ac8894d7026391534afafd571/definicao.pdf?at=master&fileviewer=file-view-default)
