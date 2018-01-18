// import std.stdio : println = writeln;

import core.stdc.stdlib : alloca;
import core.stdc.stdio : printf;

// extern (C) void* _d_arraycopy;

enum toStringzMaxLength = 5;

immutable(char)* toStringz(in string str,
    scope return void* buf = alloca(toStringzMaxLength + 1)) pure
{
    enum maxLength = toStringzMaxLength;

    if (str.length == 0)
        return "".ptr;

    immutable pointer = str.ptr + str.length;

    if ((cast(size_t) pointer & 3) && *pointer == 0)
        return &str[0];

    auto len = str.length > maxLength ? maxLength : str.length;
    char[] buffer = cast(char[]) buf[0 .. len + 1];
    buffer[0 .. len] = str[0 .. len];
    buffer[len] = '\0';
    debug printf("aaaaaaaaaaaaaaaaaaa\n");
    return buffer[0 .. len + 1].ptr;
}

extern (C) int main(int c, char** v)
{
    string s = "123456";
    auto a = s.toStringz;
    printf("%s\n", a);
    return 0;
}

