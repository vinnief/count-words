import std.stdio, std.string, std.algorithm,std.conv, std.ctype, std.regex,
std.range, std.file;
struct PersonaData {
    uint totalWordsSpoken;
    uint [string] wordCount;
}
void main(char[][] args) {
    // Compute counts
    uint[string] freqs;
    foreach (line; stdin.byLine()) {//read from console input
        foreach (word; std.string.split(strip(line))) {
            ++freqs[word.idup];
        }
    }
    // Print counts
    string[] words = freqs.keys;
    sort!((a,b){return freqs[a] > freqs[b];})(words);
    auto f = File("annafreqs.txt", "w"); // open for writing
    f.write("Frequencies");
    foreach (word; words) {
    f.writefln("%6u\t%s" , freqs [word] , word) ;
    }
    /*foreach (key, value; freqs) {
        writefln(" %6u   %s", value, key);
        }*/
}
