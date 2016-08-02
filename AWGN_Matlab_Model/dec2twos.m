function t = dec2twos(x, nbits)

% Credits: 
% Copyright (c) 2012, Drew Compston
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
% 
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.

% DEC2TWOS Convert decimal integer to binary string two's complement.
% 
% Usage: T = DEC2TWOS(X, NBITS)
% 
% Converts the signed decimal integer given by X (either a scalar, vector,
% or matrix) to the two's complement representation as a string. If X is a
% vector or matrix, T(i, :) is the representation for X(i) (the shape of X
% is not preserved).
% 
% Example:
%     >> dec2twos([23 3 -23 -3])
%     
%     ans =
%     
%     010111
%     000011
%     101001
%     111101
% 
% Inputs:
%   -X: decimal integers to convert to two's complement.
%   -NBITS: number of bits in the representation (optional, default is the
%   fewest number of bits necessary).
% 
% Outputs:
%   -T: two's complement representation of X as a string.
% 
% See also: TWOS2DEC, DEC2FIX, FIX2DEC, DEC2BIN, DEC2HEX, DEC2BASE.

error(nargchk(1, 2, nargin));
x = x(:);
maxx = max(abs(x));
nbits_min = nextpow2(maxx + (any(x == maxx))) + 1;

% Default number of bits.
if nargin == 1 || isempty(nbits)
    nbits = nbits_min;
elseif nbits < nbits_min
    warning('dec2twos:nbitsTooSmall', ['Minimum number of bits to ' ...
        'represent maximum input x is %i, which is greater than ' ...
        'input nbits = %i. Setting nbits = %i.'], ...
        nbits_min, nbits, nbits_min)
    nbits = nbits_min;
end

t = repmat('0', numel(x), nbits); % Initialize output:  Case for x = 0
if any(x > 0)
    t(x > 0, :) = dec2bin(x(x > 0), nbits);           % Case for x > 0
end
if any(x < 0)
    t(x < 0, :) = dec2bin(2^nbits + x(x < 0), nbits); % Case for x < 0
end