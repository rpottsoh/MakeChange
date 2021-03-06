unit uMakeChangeTests;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TMakeChangeTests = class(TObject)
  public
    [Test]
    procedure Test_coinsToInt;
    [Test]
    [TestCase('Expecting 1280001','6400000,1280001,1|5')]
    [TestCase('Expecting 6400000 w/only pennies','6400000,1,1')]
    [TestCase('Expecting 49'     ,'50,49,1|5|10|25')]
    [TestCase('Expecting 242'    ,'100,242,1|5|10|25')]
    [TestCase('Expecting 34952901974464001','6400000,34952901974464001,1|5|10|25')]
    procedure MakeChangeTest(const aAmount: integer;
      const aExpected : int64; const aCoins : string);
  end;

implementation
uses System.SysUtils, Spring.Collections, uMakeChange;

function coinsToInt(const aValue: string): TArray<integer>;
var sCoins: TArray<string>;
         s: integer;
begin
 sCoins := aValue.Split(['|']);
 SetLength(Result, length(sCoins));
 for s := 0 to length(sCoins) - 1 do
   result[s] := sCoins[s].ToInteger;
end;

procedure TMakeChangeTests.Test_coinsToInt;
var Input : string;
    Expected : TArray<integer>;
    Actual : TArray<integer>;
    i: integer;
begin
  SetLength(Expected, 4);
  Expected[0] := 1;
  Expected[1] := 5;
  Expected[2] := 10;
  Expected[3] := 25;
  Input := '1|5|10|25';
  Actual := coinsToInt(Input);
  assert.AreEqual(Expected, Actual);
end;

procedure TMakeChangeTests.MakeChangeTest(const aAmount: integer;
  const aExpected : int64; const aCoins : string);
begin
  assert.AreEqual(aExpected, MakeSomeChange(aAmount, coinsToInt(aCoins)));
end;

initialization
  TDUnitX.RegisterTestFixture(TMakeChangeTests);
end.
