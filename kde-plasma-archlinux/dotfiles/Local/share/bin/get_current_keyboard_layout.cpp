#include <array>
#include <iosfwd>
#include <iostream>
#include <memory>
#include <string>
#include <vector>
std::string exec(const char* cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), static_cast<int>(buffer.size()), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    return result;
}

std::vector<std::string> split(std::string& layout_text) {
    std::vector<std::string> text;
    std::string cur = "";
    for (int i = 0; i < layout_text.size(); i++) {
        if (layout_text[i] == ' ' || layout_text[i] == '\n' || layout_text[i] == '\t') {
            if (!cur.empty()) {
                text.push_back(cur);
                cur.clear();
            }
        } else {
            cur += layout_text[i];
        }
    }
    return text;
}

int main() {
    std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);
    std::string layout_text = exec("hyprctl devices");
    std::vector<std::string> text = split(layout_text);
    for (int i = 0; i < text.size(); i++) {
        if (text[i] == "yes") {
            for (int j = i; j > 0; j--) {
                if (text[j] == "keymap:") {
                    std::cout << text[j + 1];
                    return 0;
                }
            }
        }
    }
    return 0;
}