#!/usr/bin/rdmd
import  std.stdio, std.string, std.algorithm, std.encoding, std.file ;
//, std.ctype,std.range;

const byte a= 96; //"a"-1;

int computeValue (string word){
    int s;
    foreach(char letter; (tolower(word))){
        s+=letter-a;
    }
    return (s);
}

void main(char[][] args) {
    int cumsum, lettersum;
    // read text from console and Compute counts
    uint[string] freqs;
    auto f= File ("../Euler/p22names.txt","r");
    string s= f.readln();
    f.close;
        foreach (word; std.string.split(strip(s),",")) {
            ++freqs[word.idup];
        }
    
    // Print counts
    string[] words = freqs.keys;
    sort!((a,b){return std.string.icmp(a,b)<0;})(words);//alphabetical sort
    f = File("wordvalues.txt", "w"); // open for writing
    f.writeln("index, word, lettersum, Frequencies, ");
    foreach (index,word; words) {
        lettersum = computeValue(word);
        cumsum+= lettersum*(index+1);
        f.writefln("%6u\t%s\t%6u" ,index+1, word, lettersum, freqs[word.idup] ) ;
    }
    f.writefln("total sum is %s", cumsum);
    f.close;
    writefln("total sum is %s", cumsum);
}
