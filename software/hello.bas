'**
'**   vim: syntax=basic nowrap tabstop=3:
'**
'***=======================================================================
'***
'***    Author: David Billsbrough
'***   Created: Friday, December 13, 2024 at 20:55:55 PM (EST)
'***   License: GNU General Public License -- version 2
'***   Version: $Revision: 0.30 $
'***  Language: FreeBASIC
'***  Warranty: None
'***
'***   Purpose: a sample program to test out the compiler
'***
'***=======================================================================

' program : hello.bas
'
' $Id: hello.bas,v 0.30 2024/12/14 02:00:40 kc4zvw Exp kc4zvw $
'

dim x as Double, y as Double, z as Double
dim sin_x as Double, cos_x as Double, tan_x as Double
dim w as Double
dim i as Integer

print
print "Hello World!"
print

print "  Count         Value: x      sine(x)        cos(x)       tan(x) "
print " -------       ----------    ---------      --------     --------"

for i = 1 to 20
        x = Cdbl(i / 50.0)
        sin_x = sin(x)
        cos_x = cos(x)
        tan_x = tan(x)

        print using " #####         ###.####      ###.####     ###.####     ###.#### "; i; x; sin_x; cos_x; tan_x
next i

print:print:print

print "Compile Date: " & __DATE_ISO__
print

if __DATE_ISO__ < "2022-12-25" then
        print "Compiled before Christmas day 2022"
else
        print "Compiled after Christmas day 2022"
end if

if __DATE_ISO__ < "2023-12-25" then
        print "Compiled before Christmas day 2023"
else
        print "Compiled after Christmas day 2023"
end if

#include "vbcompat.bi"

dim s as String, d1 as Double, d2 as Double

s = "09/27/1959 00:00:00"

if IsDate( s ) then
        d1 = DateValue( s )
        d2 = Now()

        print
        print "You are " & DateDiff( "yyyy", d1, d2 ) & " years old."
        print "You are " & DateDiff( "d", d1, d2 ) & " days old."
        print "You are " & DateDiff( "s", d1, d2 ) & " seconds old"
else
        print "Invalid date"
end if

dim time1 as Double = DateSerial(2023, 12, 25) + TimeSerial(7, 30, 00)

print
print format(time1, "yyyy/mm/dd hh:mm:ss "); Year(time1)
print format(d1, "yyyy/mm/dd hh:mm:ss "); Year(d1)
print format(d2, "yyyy/mm/dd hh:mm:ss "); Year(d2)

end

' *** End Of File ***