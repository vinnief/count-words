import std.algorithm, std.conv, std.ctype, std.regex,
std.range, std.stdio, std.string;
struct PersonaData {
uint totalWordsSpoken;
uint [string] wordCount;
}

void addParagraph(string line, ref PersonaData[string] info) {
    // Figure out persona and sentence
    line = strip(line);
    auto sentence = std.algorithm.find(line,". ");
    if (sentence.empty) {
        return;
    }
   
    auto persona = line[0 .. $- sentence.length];
    sentence = tolower(strip(sentence[2 ..$]));
    // Get the words spoken
    auto words = std.regex.split(sentence, regex("[ \t,.;:?]+"));
    // Insert or update information
    if (!(persona in info)) {
        // First time this persona speaketh
        info[persona] = PersonaData();
    }
    info[persona].totalWordsSpoken += words.length;
    foreach (word; words) ++info[persona].wordCount[word];
}

void printResults(PersonaData[string] info) {
    foreach (persona, data; info) {
        writefln(" %20s %6u %6u", persona, data.totalWordsSpoken,
                data.wordCount.length);
    }
}

void main() {
    // Accumulates information about dramatis personae
    PersonaData[string] info;
    // Fill info
    string currentParagraph;
    foreach (line; stdin.byLine()) {
        if (line.startsWith("    ")
        && line.length > 4
        && isalpha(line[4])) {
            // Persona is continuing a Line
            currentParagraph ~= line[3..$];
        } else if (line.startsWith(" ")
        && line.length > 2
        && isalpha(line[2])) {
            // Persona just started speaking
            addParagraph(currentParagraph, info);
            currentParagraph = to!string(line[2..$]);
        }
    }
    // Done, now print collected information
    printResults(info);
}
