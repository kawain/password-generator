import os
import strutils
import sequtils
import parseopt
import random

randomize()

var word_count = 6
var word_uppercase = false
var word_number = false
var word_symbol = false
var help = false

var opt = parseopt.initOptParser(os.commandLineParams().join(" "))
for kind, key, val in opt.getopt():
  case key

  of "count", "c":
    case kind
    of cmdShortOption, cmdLongOption:
      opt.next()
      word_count = opt.key.parseInt
      if word_count < 1:
        word_count = 1
    else: discard

  of "uppercase", "u":
    case kind
    of cmdShortOption, cmdLongOption:
      word_uppercase = true
    else: discard

  of "number", "n":
    case kind
    of cmdShortOption, cmdLongOption:
      word_number = true
    else: discard

  of "symbol", "s":
    case kind
    of cmdShortOption, cmdLongOption:
      word_symbol = true
    else: discard

  of "help", "h":
    case kind
    of cmdShortOption, cmdLongOption:
      help = true
    else: discard


if help:
  echo """
Help

Default is lowercase and generates 6-character password.

Option list

To set the password to 10 characters.
--count 10
Or
-c 10

When capital letters are used in passwords.
--uppercase
Or
-u

When using numbers in passwords.
--number
Or
-n

When using symbols in passwords.
--symbol
Or
-s
  """
  quit(1)


let lowercaseRange = 97..122
var mySeq = toSeq(lowercaseRange)

if word_uppercase:
  let uppercaseRange = 65..90
  mySeq = concat(mySeq, toSeq(uppercaseRange))

if word_number:
  let numberRange = 48..57
  mySeq = concat(mySeq, toSeq(numberRange))

if word_symbol:
  let symbolRange1 = 33..47
  let symbolRange2 = 58..64
  let symbolRange3 = 91..96
  let symbolRange4 = 123..126
  mySeq = concat(mySeq, toSeq(symbolRange1), toSeq(symbolRange2), toSeq(
      symbolRange3), toSeq(symbolRange4))

var password = ""

for v in 1..word_count:
  let pick = sample(mySeq)
  password.add(char(pick))

echo password
