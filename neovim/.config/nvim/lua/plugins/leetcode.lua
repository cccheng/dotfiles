return {
    "kawre/leetcode.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        -- "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        arg = "leetcode",
        lang = "cpp",
        injector = {
            ["cpp"] = {
                before = {
                    "#include <bits/stdc++.h>",
                    "using namespace std;",
                    "",
                    "using i32 = int32_t;",
                    "using u32 = uint32_t;",
                    "using i64 = int64_t;",
                    "using u64 = uint64_t;",
                    "using pii = pair<i32,i32>;",
                    "using pll = pair<i64,i64>;",
                    "constexpr i32 i32max = numeric_limits<i32>::max();",
                    "constexpr i32 i32min = numeric_limits<i32>::min();",
                    "constexpr u32 u32max = numeric_limits<u32>::max();",
                    "constexpr u32 u32min = numeric_limits<u32>::min();",
                    "constexpr i64 i64max = numeric_limits<i64>::max();",
                    "constexpr i64 i64min = numeric_limits<i64>::min();",
                    "constexpr u64 u64max = numeric_limits<u64>::max();",
                    "constexpr u64 u64min = numeric_limits<u64>::min();",
                    "constexpr i32 MOD     = 1'000'000'007; // 1e9+7",
                    "#define ceil(n, m)  (((n) + (m) - 1) / (m))",
                    "#define all(vec)    (vec).begin(), (vec).end()",
                    "#define rall(vec)   (vec).rbegin(), (vec).rend()",
                },
                after = {
                    "int main(void)",
                    "{",
                    "    ios_base::sync_with_stdio(false), cin.tie(nullptr), cout.tie(nullptr);",
                    "",
                    "",
                    "    return 0;",
                    "}"
                }
            }
        }
    },
}
