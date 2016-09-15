This is the second part of the project of building my own compiler. It is part of the the grade to the course of Compilers (INF01147) at Federal University of Rio Grande do Sul.  

==================================================  

In order to run you must have flex and yacc installed (ubuntu/debian):  
 **sudo apt-get install flex**  
 **sudo apt-get install byacc**  

After that you just need to run the Makefile:  
 **make**

And then execute it feeding a file containing the code to be analysed:  
 **./etapa2 < example**  
 **./etapa2 < example-error**  
 **./etapa2 < example1**  

The result will be a error message in case of syntactic error or nothing in case of success.

==================================================

To better understand what is the syntactic definition accepted, please take a look at the task description (in portuguese):
[Task description](https://bitbucket.org/bpsilva/compiler-02_syntactic_analysis/raw/ca77046c56d9f7fafab516dc0e3f3a504c5a924e/definition.pdf)