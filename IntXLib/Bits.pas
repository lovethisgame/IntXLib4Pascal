unit Bits;

{
  * Copyright (c) 2015 Ugochukwu Mmaduekwe ugo4brain@gmail.com

  *   This Source Code Form is subject to the terms of the Mozilla Public License
  * v. 2.0. If a copy of the MPL was not distributed with this file, You can
  * obtain one at http://mozilla.org/MPL/2.0/.

  *   Neither the name of Ugochukwu Mmaduekwe nor the names of its contributors may
  *  be used to endorse or promote products derived from this software without
  *  specific prior written permission.

}

interface

type
  /// <summary>
  /// Contains helping methods to with with bits in dword (<see cref="UInt32" />).
  /// </summary>

  TBits = class

  public
    class function Nlz(x: UInt32): Integer; static;
    class function Msb(x: UInt32): Integer; static;
    class function CeilLog2(x: UInt32): Integer; static;
  end;

implementation

/// <summary>
/// Returns number of leading zero bits in int.
/// </summary>
/// <param name="x">UInt32 value.</param>
/// <returns>Number of leading zero bits.</returns>

class function TBits.Nlz(x: UInt32): Integer;
var
  n: Integer;
begin
  if (x = 0) then
  begin
    result := 32;
    exit;
  end;

  n := 1;
  if ((x shr 16) = 0) then
  begin
    n := n + 16;
    x := x shl 16;
  end;

  if ((x shr 24) = 0) then
  begin
    n := n + 8;
    x := x shl 8;
  end;

  if ((x shr 28) = 0) then
  begin
    n := n + 4;
    x := x shl 4;
  end;

  if ((x shr 30) = 0) then
  begin
    n := n + 2;
    x := x shl 2;
  end;

  result := n - Integer(x shr 31);
end;

/// <summary>
/// Counts position of the most significant bit in int.
/// Can also be used as Floor(Log2(<paramref name="x" />)).
/// </summary>
/// <param name="x">UInt32 value.</param>
/// <returns>Position of the most significant one bit (-1 if all zeroes).</returns>

class function TBits.Msb(x: UInt32): Integer;
begin

  result := 31 - Nlz(x);

end;

/// <summary>
/// Ceil(Log2(<paramref name="x" />)).
/// </summary>
/// <param name="x">UInt32 value.</param>
/// <returns>Ceil of the Log2.</returns>

class function TBits.CeilLog2(x: UInt32): Integer;
var
  Msb: Integer;

begin
  Msb := TBits.Msb(x);
  if (x <> UInt32(1) shl Msb) then
  begin
    Inc(Msb);
  end;
  result := Msb;
end;

end.
