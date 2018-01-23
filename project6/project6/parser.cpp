
#include <iostream>
#include <string>
#include <array>

using namespace std;

typedef void (^callback_t)(const string&);

struct my {
    void parse(callback_t callback) {
        
    }
};

//struct my {
//    int state = 0;
//    string s;
//    pair<bool,string> next() {
//        if (state == 0) {
//
//        } else if (state == 1) {
//            return pair<bool,string>(true,std::move(s));
//        }
//    }
//};

struct parser {
    string s1, s2, s3;
    bool valid() const {
        return !startsWith("(lldb) ")
        && !startsWith("__")
        && notEquals("alloc")
        && notEquals("release")
        && notEquals("retain")
        && notEquals("autorelease")
        && notEquals("copy")
        && notEquals("class")
        && notEquals("init")
        && notEquals("_tryRetain")
        && notEquals("self");
    }
    bool notEquals(const string& s) const {
        return !(equals(s1, s) || equals(s2, s) || equals(s3, s));
    }
    bool equals(const string& s, const string& t) const {
        return s.compare(t) == 0;
    }
    bool startsWith(const string& s) const {
        return startsWith(s1, s) || startsWith(s2, s) || startsWith(s3, s);
    }
    bool startsWith(const string& s, const string& t) const {
        if (s.size() < t.size()) return false;
        string d = s.substr(0,t.size());
        return t.compare(d) == 0;
    }
    string text() const {
        string t { s3 };
        return t.append("::").append(s2[0] == '(' ? s1 : s2);
    }
    bool parse() {
        return next1(s1) && next2(s2) && next2(s3);
    }
private:
    static bool read(string& t) {
        array<char, 100> buf;
        cin.getline(&buf[0], buf.size());
        if (cin.rdstate() == ios_base::goodbit && buf[0]) {
            t = &buf[0];
            return true;
        }
        return false;
    }
    static bool next1(string& t) {
        while (cin.rdstate() == ios_base::goodbit) {
            if (read(t)) return true;
        }
        return false;
    }
    static bool next2(string& t) {
        return cin.rdstate() == ios_base::goodbit && read(t);
    }
        
};

int main() {
    parser p;
    while (p.parse()) {
        if (p.valid()) {
            cout << p.text() << '\n';
        }
    }
}
