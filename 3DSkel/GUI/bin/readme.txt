SPECIFYING MATLAB JAVA HEAP SPACE

Create java.opts file with

-Xms2048m
	Initial Heap Size
-Xmx32768m	Max Heap Size


Put the java.opts file in one of the following folders:
- MATLAB startup folder, if starting MATLAB from a command prompt.
- If there is no java.opts file in the startup folder, MATLAB checks the matlabroot/bin/arch folder. matlabroot is the output of the matlabroot function and arch is the output of the computer('arch') function.


LOCATION EXAMPLE (for MAC) : '/Applications/Matlab2016a/bin/maci64/java.opts'


A java.opts file in this location applies to all users, but individual users might not have permissions to modify files there.