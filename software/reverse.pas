(*
 **   vim: syntax=pascal nowrap tabstop=3:
 **
 ***    Author: David Billsbrough 
 ***   Created: Tuesday, September 03, 2024 at 01:33:57 AM (EDT)
 ***   License: GNU General Public License -- version 2
 ***   Version: $Revision: 0.23 $
 ***  Warranty: None
 ***
 ***   Purpose: a port of the book of 100 BASIC GAMES called: REVERSE.BAS
 **
 *)

{ $Id: reverse.pas,v 0.23 2024/09/03 07:16:08 kc4zvw Exp kc4zvw $ }

program Reverse;

const
	N = 9;

type
	List = array [1 .. N] of Integer;

var
	A				: List;
	Winning		: List;
	Ask			: String[5];  { prompt for instructions}
	AnotherGame	: Boolean;
	InOrder		: Boolean;
	TryCount		: Integer;
	NumReverse	: Integer;

(* ------------------------------------------------------------ *)

procedure Tabulate( num : Integer );

const
	Tab = ^I;

var
	i : Integer;

begin
	for i := 1 to num do
		Write( Tab );
end;

(* ------------------------------------------------------------ *)

procedure DisplayTitle;
begin
	WriteLn;
	Tabulate(4); WriteLn('   REVERSE');
	Tabulate(2); WriteLn('   Creative Computing - Morristown, New Jersey');
	WriteLn;
	WriteLn;
end;

(* ------------------------------------------------------------ *)

function Range(First : Integer; Last : Integer) : Integer;

begin
	Range := Trunc( Random() * (Last - First + 1)) + First
end;

(* ------------------------------------------------------------ *)

procedure Swap2(var a : array of Integer; num1, num2 : Integer);

var tmp: Integer;

begin
	tmp := A[num1];
	A[num1] := A[num2];
	A[num2] := tmp;
end;

(* ------------------------------------------------------------ *)

procedure Shuffle(var a : array of Integer);

var
	 n, k : Integer;

begin
	for n := Low(a) to High(a) - 1 do begin
		k := Range(n, High(a));
		Swap2( a, n, k );
	end;
end;
     

(* ------------------------------------------------------------ *)

(* Remark *** Shuffle a random list A[1] to A[n] *)

procedure MakeRandomList;

var i : Integer;

begin
	for i := 1 to N do begin
		A[i] := SmallInt(i);
		Winning[i] := SmallInt(i);
	end;

	Shuffle(A);

	{ for i := 1 to N do begin
	    Write( Winning[i]:3 );
	end; }

	WriteLn;
end;

(* ------------------------------------------------------------ *)

(* Remark *** Subroutine to print list *)

procedure DisplayNumbers;

var k : Integer;

begin
	WriteLn;
	for k := 1 to N do begin
		Write(A[k]:3);
	end;
	WriteLn;
	WriteLn;
end;

(* ------------------------------------------------------------ *)

(* Remark *** Reverse R numbers and print new list *)

procedure ReverseNumbers;

var
	k : Integer;
	z : Integer;

begin
	for k := 1 to SmallInt(NumReverse div 2) do begin
		(* Swap2( A, k, NumReverse-k+1 ); *)
		z := A[k];
		A[k] := A[NumReverse-k+1];
		A[NumReverse-k+1] := z;
	end; { for K }

	DisplayNumbers;
end;

(* ------------------------------------------------------------ *)

(* Remark *** ask for another game *)

procedure PlayAgain;

var Ask2 : string;

begin
	WriteLn('Try again (Yes or No)');

	ReadLn( Ask2 );
	Ask2 := UpCase(Ask2);

	if ((Ask2 = 'YES') or (Ask2 = '')) then 
		AnotherGame := True
	else
		AnotherGame := False;
end;

(* ------------------------------------------------------------ *)

(* Remark *** Check for a win *)

function CheckForWinner : Boolean;

var k : Integer;

begin
	InOrder := False;

	for k := 1 to N do begin
		if A[k] = Winning[k] then begin
			InOrder := True
		end else begin
			InOrder := False;
			break;
		end;
	end;

	if InOrder = False then begin
		CheckForWinner := False;
		Exit;
	end;

	WriteLn('You won it in ', TryCount, ' moves!!');
	WriteLn;

	PlayAgain;

	CheckForWinner := True;
end;

(* ------------------------------------------------------------ *)

(* Remark *** Print original list and start game *)

procedure MainLoop;
begin
	InOrder := False;

	WriteLn;
	WriteLn('Here we go ... The list is:');
	TryCount := 0;
	DisplayNumbers();

	repeat
		Write('How many shall I reverse? : ');
		ReadLn( NumReverse );

		if NumReverse = 0 then PlayAgain;

		if NumReverse <= N then
			ReverseNumbers
		else
			WriteLn('Oops! Too many! I can reverse at most', N );

		InOrder := CheckForWinner;

		Inc(TryCount);
	until InOrder = True;
end;

(* ------------------------------------------------------------ *)

(* Remark *** Subroutine to print the rules *)

procedure DisplayTheRules;
begin
	WriteLn;
	WriteLn('This is the game of ''REVERSE''.  To win, all you have');
	WriteLn('to do is arrange a list of numbers (1 through ', N, ')');
	WriteLn('in numerical order from left to right.  To move, you');
	WriteLn('tell me how many numbers (Counting from the left) to');
	WriteLn('reverse.  For example, if the current list is:');
	WriteLn;
	WriteLn( '   2 3 4 5 1 6 7 8 9');
	WriteLn;
	WriteLn( 'and you reverse 4, the result will be:');
	WriteLn;
	WriteLn( '   5 4 3 2 1 6 7 8 9');
	WriteLn;
	WriteLn( 'Now if you reverse 5, you win!');
	WriteLn;
	WriteLn( '   1 2 3 4 5 6 7 8 9');
	WriteLn;
	WriteLn( 'No doubt you will like this game, but');
	WriteLn( 'if you want to quit, reverse 0 (zero).');
	WriteLn;
end;

(* ------------------------------------------------------------ *)
(*   Main program begins here   *)
(* ------------------------------------------------------------ *)

begin
	AnotherGame := True;

	Randomize;

	DisplayTitle();
	MakeRandomList;

	WriteLn('REVERSE -- A Game of Skill');
	WriteLn;
	Write('Do you want the rules? : ');
	ReadLn( Ask );
	Ask := Upcase(Ask);

	if Ask = 'YES' then DisplayTheRules;

	repeat
		MainLoop;
	until AnotherGame = False;

	WriteLn;
	WriteLn('O.K.  Hope you had fun!!');

	Halt(0);
end.

(*  End of File  *)
