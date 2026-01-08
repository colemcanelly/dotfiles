#include <iostream>
#include <string>
#include <vector>

// using namespace std;
using std::cout, std::endl;

void generateColorTable(std::vector<std::string> & color_table)
{
    int row = 0;
    const int FG_NORMAL = 30, BG_NORMAL = 40, FG_BRIGHT = 90, BG_BRIGHT = 100;
    std::string cur_fg_normal = "", cur_bg_normal = "", cur_fg_bright = "", cur_bg_bright = "";
    const std::string colors[8] = {"Black", "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White"};

    color_table.at(row++).append("┌─────────┬───────────┬───────────┐  ");
    color_table.at(row++).append("│         │  Normal   │  Bright   │  ");
    color_table.at(row++).append("│         ├─────┬─────┼─────┬─────┤  ");
    color_table.at(row++).append("│  COLOR  │  FG │  BG │  FG │  BG │  ");
    color_table.at(row++).append("├─────────┼─────┼─────┼─────┼─────┤  ");
    std::string table_row =      "│         │     │     │     │     │  ";
    std::string cur_row = table_row;

    for (int i = 0; i < 8; ++i)
    {
        cur_fg_normal = std::to_string(i + FG_NORMAL);
        cur_bg_normal = std::to_string(i + BG_NORMAL);
        cur_fg_bright = std::to_string(i + FG_BRIGHT);
        cur_bg_bright = std::to_string(i + BG_BRIGHT);
        cur_row.replace(4, colors[i].length(), colors[i]);
        cur_row.replace(17, cur_fg_normal.length(), cur_fg_normal);
        cur_row.replace(25, cur_bg_normal.length(), cur_bg_normal);
        cur_row.replace(33, cur_fg_bright.length(), cur_fg_bright);
        cur_row.replace(40, cur_bg_bright.length(), cur_bg_bright);
        cur_row.insert(43, "\033[0m");
        cur_row.insert(40, "\033[" + cur_bg_bright + "m");
        cur_row.insert(35, "\033[0m");
        cur_row.insert(33, "\033[" + cur_fg_bright + "m");
        cur_row.insert(27, "\033[0m");
        cur_row.insert(25, "\033[" + cur_bg_normal + "m");
        cur_row.insert(19, "\033[0m");
        cur_row.insert(17, "\033[" + cur_fg_normal + "m");
        color_table.at(row++).append(std::move(cur_row));
        cur_row = table_row;
    }
    color_table.at(row).append("└─────────┴─────┴─────┴─────┴─────┘  ");
}

void generateStyleTable(std::vector<std::string> & style_table)
{
    int row = 0;
    style_table.at(row++).append("┌─────────────────────┐\n");
    style_table.at(row++).append("│ Styles              │\n");
    style_table.at(row++).append("├───┬─────────────────┤\n");

    const std::string styles[10] = {"Reset / Normal", "Bold", "Darker Color", "Italic", "Underline", "Blinking (slow)", "Blinking (fast)", "Reverse", "Hide", "Cross-out"};
    std::string table_row = "│   │                 │\n";
    std::string cur_row = table_row;
    for (int i = 0; i < 10; ++i)
    {
        cur_row.replace(4, 1, std::to_string(i));
        cur_row.replace(10, styles[i].length(), styles[i]);
        if (i == 8) cur_row.replace(10 + 1 + styles[i].length(), styles[i].length() + 2, "(" + styles[i] + ")");
        
        cur_row.insert(10 + styles[i].length(), "\033[0m");
        cur_row.insert(10, "\033[" + std::to_string(i) + "m");
        style_table.at(row++).append(std::move(cur_row));
        cur_row = table_row;
    }

    style_table.at(row++).append("└───┴─────────────────┘\n");
}

int main()
{
    std::string templ = 
        "\t┌──────────────────────────────────────────────────────────┐\n"
        "\t│                        ANSI COLORS                       │\n"
        "\t└──────────────────────────────────────────────────────────┘\n"
        "\t  ┌───────┤\\033├─── Escape character (ESC)                 \n"
        "\t  │ ┌─────┤ [  ├─── Define a sequence/code                  \n"
        "\t  │ │┌────┤ X  ├─── Parameter (optional)                    \n"
        "\t  │ ││┌───┤ ;  ├─── Parameter separator                     \n"
        "\t  │ │││┌──┤ Y  ├─── Parameter (optional)                    \n"
        "\t  │ ││││┌─┤ m  ├─── SGR Code  →  \"Select Graphic Rendition\"\n"
        "\t  │ │││││                                                   \n"
        "\t\\033[X;Ym                                                  \n";

    std::vector<std::string> lines{14, "\t"};
    generateColorTable(lines);
    generateStyleTable(lines);
    for (std::string& line : lines) {
        templ.append(line);
    }
    cout << templ << endl;

    // cout << "\n╭╴\n╰╴" << endl;
        // ┌──────────────────────────────────────────────────────────┐
        // │ EXAMPLES                                                 │
        // ├──────────────┬───────────────────────────────────────────┤
        // │ Code         │ Description                               │
        // ├──────────────┼───────────────────────────────────────────┤
        // │              │                                           │
        // │              │                                           │
        // │              │                                           │
        // │              │                                           │
        // └──────────────┴───────────────────────────────────────────┘

    // ╭ ╮ ╯ ╰
    // ╰
    // ┌ ┐ ┘ └
    // ├ ┤ ┬ ┴
    // ┼
    // ╴ ╵ ╶ ╷ │ ─
}