--do not use

local ffi = require("ffi")
local cmatch = ffi.load("module/mydll")

ffi.cdef[[

typedef struct slre_cap {
  const char *ptr;
  int len;
} slre_cap;

typedef struct RETVAL {
  int ok;
  char *error;
  slre_cap *val;
} RETVAL;

RETVAL greet(const char *regexp, const char *buf, int num);

]]

local function match (string,regex,num)
    
    local val_table = {}
    
    if ( num == nil ) then
        num = 25
    else
        assert (
            type(num)== 'number',
            'third argument must be a number of expected matches you want to capture'
        )
    end
    
    local t = cmatch.greet(string, regex, num);
    
    local nfound = t.ok
    
    if (nfound > 0) then
        local i = 0
        while true do
            local slength = tonumber(t.val[i].len);
            nfound = nfound - slength
            if (nfound < 0) then
                break
            else
                local str = ffi.string(t.val[i].ptr,slength)
                i = i+1;
                val_table[i] = str
            end
        end
    else
        val_table['error'] =  ffi.string(t.error,150)
    end
    return val_table
end

i = 0;


--stress test
--repeat
--    i = i+1
--    local t = match(
--        " Bddddddd /index.html HTTP/1.3\r\n\r\n",
--        "\\s*(\\S+)\\s+(\\S+)\\s+HTTP/(\\d)\\.(\\s)"
--    );
--    
--   print(t.error)
--until i == 100000

