import std.stdio, std.string, std.algorithm,std.conv, std.ctype, std.regex,
std.range, std.file;
struct PersonaData {
    uint totalWordsSpoken;
    uint [string] wordCount;
}


void main(char[][] args) {
    // Compute counts
    uint[string] freqs;
    auto f = File("hamlet.txt", "r"); // open for reading
    string line;
    while (!f.eof()){
    line = f.readln();
        //foreach ( line; f.readln()) { 
        foreach (word; std.string.split(strip(line.dup))) {
            ++freqs[word.idup];
        }
    }
    f.close;
    // Print counts
// Print counts
    string[] words = freqs.keys;
    sort!((a,b){return freqs[a] > freqs[b];})(words);
    f = File("freqs.txt", "w"); // open for writing
    f.writeln("Freqs word");
    foreach (word; words) {
    f.writefln("%6u\t%s" , freqs [word] , word) ;
    }
    /*foreach (key, value; freqs) {
        writefln(" %6u   %s", value, key);
        }*/
}
